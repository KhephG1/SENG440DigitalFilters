
#include "input_data_loader.h"
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#define INPUT_FILE "tools/data.csv"

#define INPUT_SF (6)  // input scale factor is 2^6
// returns the number of data samples loaded
int load_accelerometer_data(int16_t *input_data_buffer, uint32_t buffer_size)
{
    // open the input file
    FILE *input = fopen(INPUT_FILE, "r");
    if (!input)
    {
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
        // X = round(x * SF) where SF = 2^7
        input_data_buffer[i] = (int16_t)ldexpf(sample, INPUT_SF);
        i++;
    }
    fclose(input);
    return i;
}
