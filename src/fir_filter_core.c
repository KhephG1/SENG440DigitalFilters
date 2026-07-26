#include "fir_filter_core.h"
#include "overflow_handler.h"
#include "mac_unit.h"

#include <arm_neon.h>
#include <string.h>

void fir_filter_neon_helper(const input_data_t *input, int16_t *output,
                            uint32_t input_length, const int16_t *coeffs,
                            int16_t scale_factor, uint32_t coeffs_length)
{
    static int16_t history_buf[MAX_SAMPLES + 128];

    if (coeffs_length == 0 || input_length == 0)
        return;

    uint32_t hist = coeffs_length - 1;
    memset(history_buf, 0, hist * sizeof(int16_t));
    memcpy(&history_buf[hist], input->input_data_buffer,
           input_length * sizeof(int16_t));

    fir_filter_neon(history_buf, output, input_length, coeffs, coeffs_length);
}
// scale factor applied must be 15
void fir_filter_neon(const int16_t *input_with_history,  // length: input_length
                                                         // + coeffs_length - 1
                     int16_t *output,                    // length: input_length
                     uint32_t input_length,
                     const int16_t *coeffs,  // length: coeffs_length
                     uint32_t coeffs_length)
{
    uint32_t n = 0;
    // Process 8 output samples per iteration
    for (; n + 8 <= input_length; n += 8)
    {
        int32x4_t acc_lo = vdupq_n_s32(0);
        int32x4_t acc_hi = vdupq_n_s32(0);

        for (uint32_t k = 0; k < coeffs_length; k++)
        {
            // Broadcast one coefficient across a vector
            int16x8_t c = vdupq_n_s16(coeffs[k]);

            // Load 8 input samples: those that pair with tap k for outputs
            // n..n+7 Output n uses input at index (n + N - 1 - k), so for 8
            // consecutive outputs we load 8 consecutive input samples starting
            // there.
            const int16_t *src =
                &input_with_history[n + (coeffs_length - 1) - k];
            int16x8_t x = vld1q_s16(src);

            // Widening multiply-accumulate: int16 * int16 -> int32
            acc_lo = vmlal_s16(acc_lo, vget_low_s16(x), vget_low_s16(c));
            acc_hi = vmlal_s16(acc_hi, vget_high_s16(x), vget_high_s16(c));
        }

        int16x4_t out_lo, out_hi;
        // shift amount needs to be a complile time constant
        out_lo = vqrshrn_n_s32(acc_lo, 15);
        out_hi = vqrshrn_n_s32(acc_hi, 15);

        int16x8_t out = vcombine_s16(out_lo, out_hi);
        vst1q_s16(&output[n], out);
    }

    // Scalar tail for the last <8 samples
    for (; n < input_length; n++)
    {
        int32_t acc = 0;
        for (uint32_t k = 0; k < coeffs_length; k++)
        {
            acc += (int32_t)input_with_history[n + (coeffs_length - 1) - k] *
                   coeffs[k];
        }
        int32_t shifted = (acc + (1 << (15 - 1))) >> 15;
        // saturate
        if (shifted > 32767)
            shifted = 32767;
        if (shifted < -32768)
            shifted = -32768;
        output[n] = (int16_t)shifted;
    }
}

void fir_filter(const input_data_t *input, int16_t *output,
                uint32_t input_length, const int16_t *coeffs,
                int16_t scale_factor, uint32_t coeffs_length)
{
    for (uint32_t n = 0; n < input_length; n++)
    {
        int32_t acc = 0;

        for (uint32_t k = 0; k < coeffs_length; k++)
        {
            if (n >= k)
            {
                acc += (int32_t)input->input_data_buffer[n - k] * coeffs[k];
            }
        }
        output[n] = (int16_t)(acc >> scale_factor);
    }
}

void fir_filter_saturation(const input_data_t *input, int16_t *output,
                uint32_t input_length, const int16_t *coeffs,
                int16_t scale_factor, uint32_t coeffs_length)
{
    for (uint32_t n = 0; n < input_length; n++)
    {
        int32_t acc = 0;

        for (uint32_t k = 0; k < coeffs_length; k++)
        {
            if (n >= k)
            {
                acc += (int32_t)input->input_data_buffer[n - k] * coeffs[k];
            }
        }
        int32_t temp = (int16_t)(acc >> scale_factor);

        output[n] = saturate(temp);
    }
}

void fir_filter_mac(const input_data_t *input, int16_t *output,
                    uint32_t input_length, const int16_t *coeffs,
                    int16_t scale_factor, uint32_t coeffs_length)
{
    for (uint32_t n = 0; n < input_length; n++)
    {
        int64_t acc = 0;

        for (uint32_t k = 0; k < coeffs_length; k++)
        {
            if (n >= k)
            {
                acc = mac(acc, input->input_data_buffer[n - k], coeffs[k]);
            }
        }
        output[n] = saturate(acc >> scale_factor);
    }
}


void fir_filter_naive(const float *input, float *output, uint32_t input_length,
                      float *filter_x, int *coeffsx)
{
    for (uint32_t n = 0; n < input_length; n++)
    {
        float acc = 0;

        for (uint32_t k = 0; k < *coeffsx; k++)
        {
            if (n >= k)
            {
                acc += input[n - k] * filter_x[k];
            }
        }
        output[n] = acc;
    }
}