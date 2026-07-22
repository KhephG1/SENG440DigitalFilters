
#include "coefficient_loader.h"
#include "fixed_point_math.h"
#include <math.h>
#include <stdio.h>
#include <string.h>
#define MAXLINE (50)
// takes a filter struct as input and populates the size members with the number
// of numerator and denominator coefficients read
int load_coefficients_fixed(const char *filename, filter_type type,
                            filter_t *filter)
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

int load_coefficients_float(const char *filename, filter_type type,
                            float *filter_x, float *filter_y, int *coeffs_x,
                            int *coeffs_y)
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
            filter_x[i] = coef;
            i++;
        }
        *coeffs_x = i;
        fclose(input);
        return i;
    }
    else if (type == IIR)
    {
        float coef = 0.f;
        while (fscanf(input, "%f", &coef) == 1 && i < MAX_COEFFS)
        {
            filter_x[i] = coef;
            i++;
        }
        *coeffs_x = i;
        char *result =
            fgets(label, MAXLINE, input);  // get rid of the "den" line
        while (fscanf(input, "%f", &coef) == 1 && j < MAX_COEFFS && result)
        {
            // apply scale factor to coeffs (C = round (c * SF))
            filter_y[j] = coef;
            j++;
        }
        *coeffs_y = j;
        fclose(input);
        return i + j;
    }
    else
    {
        // invalid input
        return -1;
    }
}

int load_biquad_fixed(const char **filenames, biquad_t *biquads,
                      int num_biquads)
{
    for (int i = 0; i < num_biquads; i++)
    {
        FILE *input = fopen(filenames[i], "r");

        if (!input)
        {
            return -1;
        }

        char label[MAXLINE];

        float num[3];
        float den[2];

        int16_t num_fixed[3];
        int16_t den_fixed[2];

        // Read "num"
        if (fscanf(input, "%s", label) != 1 || strcmp(label, "num") != 0)
        {
            fclose(input);
            return -1;
        }
        // Read b0,b1,b2
        for (int j = 0; j < 3; j++)
        {
            if (fscanf(input, "%f", &num[j]) != 1)
            {
                fclose(input);
                return -1;
            }
        }

        // Read "den"
        if (fscanf(input, "%s", label) != 1 || strcmp(label, "den") != 0)
        {
            fclose(input);
            return -1;
        }

        // Read a1,a2
        for (int j = 0; j < 2; j++)
        {
            if (fscanf(input, "%f", &den[j]) != 1)
            {
                fclose(input);
                return -1;
            }
        }

        fclose(input);

        // Convert independently
        biquads[i].num_sf = convert_to_fixed(num, num_fixed, 3);
        biquads[i].den_sf = convert_to_fixed(den, den_fixed, 2);

        printf("here: num sf %d, den_sf %d\n", biquads[i].num_sf,
               biquads[i].den_sf);
        biquads[i].b0 = num_fixed[0];
        biquads[i].b1 = num_fixed[1];
        biquads[i].b2 = num_fixed[2];

        biquads[i].a1 = den_fixed[0];
        biquads[i].a2 = den_fixed[1];
    }

    return num_biquads;
}