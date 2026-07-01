#ifndef FIXED_POINT_MATH_H
#define FIXED_POINT_MATH_H

#include <stddef.h>
#include <stdint.h>

void convert_to_fixed_point(const int *input, int *output, size_t input_length, int scale_factor);

#endif

