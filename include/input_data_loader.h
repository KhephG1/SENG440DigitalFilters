#ifndef INPUT_DATA_LOADER_H
#define INPUT_DATA_LOADER_H

#include <stddef.h>
#include <stdint.h>

#define MAX_SAMPLES (300000)

int load_accelerometer_data(int16_t *input_data_buffer, uint32_t buffer_size);
#endif