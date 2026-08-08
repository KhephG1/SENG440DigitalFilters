#include "coefficient_loader.h"
#include "input_data_loader.h"
#include "overflow_handler.h"
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

    // test_parser("test_output/output.txt", input_samples, &IIR_filter);
    // test_fir_filter("tools/test_output/filter_output_1.txt", &input,
    //                 &FIR_filter);
    // test_fir_filter_float("tools/test_output/filter_output_2", input_data,
    // filter_x, &x_coeffs);

    // printf("FIR Filter Overflows: %d\n", get_overflow_count());
    // reset_overflow_count();
    // test_iir_filter_fixed("test_output/iir_filter_output.txt", &input,
    //                       &IIR_filter);
    // printf("IIR Filter Overflows: %d\n", get_overflow_count());
    // test_iir_biquad_fixed("tools/test_output/filter_output_5.txt", &input);
    // test_iir_biquad_fixed_unrolled("tools/test_output/test_output_6.txt",
    //                                &input);
    // test_fir_filter_neon("tools/test_output/test_output_7.txt", &input,
    // &FIR_filter);
    // test_iir_biquad_neon("tools/test_output/test_output_8.txt", &input);
    // test_iir_biquad_neon("tools/test_output/test_output_8.txt", &input);
    // test_iir_biquad_pipelined("tools/test_output/test_output_9.txt", &input);

    // test_iir_filter_fixed_ssat("tools/test_output/test_output_10.txt", &input, &IIR_filter);
    test_ssat_overflow();
    test_overflow();
    
    return 0;
}
