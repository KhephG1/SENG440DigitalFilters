#include "coefficient_loader.h"
#include "input_data_loader.h"
#include "tests.h"
#include <stdio.h>
// processor: arm-cortex  a7, 2GHz
// architecture ARMv7-a

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
    // test_fir_filter("tools/test_output/filter_output_1.txt", &input,
    //                 &FIR_filter);
    // test_fir_filter_float("tools/test_output/filter_output_2", input_data,
    // filter_x, &x_coeffs);
    // test_iir_filter_fixed("tools/test_output/filter_output_4.txt", &input,
    //                       &IIR_filter);
    test_iir_biquad_fixed("tools/test_output/filter_output_5.txt", &input);
    // test_iir_biquad_fixed_unrolled("tools/test_output/test_output_6.txt",
    //                              &input);
    // test_fir_filter_neon("tools/test_output/test_output_7.txt", &input,
    // &FIR_filter);
    return 0;
}
