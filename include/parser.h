#ifndef PARSER_H
#define PARSER_H

#include <stdint.h>
#define MAX_COEFFS (100)
#define MAX_SAMPLES (300000)
typedef struct filter_t {
    int16_t numerator[MAX_COEFFS];
    int16_t denominator[MAX_COEFFS];
    uint16_t num_coeffs;
    uint16_t den_coeffs;

} filter_t;

typedef enum { FIR = 0, IIR } filter_type;

int load_coefficients(char *filename, filter_type type, filter_t *filter);
int load_accelerometer_data(int16_t *input_data_buffer, uint32_t buffer_size);
#endif