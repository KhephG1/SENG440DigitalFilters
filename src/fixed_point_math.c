#include "fixed_point_math.h"
#include <math.h>
#include <stdlib.h>
int8_t convert_to_fixed(float *input, int16_t *output, uint32_t size)
{
    // find the biggest number in the input
    float max_val = 0;
    for (int i = 0; i < size; i++)
    {
        if (fabsf(input[i]) > max_val)
        {
            max_val = fabsf(input[i]);
        }
    }
    // if all inputs are zero, handle separately
    if (max_val == 0.0f)
    {
        for (int i = 0; i < (int)size; i++)
            output[i] = 0;
        return 0;
    }
    /*
    The problem to solve is 2^x <= max(int16) / max_val
    We need to solve for x (take the log!) and round with floor
    */
    int8_t exponent = (int8_t)floorf(log2f(32767.0f / max_val));
    float scale_factor = ldexpf(1.0f, exponent);
    for (int i = 0; i < (int)size; i++)
    {
        output[i] = (int16_t)roundf(input[i] * scale_factor);
    }

    return exponent;
}