#ifndef IIR_FILTER_CORE_H
#define IIR_FILTER_CORE_H

#include "coefficient_loader.h"
#include "input_data_loader.h"
#include <stddef.h>
#include <stdint.h>

void iir_filter_fixed_point_with_unrolling(const input_data_t *__restrict input,
                                           int16_t *__restrict output,
                                           uint32_t input_length,
                                           filter_t *__restrict filter);
void iir_filter_fixed_point(const input_data_t *input, int16_t *output,
                            uint32_t input_length, filter_t *filter);

void iir_filter_fixed_point_mac(const input_data_t *input, int16_t *output,
                                uint32_t input_length, filter_t *filter);
                                
void iir_filter_naive(const float *input, float *output, uint32_t input_length,
                      float *filter_x, float *filter_y, int *coeffs_x,
                      int *coeffs_y);
void iir_filter_pipelined(const input_data_t *__restrict input,
                          int16_t *__restrict output, uint32_t input_length,
                          filter_t *__restrict filter);
#endif
