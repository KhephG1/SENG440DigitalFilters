#ifndef TESTS_H
#define TESTS_H
#include "coefficient_loader.h"
#include "input_data_loader.h"
#include <stdint.h>
void test_parser(char *output, input_data_t *input_data, filter_t *filter);
void test_iir_filter(char *outputfile, float *input_data, float *filter_x,
                     float *filter_y, int *coeffs_x, int *coeffs_y);

void test_iir_filter_fixed_point(char *outputfile, input_data_t *input_data,
                                 filter_t *filter);
#endif