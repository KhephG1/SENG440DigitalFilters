#ifndef INPUT_DATA_LOADER_H
#define INPUT_DATA_LOADER_H

#include <stddef.h>
#include <stdint.h>

#define MAX_SAMPLES (300000)
typedef struct input_data_t {
    int16_t input_data_buffer[MAX_SAMPLES];
    int8_t scale_factor_exp;
} input_data_t;
int load_accelerometer_data_fixed(const char *input_file,
                                  input_data_t *input_data,
                                  uint32_t buffer_size);

int load_accelerometer_data_float(const char *input_file, float *input_data,
                                  uint32_t buffer_size);
#endif