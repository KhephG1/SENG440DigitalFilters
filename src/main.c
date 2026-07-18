#include "coefficient_loader.h"
#include "input_data_loader.h"
#include "tests.h"
#include <stdio.h>
input_data_t input = {};
filter_t FIR_filter = {};
filter_t IIR_filter = {};

int main()
{
    test_fir_filter("test_output/filter_output.txt", &input, &FIR_filter);
    // test_parser("test_output/output.txt", input_samples, &IIR_filter);
    test_iir_filter("test_output/filter_output.txt", &input, &IIR_filter);
    return 0;
}
