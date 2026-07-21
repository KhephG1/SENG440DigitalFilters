#ifndef IIR_FILTER_CORE_H
#define IIR_FILTER_CORE_H

#include "coefficient_loader.h"
#include "input_data_loader.h"
#include <stddef.h>
#include <stdint.h>
void iir_filter_fixed_point(const input_data_t *input, int16_t *output,
                            uint32_t input_length, filter_t *filter);
void iir_filter_naive(const float *input, float *output, uint32_t input_length,
                      float *filter_x, float *filter_y, int *coeffs_x,
                      int *coeffs_y);
#endif
