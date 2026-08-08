#ifndef MAC_UNIT_H
#define MAC_UNIT_H

#include <stddef.h>
#include <stdint.h>
static inline int64_t mac(int64_t acc, int16_t a, int16_t b)
{
    int32_t lo = (int32_t)(acc & 0xFFFFFFFF);
    int32_t hi = (int32_t)(acc >> 32);

    __asm__("smlal %0, %1, %2, %3"
            : "+r"(lo), "+r"(hi)
            : "r"((int32_t)a), "r"((int32_t)b));

    return ((int64_t)hi << 32) | (uint32_t)lo;
}

#endif