#ifndef OVERFLOW_HANDLER_H
#define OVERFLOW_HANDLER_H

#include <stddef.h>
#include <stdint.h>

int16_t saturate(int64_t value);

int get_overflow_count();

void reset_overflow_count();

#endif