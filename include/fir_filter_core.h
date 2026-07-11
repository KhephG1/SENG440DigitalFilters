#ifndef FIR_FILTER_CORE_H
#define FIR_FILTER_CORE_H

#include <stddef.h>
#include <stdint.h>

void fir_filter(const int *input, int *output, size_t input_length, const int *coeffs, int scale_factor);

#endif

