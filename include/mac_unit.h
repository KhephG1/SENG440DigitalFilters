#ifndef MAC_UNIT_H
#define MAC_UNIT_H

#include <stddef.h>
#include <stdint.h>

static inline int32_t mac(int32_t acc, int16_t a, int16_t b)
{
    int32_t result;

    __asm__ volatile (
        "mla %0, %1, %2, %3"
        : "=r"(result)
        : "r"((int32_t)a), "r"((int32_t)b), "r"(acc)
    );

    return result;
}

#endif