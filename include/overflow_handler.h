#ifndef OVERFLOW_HANDLER_H
#define OVERFLOW_HANDLER_H

#include <stddef.h>
#include <stdint.h>

static inline int16_t saturate(int64_t x)
{
    if (x > INT16_MAX)
    {
        return INT16_MAX;
    }
    else if (x < INT16_MIN)
    {
        return INT16_MIN;
    }
    else
    {
        return (int16_t)x;
    }
}

#endif