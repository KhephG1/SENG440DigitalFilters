#ifndef IIR_FILTER_CORE_H
#define IIR_FILTER_CORE_H

#include "coefficient_loader.h"
#include "input_data_loader.h"
#include <stddef.h>
#include <stdint.h>
void iir_filter(const input_data_t *input, int16_t *output,
                uint32_t input_length, filter_t *filter);

#endif
