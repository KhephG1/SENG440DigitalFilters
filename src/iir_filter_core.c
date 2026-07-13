#include "iir_filter_core.h"
#include "coefficient_loader.h"

void iir_filter(const int16_t *input, int16_t *output, size_t input_length,
                filter_t *filter)
{
    // run the filter
    for (int i = 0; i < input_length; i++)
    {
        int32_t accumulator = 0;
        for (int j = 0; j < filter->x_coeffs; j++)
        {
            // int16 * int16 = int32 TODO: I think virtual machine has integer
            // multiplier but confirm
            // input SF = 2^6, iir num SF = 2^28, iir den = 2^12 -> temp SF =
            // 2^(6+28-12) = 2^22. add 1 << 21 for rounding
            if (i >= j)
            {
                accumulator +=
                    ((int)filter->x[j] * (int)input[i - j] + (1 << 21)) >> 22;
            }
        }
        for (int j = 1; j < filter->y_coeffs; j++)
        {
            // int16 * int16 = int32
            // input SF = 2^12, iir den SF = 2^12, iir den SF = 2^12 -> temp SF
            // = 2^(12 + 12 - 12) = 2^12
            if (i >= j)
            {
                accumulator +=
                    ((int)filter->y[j] * (int)output[i - j] + (1 << 11)) >> 12;
            }
        }
        output[i] = (int16_t)accumulator;
    }
}