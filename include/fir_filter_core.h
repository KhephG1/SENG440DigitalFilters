#ifndef FIR_FILTER_CORE_H
#define FIR_FILTER_CORE_H

#include <stdint.h>
#include "input_data_loader.h"

void fir_filter(const input_data_t *input, int16_t *output, uint32_t input_length,
                const int16_t *coeffs, int16_t scale_factor, uint32_t coeffs_length);

#endif
