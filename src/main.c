#include "coefficient_loader.h"
#include "input_data_loader.h"
#include "tests.h"
#include <stdio.h>
int16_t input_samples[MAX_SAMPLES] = {};
filter_t FIR_filter = {};
int main()
{
    test_parser("output.txt", input_samples, &FIR_filter);
    return 0;
}
