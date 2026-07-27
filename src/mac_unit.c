#include "mac_unit.h"

int64_t mac(int64_t acc, int16_t a, int16_t b)
{
    int32_t lo = (int32_t)(acc & 0xFFFFFFFF);
    int32_t hi = (int32_t)(acc >> 32);

    int32_t a32 = (int32_t)a;
    int32_t b32 = (int32_t)b;

    __asm__ volatile (
        "smlal %0, %1, %2, %3"
        : "+r"(lo), "+r"(hi)
        : "r"(a32), "r"(b32)
    );

    return ((int64_t)hi << 32) | (uint32_t)lo;
}