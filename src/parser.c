#include "parser.h"
#include <math.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

#define MAXLINE (50)
#define INPUT_SF (6)     // input scale factor is 2^6
#define FIR_SF (19)      // FIR scale factor is 2^19
#define IIR_NUM_SF (28)  // IIR Numerator scale factor is 2^28
#define IIR_DEN_SF (12)  // IIR Denominator scale factor is 2^12

// todo:
/*
1. load both filter coeffs.txt and data.csv into two separate arrays
*/
// returns the number of data samples loaded
int load_accelerometer_data(int16_t *input_data_buffer, uint32_t buffer_size)
{
    // open the input file
    FILE *input = fopen("tools/data.csv", "r");
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
// takes a filter struct as input and populates the size members with the number
// of numerator and denominator coefficients read
int load_coefficients(char *filename, filter_type type, filter_t *filter)
{
    FILE *input = fopen(filename, "r");
    if (!input)
    {
        return -1;  // invalid file path
    }
    int8_t eoi = 0;  // end of input flag
    int i = 0;
    int j = 0;
    char label[MAXLINE];
    char *result = fgets(label, MAXLINE, input);
    if (strcmp(label, "num\n") != 0 || !result)
    {
        return -1;  // invalid filter file format
    }
    // read the numerator coeffs
    if (type == FIR)
    {
        while (!eoi)
        {
            float coef = 0.f;
            eoi = fscanf(input, "%f", &coef);
            if (eoi != -1)
            {
                eoi = !eoi;
            }
            else
            {
                break;
            }
            filter->numerator[i] = (int16_t)ldexpf(coef, FIR_SF);
            i++;
        }
        filter->num_coeffs = i;
        return i;
    }
    else if (type == IIR)
    {
        while (!eoi)
        {
            float coef = 0.f;
            eoi = fscanf(input, "%f", &coef);
            if (eoi != -1)
            {
                eoi = !eoi;
            }
            else
            {
                break;
            }
            filter->numerator[i] = (int16_t)ldexpf(coef, IIR_NUM_SF);
            i++;
        }
        filter->num_coeffs = i;
        eoi = 0;
        while (!eoi)
        {

            float coef = 0.f;
            eoi = fscanf(input, "%f", &coef);
            if (eoi != -1)
            {
                eoi = !eoi;
            }
            else
            {
                break;
            }
            filter->denominator[j] = (int16_t)ldexpf(coef, IIR_DEN_SF);
            j++;
        }
        filter->den_coeffs = j;
        return i + j;
    }
    else
    {
        // invalid input
        return -1;
    }
}