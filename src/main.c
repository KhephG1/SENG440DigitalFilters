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
    // test_fir_filter("tools/test_output/filter_output.txt", &input,
    // &FIR_filter);
    //    test_parser("tools/test_output/output.txt", input_samples,
    //    &IIR_filter);
    //   test_iir_filter_float("tools/test_output/filter_output.txt",
    //   input_data, filter_x, filter_y, &x_coeffs, &y_coeffs);
    test_iir_filter_fixed("tools/test_output/filter_output.txt", &input,
                          &IIR_filter);
    // test_iir_biquad_fixed("tools/test_output/filter_output.txt", &input);
    return 0;
}
