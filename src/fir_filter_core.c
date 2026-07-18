#include "fir_filter_core.h"

void fir_filter(const input_data_t *input, int16_t *output, uint32_t input_length, const int16_t *coeffs, int16_t scale_factor, uint32_t coeffs_length){
    for (uint32_t n = 0; n < input_length; n++) {
        int32_t acc = 0;

        for (uint32_t k = 0; k < coeffs_length; k++) {
            if (n >= k) {
                acc += (int32_t)input->input_data_buffer[n - k] * coeffs[k];
            }
        }
        output[n] = (int16_t)(acc >> scale_factor);
    }
}