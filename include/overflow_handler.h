#ifndef OVERFLOW_HANDLER_H
#define OVERFLOW_HANDLER_H

#include <stdint.h>

extern int overflow_count;

static inline int16_t saturate(int64_t value)
{
    if (value > INT16_MAX)
    {
        overflow_count++;
        return INT16_MAX;
    }

    if (value < INT16_MIN)
    {
        overflow_count++;
        return INT16_MIN;
    }

    return (int16_t)value;
}

int get_overflow_count();

void reset_overflow_count();

#endif