#include "coefficient_loader.h"
#include "input_data_loader.h"
#include "tests.h"
#include <stdio.h>
filter_t FIR_filter = {};
filter_t IIR_filter = {};
input_data_t input = {};
float input_data[MAX_SAMPLES];
float filter_y[MAX_COEFFS];
float filter_x[MAX_COEFFS];
int x_coeffs = 0;
int y_coeffs = 0;
;
int main()
{
    test_fir_filter("test_output/fir_filter_output.txt", &input, &FIR_filter);
    printf("FIR Filter Overflows: %d\n", get_overflow_count());
    reset_overflow_count();
    // test_parser("test_output/output.txt", input_samples, &IIR_filter);
    test_iir_filter("test_output/iir_filter_output.txt", &input, &IIR_filter);
    printf("IIR Filter Overflows: %d\n", get_overflow_count());

    return 0;
}
