#ifndef TESTS_H
#define TESTS_H
#include "coefficient_loader.h"
#include <stdint.h>
void test_parser(char *output, int16_t *input_data, filter_t *filter);
void test_iir_filter(char *outputfile, int16_t *input_data, filter_t *filter);
#endif