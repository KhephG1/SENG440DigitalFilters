#include "iir_filter_core.h"
#include "coefficient_loader.h"
#include "input_data_loader.h"
#include "overflow_handler.h"
#include "mac_unit.h"

#include <limits.h>
#include <stdint.h>
#include <stdio.h>

void iir_filter_fixed_point_with_unrolling(const input_data_t *__restrict input,
                                           int16_t *__restrict output,
                                           uint32_t input_length,
                                           filter_t *__restrict filter)
{
    // compute the shifts to be applied (denominator coeffcients scaled with
    // different factor than numerator coefficients)
    const int num_sf = filter->num_scale_factor_exp;
    const int den_sf = filter->den_scale_factor_exp;
    const int acc_sf = (num_sf > den_sf) ? num_sf : den_sf;
    const int num_shift = acc_sf - num_sf;
    const int den_shift = acc_sf - den_sf;
    const int64_t round_add = (int64_t)1 << (acc_sf - 1);

    // store coefficients as local variables
    const int16_t x0 = filter->x[0];
    const int16_t x1 = filter->x[1];
    const int16_t x2 = filter->x[2];
    const int16_t y1 = filter->y[1];
    const int16_t y2 = filter->y[2];
    // use a separate restrict pointer for the data buffer within the struct
    // guarantees to the compiler that input->input_data_buffer does not alias
    // with output
    // goal of above is to get the compiler to keep coefficienst and accumulator
    // in registers
    const int16_t *__restrict in = input->input_data_buffer;
    const int len = (int)input_length;
    // initialize the filter
    if (len > 0)
    {
        int64_t num_acc = (int64_t)x0 * in[0];
        int64_t total = num_acc << num_shift;
        total = (total + round_add) >> acc_sf;
        output[0] = saturate(total);
    }
    if (len > 1)
    {
        int64_t num_acc = (int64_t)x0 * in[1] + (int64_t)x1 * in[0];
        int64_t den_acc = (int64_t)y1 * output[0];
        int64_t total = (num_acc << num_shift) - (den_acc << den_shift);
        total = (total + round_add) >> acc_sf;
        output[1] = saturate(total);
    }

    for (int i = 2; i < len; i++)
    {
        int64_t num_acc = (int64_t)x0 * in[i] + (int64_t)x1 * in[i - 1] +
                          (int64_t)x2 * in[i - 2];
        int64_t den_acc =
            (int64_t)y1 * output[i - 1] + (int64_t)y2 * output[i - 2];
        int64_t total = (num_acc << num_shift) - (den_acc << den_shift);
        total = (total + round_add) >> acc_sf;
        output[i] = saturate(total);
    }
}

void iir_filter_fixed_point(const input_data_t *input, int16_t *output,
                            uint32_t input_length, filter_t *filter)
{
    const int num_sf = filter->num_scale_factor_exp;
    const int den_sf = filter->den_scale_factor_exp;
    const int acc_sf = (num_sf > den_sf) ? num_sf : den_sf;

    // run the filter
    for (int i = 0; i < (int)input_length; i++)
    {
        // int16 * int16 accumulated at full precision; the sum can overflow
        // depending on the input
        int64_t num_acc = 0;
        for (int j = 0; j < filter->x_coeffs; j++)
        {
            if (i >= j)
            {
                num_acc += (int64_t)filter->x[j] *
                           (int64_t)input->input_data_buffer[i - j];
            }
        }

        // assumes the denominator is normalised so y[0] == 1.0
        int64_t den_acc = 0;
        for (int j = 1; j < filter->y_coeffs; j++)
        {
            if (i >= j)
            {
                den_acc += (int64_t)filter->y[j] * (int64_t)output[i - j];
            }
        }
        // for addition must ensure same scale factors
        int64_t total =
            (num_acc << (acc_sf - num_sf)) - (den_acc << (acc_sf - den_sf));
        // round to nearest on the way back down to the input scale
        total = (total + (1 << (acc_sf - 1))) >> acc_sf;
        output[i] = saturate(total);
    }
}

void iir_filter_fixed_point_mac(const input_data_t *input, int16_t *output,
                                uint32_t input_length, filter_t *filter)
{
    const int num_sf = filter->num_scale_factor_exp;
    const int den_sf = filter->den_scale_factor_exp;
    const int acc_sf = (num_sf > den_sf) ? num_sf : den_sf;

    for (int i = 0; i < (int)input_length; i++)
    {
        int64_t num_acc = 0;

        for (int j = 0; j < filter->x_coeffs; j++)
        {
            if (i >= j)
            {
                num_acc = mac_inline(num_acc, filter->x[j], input->input_data_buffer[i - j]);
            }
        }

        int64_t den_acc = 0;

        for (int j = 1; j < filter->y_coeffs; j++)
        {
            if (i >= j)
            {
                den_acc = mac_inline(den_acc, filter->y[j], output[i - j]);
            }
        }

        int64_t total =
            (num_acc << (acc_sf - num_sf)) - (den_acc << (acc_sf - den_sf));

        total = (total + ((int64_t)1 << (acc_sf - 1))) >> acc_sf;

        output[i] = saturate(total);
    }
}

// don't use. An attempt at achieving better optimization with tdfII. as
// discussed in
// https://arm-software.github.io/CMSIS-DSP/latest/group__BiquadCascadeDF2T.html
// tdfII should only be used on floating point implementations due to large
// dynamic range requirements
// void iir_filter_biquad(const input_data_t *input, int16_t *output,
//                        uint32_t input_length, biquad_t *biquad)
// {
//     const int16_t sf_diff = biquad->num_sf - biquad->den_sf;
//     int32_t t1 = 0, t2 = 0, t3 = 0, d1 = 0, d2 = 0;
//     for (int i = 0; i < (int)input_length; i++)
//     {
//         int32_t x = input->input_data_buffer[i];
//         t1 = x * biquad->b0;
//         t3 = t1 + d1;
//         output[i] =
//             (int16_t)((t3 + (1 << (biquad->num_sf - 1))) >> biquad->num_sf);
//         printf("output[i]: %d\n", output[i]);
//         t1 = x * biquad->b1;
//         t2 = output[i] * biquad->a1;
//         t2 <<= sf_diff;
//         d1 = t1 - t2 + d2;
//         t1 = x * biquad->b2;
//         t2 = output[i] * biquad->a2;
//         t2 <<= sf_diff;
//         d2 = t1 - t2;
//     }
// }