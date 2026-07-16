#include "tests.h"
#include "fixed_point_math.h"
#include "iir_filter_core.h"
#include <stdio.h>
#define MAX_TEST_SIZE (50)
void test_parser(char *output, input_data_t *input_data, filter_t *filter)
{

    int data_samples = load_accelerometer_data(input_data, MAX_SAMPLES);
    int coeffs = load_coefficients("tools/FIR_filter_coeffs.txt", FIR, filter);
    FILE *file = fopen(output, "w");
    fprintf(file, "data samples: %d coeffs: %d", data_samples, coeffs);
    for (int i = 0; i < data_samples; i++)
    {
        fprintf(file, "input_samples[%d]: %d\n", i,
                input_data->input_data_buffer[i]);
    }
    for (int i = 0; i < coeffs; i++)
    {
        fprintf(file, "coeffs[%d]: %d\n", i, filter->x[i]);
    }
}
void test_fixed_point_math(float *input, uint16_t size)
{
    if (size == 0)
    {
        return;
    }
    int16_t output[MAX_TEST_SIZE] = {};
    uint16_t max = 0;
    for (int i = 0; i < (int)size; i++)
    {
        if (input[i] > max)
        {
            max = input[i];
        }
    }
    int8_t sf = convert_to_fixed(input, output, size);

    printf("max: %d, scale factor: 2^%d, input[0]: %f output[0]: %d", max, sf,
           input[0], output[0]);
}
void test_iir_filter(char *outputfile, input_data_t *input_data,
                     filter_t *filter)
{
    int data_samples = load_accelerometer_data(input_data, MAX_SAMPLES);
    load_coefficients("tools/IIR_filter_coeffs.txt", IIR, filter);
    printf("input data sf: %d, filter sf: %d %d\n",
           input_data->scale_factor_exp, filter->num_scale_factor_exp,
           filter->den_scale_factor_exp);
    for (int i = 0; i < filter->x_coeffs; i++)
    {
        printf("filter x: %d\n", filter->x[i]);
    }
    printf("ycoeffs: %d\n", filter->y_coeffs);
    for (int i = 0; i < filter->y_coeffs; i++)
    {
        printf("filter y: %d %d\n", i, filter->y[i]);
    }

    int16_t filter_output[MAX_SAMPLES] = {};
    iir_filter(input_data, filter_output, data_samples, filter);
    FILE *file = fopen(outputfile, "w");
    for (int i = 0; i < data_samples; i++)
    {
        fprintf(file, "%d\n", (int)filter_output[i]);
    }
    fclose(file);
}