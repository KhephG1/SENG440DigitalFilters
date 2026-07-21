#include "tests.h"
#include "fir_filter_core.h"
#include "fixed_point_math.h"
#include "iir_filter_core.h"
#include "performance_profiler.h"
#include <stdio.h>
#define MAX_TEST_SIZE (50)
void test_parser(char *output, input_data_t *input_data, filter_t *filter)
{

    int data_samples = load_accelerometer_data_fixed("tools/data.csv",
                                                     input_data, MAX_SAMPLES);
    int coeffs =
        load_coefficients_fixed("tools/FIR_filter_coeffs.txt", FIR, filter);
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
void test_iir_filter(char *outputfile, float *input_data, float *filter_x,
                     float *filter_y, int *coeffs_x, int *coeffs_y)
{
    int data_samples = load_accelerometer_data_float("tools/data.csv",
                                                     input_data, MAX_SAMPLES);
    load_coefficients_float("tools/IIR_filter_coeffs.txt", IIR, filter_x,
                            filter_y, coeffs_x, coeffs_y);
    for (int i = 0; i < *coeffs_x; i++)
    {
        printf("filter x: %f\n", filter_x[i]);
    }
    printf("ycoeffs: %d\n", *coeffs_y);
    for (int i = 0; i < *coeffs_y; i++)
    {
        printf("filter y: %d %f\n", i, filter_y[i]);
    }

    float filter_output[MAX_SAMPLES] = {};
    profiler_start();
    iir_filter_naive(input_data, filter_output, data_samples, filter_x,
                     filter_y, coeffs_x, coeffs_y);
    profiler_stop();
    printf("elapsed: %d", profiler_get_elapsed_time());
    FILE *file = fopen(outputfile, "w");
    for (int i = 0; i < data_samples; i++)
    {
        fprintf(file, "%f\n", filter_output[i]);
    }
    printf("time elapsed in ticks: %d\n", profiler_get_elapsed_time());
    fclose(file);
}
void test_fir_filter(char *outputfile, input_data_t *input_data,
                     filter_t *filter)
{
    int data_samples = load_accelerometer_data_fixed(
        "tools/limit_cycle_test.csv", input_data, MAX_SAMPLES);

    load_coefficients_fixed("tools/FIR_filter_coeffs.txt", FIR, filter);

    printf("input data sf: %d, filter sf: %d\n", input_data->scale_factor_exp,
           filter->num_scale_factor_exp);

    for (int i = 0; i < filter->x_coeffs; i++)
    {
        printf("filter x: %d\n", filter->x[i]);
    }

    int16_t filter_output[MAX_SAMPLES] = {};

    fir_filter(input_data, filter_output, data_samples, filter->x,
               filter->num_scale_factor_exp, filter->x_coeffs);

    FILE *file = fopen(outputfile, "w");

    for (int i = 0; i < data_samples; i++)
    {
        fprintf(file, "%d\n", filter_output[i]);
    }
    fclose(file);
}