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

static inline int16_t saturate_ssat(int32_t value)
{
    int32_t result;

    __asm__ volatile (
        "ssat %0, #16, %1"
        : "=r"(result)
        : "r"(value)
    );

    if (result != value)
    {
        overflow_count++;
    }

    return (int16_t)result;
}

int get_overflow_count();

void reset_overflow_count();

#endif