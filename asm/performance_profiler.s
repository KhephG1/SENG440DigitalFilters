	.file	"performance_profiler.c"
# GNU C23 (GCC) version 16.1.1 20260515 (Red Hat 16.1.1-2) (x86_64-redhat-linux)
#	compiled by GNU C version 16.1.1 20260515 (Red Hat 16.1.1-2), GMP version 6.3.0, MPFR version 4.2.2, MPC version 1.4.1, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mtune=generic -march=x86-64 -mtls-dialect=gnu2
	.text
	.local	profiler
	.comm	profiler,24,16
	.globl	profiler_start
	.type	profiler_start, @function
profiler_start:
.LFB0:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
# src/performance_profiler.c:6:     profiler.start_time_ticks = (uint64_t)clock();
	call	clock	#
# src/performance_profiler.c:6:     profiler.start_time_ticks = (uint64_t)clock();
	movq	%rax, profiler(%rip)	# _2, profiler.start_time_ticks
# src/performance_profiler.c:7:     return profiler.start_time_ticks;
	movq	profiler(%rip), %rax	# profiler.start_time_ticks, _3
# src/performance_profiler.c:8: }
	popq	%rbp	#
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE0:
	.size	profiler_start, .-profiler_start
	.globl	profiler_stop
	.type	profiler_stop, @function
profiler_stop:
.LFB1:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
# src/performance_profiler.c:12:     profiler.stop_time_ticks = (uint64_t)clock();
	call	clock	#
# src/performance_profiler.c:12:     profiler.stop_time_ticks = (uint64_t)clock();
	movq	%rax, profiler+8(%rip)	# _2, profiler.stop_time_ticks
# src/performance_profiler.c:13:     return profiler.stop_time_ticks;
	movq	profiler+8(%rip), %rax	# profiler.stop_time_ticks, _3
# src/performance_profiler.c:14: }
	popq	%rbp	#
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE1:
	.size	profiler_stop, .-profiler_stop
	.globl	profiler_get_elapsed_time
	.type	profiler_get_elapsed_time, @function
profiler_get_elapsed_time:
.LFB2:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
# src/performance_profiler.c:18:     return profiler.stop_time_ticks - profiler.start_time_ticks;
	movq	profiler+8(%rip), %rax	# profiler.stop_time_ticks, _1
# src/performance_profiler.c:18:     return profiler.stop_time_ticks - profiler.start_time_ticks;
	movl	%eax, %ecx	# _1, _2
# src/performance_profiler.c:18:     return profiler.stop_time_ticks - profiler.start_time_ticks;
	movq	profiler(%rip), %rax	# profiler.start_time_ticks, _3
# src/performance_profiler.c:18:     return profiler.stop_time_ticks - profiler.start_time_ticks;
	movl	%eax, %edx	# _3, _4
	movl	%ecx, %eax	# _2, _2
	subl	%edx, %eax	# _4, _2
# src/performance_profiler.c:19: }
	popq	%rbp	#
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE2:
	.size	profiler_get_elapsed_time, .-profiler_get_elapsed_time
	.ident	"GCC: (GNU) 16.1.1 20260515 (Red Hat 16.1.1-2)"
	.section	.note.GNU-stack,"",@progbits
