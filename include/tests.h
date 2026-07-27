#ifndef TESTS_H
#define TESTS_H
#include "coefficient_loader.h"
#include "input_data_loader.h"
#include <stdint.h>
// no hardware support for vaddvq on arm32. I think a candidate for a custom
// instruction. think final implementation may involve use of neon MAC
// instructions (fusing vector and DSP instructions) and then hardware support
// for vaddvq to collapse vector into scalar efficiently
void test_parser(char *output, input_data_t *input_data, filter_t *filter);

void test_overflow_handler(void);

void test_iir_filter_fixed(char *outputfile, input_data_t *input_data,
                           filter_t *filter);
void test_iir_filter_fixed_mac(char *outputfile, input_data_t *input_data,
                           filter_t *filter);
void test_iir_biquad_fixed(char *outputfile, input_data_t *input_data);

void test_iir_biquad_fixed_unrolled(char *outputfile, input_data_t *input_data);

void test_fir_filter(char *outputfile, input_data_t *input_data,
                     filter_t *filter);
void test_fir_filter_saturation(char *outputfile, input_data_t *input_data,
                     filter_t *filter);
void test_fir_filter_mac(char *outputfile, input_data_t *input_data,
                     filter_t *filter);
void test_fir_filter_float(char *outputfile, float *input_data, float *filter_x,
                           int *coeffs_x);
void test_fir_filter_neon(char *outputfile, input_data_t *input_data,
                          filter_t *filter);

void test_iir_biquad_neon(char *outputfile, input_data_t *input_data);
void test_iir_biquad_pipelined(char *outputfile, input_data_t *input_data);
#endif