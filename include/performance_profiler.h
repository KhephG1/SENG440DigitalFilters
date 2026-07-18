#ifndef PERFORMANCE_PROFILER_H
#define PERFORMANCE_PROFILER_H

#include <stddef.h>
#include <stdint.h>
typedef struct profiler_t {
    uint64_t start_time_ticks;
    uint64_t stop_time_ticks;
    uint64_t elapsed_time_ticks;
} profiler_t;
int profiler_start(void);
int profiler_stop(void);
int profiler_get_elapsed_time(void);
#endif