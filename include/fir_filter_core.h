#ifndef FIR_FILTER_CORE_H
#define FIR_FILTER_CORE_H

#include "input_data_loader.h"
#include <stdint.h>

void fir_filter(const input_data_t *input, int16_t *output,
                uint32_t input_length, const int16_t *coeffs,
                int16_t scale_factor, uint32_t coeffs_length);

void fir_filter_saturation(const input_data_t *input, int16_t *output,
                uint32_t input_length, const int16_t *coeffs,
                int16_t scale_factor, uint32_t coeffs_length);

void fir_filter_ssat(const input_data_t *input, int16_t *output,
                uint32_t input_length, const int16_t *coeffs,
                int16_t scale_factor, uint32_t coeffs_length);

void fir_filter_mac(const input_data_t *input, int16_t *output,
                    uint32_t input_length, const int16_t *coeffs,
                    int16_t scale_factor, uint32_t coeffs_length);

void fir_filter_naive(const float *input, float *output, uint32_t input_length,
                      float *filter_x, int *coeffsx);

void fir_filter_neon_helper(const input_data_t *input, int16_t *output,
                            uint32_t input_length, const int16_t *coeffs,
                            int16_t scale_factor, uint32_t coeffs_length);

void fir_filter_neon(const int16_t *input_with_history,  // length: input_length
                                                         // + coeffs_length - 1
                     int16_t *output,                    // length: input_length
                     uint32_t input_length,
                     const int16_t *coeffs,  // length: coeffs_length
                     uint32_t coeffs_length);
#endif
