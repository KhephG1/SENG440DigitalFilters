#include "mac_unit.h"

int32_t mac(int32_t acc, int16_t a, int16_t b)
{
    int32_t result;
    int32_t a32 = (int32_t)a;
    int32_t b32 = (int32_t)b;

    __asm__ volatile (
        "mla %0, %1, %2, %3"
        : "=r"(result)
        : "r"(a32), "r"(b32), "r"(acc)
    );

    return result;
}