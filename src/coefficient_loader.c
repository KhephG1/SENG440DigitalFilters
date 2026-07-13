
#include "coefficient_loader.h"
#include <math.h>
#include <stdio.h>
#include <string.h>
#define MAXLINE (50)
#define FIR_SF (19)      // FIR scale factor is 2^19
#define IIR_NUM_SF (28)  // IIR Numerator scale factor is 2^28
#define IIR_DEN_SF (12)  // IIR Denominator scale factor is 2^12
// takes a filter struct as input and populates the size members with the number
// of numerator and denominator coefficients read
int load_coefficients(const char *filename, filter_type type, filter_t *filter)
{
    FILE *input = fopen(filename, "r");
    if (!input)
    {
        return -1;  // invalid file path
    }
    // loop counters for feedforward and feedback coefficients
    int i = 0;
    int j = 0;
    char label[MAXLINE];
    char *result = fgets(label, MAXLINE, input);
    if (!result || strcmp(label, "num\n") != 0)
    {
        return -1;  // invalid filter file format
    }
    // read the numerator coeffs
    if (type == FIR)
    {

        float coef = 0.f;
        while (fscanf(input, "%f", &coef) == 1 && i < MAX_COEFFS)
        {
            filter->x[i] = (int16_t)ldexpf(coef, FIR_SF);
            i++;
        }
        filter->x_coeffs = i;
        fclose(input);
        return i;
    }
    else if (type == IIR)
    {
        float coef = 0.f;
        while (fscanf(input, "%f", &coef) == 1 && i < MAX_COEFFS)
        {
            filter->x[i] = (int16_t)ldexpf(coef, IIR_NUM_SF);
            i++;
        }
        filter->x_coeffs = i;
        while (fscanf(input, "%f", &coef) && j < MAX_COEFFS)
        {
            filter->y[j] = (int16_t)ldexpf(coef, IIR_DEN_SF);
            j++;
        }
        filter->y_coeffs = j;
        fclose(input);
        return i + j;
    }
    else
    {
        // invalid input
        return -1;
    }
}
