#include "tests.h"
#include "fir_filter_core.h"
#include "fixed_point_math.h"
#include "iir_filter_core.h"
#include "performance_profiler.h"
#include <stdio.h>
#include <string.h>
#define MAX_TEST_SIZE (50)
void test_parser(char *output, input_data_t *input_data, filter_t *filter)
{

    int data_samples = load_accelerometer_data_fixed(
        "tools/data_normalized.csv", input_data, MAX_SAMPLES);
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
    int8_t sf = convert_to_fixed(input, output, size, pow(2, 15));

    printf("max: %d, scale factor: 2^%d, input[0]: %f output[0]: %d", max, sf,
           input[0], output[0]);
}

void test_iir_filter_fixed(char *outputfile, input_data_t *input_data,
                           filter_t *filter)
{
    int data_samples = load_accelerometer_data_fixed(
        "tools/test_data/data_normalized.csv", input_data, MAX_SAMPLES);
    load_coefficients_fixed("tools/filter_coefficients/IIR_filter_coeffs.txt",
                            IIR, filter);
    printf("input data sf: %d, filter sf: num %d den %d\n",
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
    profiler_start();
    iir_filter_fixed_point(input_data, filter_output, data_samples, filter);
    profiler_stop();
    printf("time elapsed in ticks: %d\n", profiler_get_elapsed_time());
    FILE *file = fopen(outputfile, "w");
    for (int i = 0; i < data_samples; i++)
    {
        fprintf(file, "%d\n", (int)filter_output[i]);
    }
    fclose(file);
}

void test_iir_biquad_fixed(char *outputfile, input_data_t *input_data)
{
    int data_samples = load_accelerometer_data_fixed(
        "tools/test_data/data_normalized.csv", input_data, MAX_SAMPLES);
    filter_t filter = {};
    if (!load_coefficients_fixed("tools/filter_coefficients/biquad_coeffs.txt",
                                 IIR, &filter))
    {
        printf("error");
    }
    printf("input data sf: %d\n", input_data->scale_factor_exp);
    printf("biquad sf: num %d den %d\n", filter.num_scale_factor_exp,
           filter.den_scale_factor_exp);
    input_data_t filter1_output = {};
    filter1_output.scale_factor_exp = input_data->scale_factor_exp;
    int16_t filter_output[MAX_SAMPLES] = {};
    filter_t filter1 = {.x_coeffs = 3,
                        .y_coeffs = 3,
                        .num_scale_factor_exp = filter.num_scale_factor_exp,
                        .den_scale_factor_exp = filter.den_scale_factor_exp};
    filter_t filter2 = {.x_coeffs = 3,
                        .y_coeffs = 3,
                        .num_scale_factor_exp = filter.num_scale_factor_exp,
                        .den_scale_factor_exp = filter.den_scale_factor_exp};
    memcpy(filter1.x, filter.x, 3 * sizeof(int16_t));
    memcpy(filter1.y, filter.y, 3 * sizeof(int16_t));
    memcpy(filter2.x, &filter.x[3], 3 * sizeof(int16_t));
    memcpy(filter2.y, &filter.y[3], 3 * sizeof(int16_t));
    printf("b coefficients:\n");
    printf("b0: %d\n", filter1.x[0]);
    printf("b1: %d\n", filter1.x[1]);
    printf("b2: %d\n", filter1.x[2]);

    printf("a coefficients:\n");
    printf("a1: %d\n", filter1.y[0]);
    printf("a2: %d\n", filter1.y[1]);

    printf("b coefficients:\n");
    printf("b0: %d\n", filter2.x[0]);
    printf("b1: %d\n", filter2.x[1]);
    printf("b2: %d\n", filter2.x[2]);

    printf("a coefficients:\n");
    printf("a1: %d\n", filter2.y[0]);
    printf("a2: %d\n", filter2.y[1]);

    profiler_start();
    iir_filter_fixed_point(input_data, filter1_output.input_data_buffer,
                           data_samples, &filter1);
    iir_filter_fixed_point(&filter1_output, filter_output, data_samples,
                           &filter2);
    profiler_stop();

    printf("time elapsed in ticks: %d\n", profiler_get_elapsed_time());

    FILE *file = fopen(outputfile, "w");

    for (int i = 0; i < data_samples; i++)
    {
        fprintf(file, "%d\n", (int)filter_output[i]);
    }

    fclose(file);
}

void test_iir_biquad_fixed_unrolled(char *outputfile, input_data_t *input_data)
{
    int data_samples = load_accelerometer_data_fixed(
        "tools/test_data/data_normalized.csv", input_data, MAX_SAMPLES);
    filter_t filter = {};
    if (!load_coefficients_fixed("tools/filter_coefficients/biquad_coeffs.txt",
                                 IIR, &filter))
    {
        printf("error");
    }
    printf("input data sf: %d\n", input_data->scale_factor_exp);
    printf("biquad sf: num %d den %d\n", filter.num_scale_factor_exp,
           filter.den_scale_factor_exp);

    input_data_t filter1_output = {};
    filter1_output.scale_factor_exp = input_data->scale_factor_exp;
    int16_t filter_output[MAX_SAMPLES] = {};

    filter_t filter1 = {.x_coeffs = 3,
                        .y_coeffs = 3,
                        .num_scale_factor_exp = filter.num_scale_factor_exp,
                        .den_scale_factor_exp = filter.den_scale_factor_exp};
    filter_t filter2 = {.x_coeffs = 3,
                        .y_coeffs = 3,
                        .num_scale_factor_exp = filter.num_scale_factor_exp,
                        .den_scale_factor_exp = filter.den_scale_factor_exp};
    memcpy(filter1.x, filter.x, 3 * sizeof(int16_t));
    memcpy(filter1.y, filter.y, 3 * sizeof(int16_t));
    memcpy(filter2.x, &filter.x[3], 3 * sizeof(int16_t));
    memcpy(filter2.y, &filter.y[3], 3 * sizeof(int16_t));

    printf("stage 1 b coefficients:\n");
    printf("b0: %d\n", filter1.x[0]);
    printf("b1: %d\n", filter1.x[1]);
    printf("b2: %d\n", filter1.x[2]);
    printf("stage 1 a coefficients:\n");
    printf("a1: %d\n", filter1.y[0]);
    printf("a2: %d\n", filter1.y[1]);
    printf("stage 2 b coefficients:\n");
    printf("b0: %d\n", filter2.x[0]);
    printf("b1: %d\n", filter2.x[1]);
    printf("b2: %d\n", filter2.x[2]);
    printf("stage 2 a coefficients:\n");
    printf("a1: %d\n", filter2.y[0]);
    printf("a2: %d\n", filter2.y[1]);

    profiler_start();
    iir_filter_fixed_point_with_unrolling(
        input_data, filter1_output.input_data_buffer, data_samples, &filter1);
    iir_filter_fixed_point_with_unrolling(&filter1_output, filter_output,
                                          data_samples, &filter2);
    profiler_stop();

    printf("time elapsed in ticks: %d\n", profiler_get_elapsed_time());

    FILE *file = fopen(outputfile, "w");
    for (int i = 0; i < data_samples; i++)
    {
        fprintf(file, "%d\n", (int)filter_output[i]);
    }
    fclose(file);
}

void test_fir_filter(char *outputfile, input_data_t *input_data,
                     filter_t *filter)
{
    int data_samples = load_accelerometer_data_fixed(
        "tools/test_data/data_normalized.csv", input_data, MAX_SAMPLES);

    load_coefficients_fixed("tools/filter_coefficients/FIR_filter_coeffs.txt",
                            FIR, filter);

    printf("input data sf: %d, filter sf: %d\n", input_data->scale_factor_exp,
           filter->num_scale_factor_exp);
    int16_t filter_output[MAX_SAMPLES] = {};
    profiler_start();
    fir_filter(input_data, filter_output, data_samples, filter->x,
               filter->num_scale_factor_exp, filter->x_coeffs);
    profiler_stop();
    printf("time elapsed in ticks: %d\n", profiler_get_elapsed_time());
    FILE *file = fopen(outputfile, "w");

    for (int i = 0; i < data_samples; i++)
    {
        fprintf(file, "%d\n", filter_output[i]);
    }
    fclose(file);
}

void test_fir_filter_float(char *outputfile, float *input_data, float *filter_x,
                           int *coeffs_x)
{
    int data_samples = load_accelerometer_data_float(
        "tools/test_data/data_normalized.csv", input_data, MAX_SAMPLES);
    load_coefficients_float("tools/filter_coefficients/FIR_filter_coeffs.txt",
                            FIR, filter_x, NULL, coeffs_x, 0);

    float filter_output[MAX_SAMPLES] = {};
    profiler_start();
    fir_filter_naive(input_data, filter_output, data_samples, filter_x,
                     coeffs_x);
    profiler_stop();
    printf("time elapsed in ticks: %d\n", profiler_get_elapsed_time());
    FILE *file = fopen(outputfile, "w");
    for (int i = 0; i < data_samples; i++)
    {
        fprintf(file, "%f\n", filter_output[i]);
    }
    fclose(file);
}

void test_fir_filter_neon(char *outputfile, input_data_t *input_data,
                          filter_t *filter)
{
    int data_samples = load_accelerometer_data_fixed(
        "tools/test_data/data_normalized.csv", input_data, MAX_SAMPLES);

    load_coefficients_fixed("tools/filter_coefficients/FIR_filter_coeffs.txt",
                            FIR, filter);

    printf("input data sf: %d, filter sf: %d\n", input_data->scale_factor_exp,
           filter->num_scale_factor_exp);

    int16_t filter_output[MAX_SAMPLES] = {};
    profiler_start();
    fir_filter_neon_helper(input_data, filter_output, data_samples, filter->x,
                           filter->num_scale_factor_exp, filter->x_coeffs);
    profiler_stop();
    printf("time elapsed in ticks: %d\n", profiler_get_elapsed_time());

    FILE *file = fopen(outputfile, "w");
    for (int i = 0; i < data_samples; i++)
    {
        fprintf(file, "%d\n", filter_output[i]);
    }
    fclose(file);
}