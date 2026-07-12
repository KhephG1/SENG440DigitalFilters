#ifndef COEFFICIENT_LOADER_H
#define COEFFICIENT_LOADER_H

#include <stddef.h>
#include <stdint.h>

#define MAX_COEFFS (100)
typedef struct filter_t {
    int16_t numerator[MAX_COEFFS];
    int16_t denominator[MAX_COEFFS];
    uint16_t num_coeffs;
    uint16_t den_coeffs;

} filter_t;
typedef enum { FIR = 0, IIR } filter_type;
int load_coefficients(char *filename, filter_type type, filter_t *filter);
#endif