
#include "coefficient_loader.h"
#include "fixed_point_math.h"
#include <math.h>
#include <stdio.h>
#include <string.h>
#define MAXLINE (50)
// takes a filter struct as input and populates the size members with the number
// of numerator and denominator coefficients read
int load_coefficients(const char *filename, filter_type type, filter_t *filter)
{
    FILE *input = fopen(filename, "r");
    float temp[MAX_COEFFS] = {};
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
            temp[i] = coef;
            i++;
        }
        filter->x_coeffs = i;
        filter->num_scale_factor_exp =
            convert_to_fixed(temp, filter->x, filter->x_coeffs);
        fclose(input);
        return i;
    }
    else if (type == IIR)
    {
        float coef = 0.f;
        while (fscanf(input, "%f", &coef) == 1 && i < MAX_COEFFS)
        {
            temp[i] = coef;
            i++;
        }
        filter->x_coeffs = i;
        filter->num_scale_factor_exp =
            convert_to_fixed(temp, filter->x, filter->x_coeffs);
        char *result =
            fgets(label, MAXLINE, input);  // get rid of the "den" line
        while (fscanf(input, "%f", &coef) == 1 && j < MAX_COEFFS && result)
        {
            // apply scale factor to coeffs (C = round (c * SF))
            temp[j] = coef;
            j++;
        }
        filter->y_coeffs = j;
        filter->den_scale_factor_exp =
            convert_to_fixed(temp, filter->y, filter->y_coeffs);
        fclose(input);
        return i + j;
    }
    else
    {
        // invalid input
        return -1;
    }
}
