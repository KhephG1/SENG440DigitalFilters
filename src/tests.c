#include "tests.h"
#include "iir_filter_core.h"
#include "input_data_loader.h"
#include <stdio.h>

void test_parser(char *output, int16_t *input_data, filter_t *filter)
{

    int data_samples = load_accelerometer_data(input_data, MAX_SAMPLES);
    int coeffs = load_coefficients("tools/FIR_filter_coeffs.txt", FIR, filter);
    FILE *file = fopen(output, "w");
    fprintf(file, "data samples: %d coeffs: %d", data_samples, coeffs);
    for (int i = 0; i < data_samples; i++)
    {
        fprintf(file, "input_samples[%d]: %d\n", i, input_data[i]);
    }
    for (int i = 0; i < coeffs; i++)
    {
        fprintf(file, "coeffs[%d]: %d\n", i, filter->x[i]);
    }
}

void test_iir_filter(char *outputfile, int16_t *input_data, filter_t *filter)
{
    int data_samples = load_accelerometer_data(input_data, MAX_SAMPLES);
    int coeffs = load_coefficients("tools/FIR_filter_coeffs.txt", FIR, filter);
    int16_t filter_output[MAX_SAMPLES] = {};
    iir_filter(input_data, &filter_output, data_samples, filter);
    FILE *file = fopen(outputfile, "w");
}