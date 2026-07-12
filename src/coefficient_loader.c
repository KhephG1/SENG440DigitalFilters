
#include "coefficient_loader.h"
#include <math.h>
#include <stdio.h>
#include <string.h>
#define INPUT_FILE "tools/FIR_filter_coeffs"
#define MAXLINE (50)
#define FIR_SF (19)      // FIR scale factor is 2^19
#define IIR_NUM_SF (28)  // IIR Numerator scale factor is 2^28
#define IIR_DEN_SF (12)  // IIR Denominator scale factor is 2^12
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