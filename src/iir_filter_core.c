#include "iir_filter_core.h"
#include "coefficient_loader.h"
#include "input_data_loader.h"
void iir_filter(const input_data_t *input, int16_t *output,
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
        int32_t num_acc = 0;
        for (int j = 0; j < filter->x_coeffs; j++)
        {
            if (i >= j)
            {
                num_acc += filter->x[j] * input->input_data_buffer[i - j];
            }
        }

        // assumes the denominator is normalised so y[0] == 1.0
        int32_t den_acc = 0;
        for (int j = 1; j < filter->y_coeffs; j++)
        {
            if (i >= j)
            {
                den_acc += filter->y[j] * output[i - j];
            }
        }

        int32_t total =
            (num_acc << (acc_sf - num_sf)) - (den_acc << (acc_sf - den_sf));
        // round to nearest on the way back down to the input scale
        total = (total + (1 << (acc_sf - 1))) >> acc_sf;
        output[i] = total;
    }
}