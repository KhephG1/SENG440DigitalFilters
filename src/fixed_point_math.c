#include "fixed_point_math.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
// this function converts an array to its fixed point representation. It
// computes the optimal scale factors for you based on the method learned in
// class
// This function finds the optimal scale factor for representing the range of
// inputs in 15 bits
int8_t convert_to_fixed(float *input, int16_t *output, uint32_t size,
                        uint32_t representation_max)
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
    The problem to solve is 2^x <= max(int15) / max_val
    We need to solve for x (take the log!) and round with floor
    */
    int8_t exponent = (int8_t)floorf(log2f(representation_max / max_val));
    if (exponent < 0)
        exponent = 0;
    float scale_factor = ldexpf(1.0f, exponent);
    for (int i = 0; i < (int)size; i++)
    {
        output[i] = (int16_t)roundf(input[i] * scale_factor);
    }

    return exponent;
}