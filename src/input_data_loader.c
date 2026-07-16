
#include "input_data_loader.h"
#include "fixed_point_math.h"
#include <math.h>
#include <stdint.h>
#include <stdio.h>

// returns the number of data samples loaded
int load_accelerometer_data(const char *input_file, input_data_t *input_data,
                            uint32_t buffer_size)
{
    // open the input file
    FILE *input = fopen(input_file, "r");
    float temp[MAX_SAMPLES] = {};
    if (!input)
    {
        printf("failed to load input");
        return -1;  // invalid file path
    }
    // read each line in the file
    int i = 0;
    float sample = 0.f;
    while (fscanf(input, "%f", &sample) == 1)
    {
        if (i >= (int)buffer_size)
        {
            return -1;  // indicate buffer overflow error status
        }
        temp[i] = sample;
        i++;
    }
    input_data->scale_factor_exp =
        convert_to_fixed(temp, input_data->input_data_buffer, i);
    fclose(input);
    return i;
}