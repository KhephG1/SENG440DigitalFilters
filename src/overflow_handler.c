#include "overflow_handler.h"
#include <stdio.h>
#include <limits.h>

int overflow_count = 0;

int get_overflow_count() {
    return overflow_count;
}

void reset_overflow_count() {
    overflow_count = 0;
}
