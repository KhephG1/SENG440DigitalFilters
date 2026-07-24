#include <math.h>
#include <stdint.h>
/*
*a function to determine appropriate scale factors
*takes an array of floating point numbers (pointer) and
a buffer of int16_t to store the scaled numbers
*returns the exponent of the scale factor applied to the numbers
*maximizes resolution of the resulting representation
under constraint that scale factor must be a power of 2
*/

int8_t convert_to_fixed(float *input, int16_t *output, uint32_t size,
                        uint32_t representation_max);
