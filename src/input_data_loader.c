
#include "input_data_loader.h"
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#define INPUT_FILE "tools/data.csv"

#define MAXLINE (50)
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
    int8_t eof = 0;
    int i = 0;
    while (!eof)
    {
        if (i >= buffer_size)
        {
            return -1;  // indicate buffer overflow error status
        }
        float sample = 0.f;
        eof = fscanf(input, "%f", &sample);
        if (eof != -1)
        {
            eof = !eof;
        }
        else
        {
            break;
        }
        // X = round(x * SF) where SF = 2^7
        input_data_buffer[i] = (int16_t)ldexpf(sample, INPUT_SF);
        i++;
    }
    return i;
}