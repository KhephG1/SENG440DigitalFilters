#include "performance_profiler.h"
#include <time.h>
static profiler_t profiler;
int profiler_start(void)
{
    profiler.start_time_ticks = (uint64_t)clock();
    return profiler.start_time_ticks;
}

int profiler_stop(void)
{
    profiler.stop_time_ticks = (uint64_t)clock();
    return profiler.stop_time_ticks;
}

int profiler_get_elapsed_time(void)
{
    return profiler.stop_time_ticks - profiler.start_time_ticks;
}