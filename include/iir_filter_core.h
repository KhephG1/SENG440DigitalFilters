#ifndef IIR_FILTER_CORE_H
#define IIR_FILTER_CORE_H

#include <stddef.h>
#include <stdint.h>

void iir_filter(const int *input, int *output, size_t input_length, const int *coeffs);

#endif

