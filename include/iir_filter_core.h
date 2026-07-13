#ifndef IIR_FILTER_CORE_H
#define IIR_FILTER_CORE_H

#include "coefficient_loader.h"
#include <stddef.h>
#include <stdint.h>
void iir_filter(const int16_t *input, int *output, size_t input_length,
                filter_t *filter);

#endif
