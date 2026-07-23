#include "overflow_handler.h"
#include <stdio.h>

static int overflow_count = 0; //only works for one filter at a time

int16_t saturate(int64_t value){
    if (value > 32767)
    {
        return 32767;
        overflow_count++;
    }

    if (value < -32768)
    {
        return -32768;
        overflow_count++;
    }

    return (int16_t)value;
}

int get_overflow_count() {
    return overflow_count;
}

void reset_overflow_count() {
    overflow_count = 0;
}