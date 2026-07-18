#ifndef TESTS_H
#define TESTS_H
#include "coefficient_loader.h"
#include "input_data_loader.h"
#include <stdint.h>
void test_parser(char *output, input_data_t *input_data, filter_t *filter);
void test_iir_filter(char *outputfile, input_data_t *input_data,
                     filter_t *filter);
void test_fir_filter(char *outputfile, input_data_t *input_data,
                     filter_t *filter);
#endif