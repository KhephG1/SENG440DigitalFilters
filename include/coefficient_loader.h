#ifndef COEFFICIENT_LOADER_H
#define COEFFICIENT_LOADER_H

#include <stddef.h>
#include <stdint.h>

#define MAX_COEFFS (100)
typedef struct filter_t {
    int16_t x[MAX_COEFFS];
    int16_t y[MAX_COEFFS];
    uint16_t x_coeffs;
    uint16_t y_coeffs;
    uint8_t num_scale_factor_exp;
    uint8_t den_scale_factor_exp;

} filter_t;

typedef struct {
    int16_t b0, b1, b2;
    int16_t a1, a2;
    uint8_t num_sf;
    uint8_t den_sf;
} biquad_t;

typedef enum { FIR = 0, IIR } filter_type;
int load_coefficients_fixed(const char *filename, filter_type type,
                            filter_t *filter);
int load_biquad_fixed(const char **filenames, biquad_t *biquads,
                      int num_biquads);
int load_coefficients_float(const char *filename, filter_type type,
                            float *filter_x, float *filter_y, int *coeffs_x,
                            int *coeffs_y);
#endif
