#include "coefficient_loader.h"
#include "input_data_loader.h"
#include "tests.h"
#include <stdio.h>
int16_t input_samples[MAX_SAMPLES] = {};
filter_t IIR_filter = {};
int main()
{
    // test_parser("test_output/output.txt", input_samples, &IIR_filter);
    test_iir_filter("test_output/filte_output.txt", input_samples, &IIR_filter);
    return 0;
}
