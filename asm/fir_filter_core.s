	.file	"fir_filter_core.c"
# GNU C23 (GCC) version 16.1.1 20260515 (Red Hat 16.1.1-2) (x86_64-redhat-linux)
#	compiled by GNU C version 16.1.1 20260515 (Red Hat 16.1.1-2), GMP version 6.3.0, MPFR version 4.2.2, MPC version 1.4.1, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mtune=generic -march=x86-64 -mtls-dialect=gnu2
	.text
	.globl	fir_filter
	.type	fir_filter, @function
fir_filter:
.LFB0:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)	# input, input
	movq	%rsi, -32(%rbp)	# output, output
	movl	%edx, -36(%rbp)	# input_length, input_length
	movq	%rcx, -48(%rbp)	# coeffs, coeffs
	movw	%r8w, -38(%rbp)	# scale_factor, scale_factor
	movl	%r9d, -52(%rbp)	# coeffs_length, coeffs_length
# src/fir_filter_core.c:4:     for (uint32_t n = 0; n < input_length; n++) {
	movl	$0, -4(%rbp)	#, n
# src/fir_filter_core.c:4:     for (uint32_t n = 0; n < input_length; n++) {
	jmp	.L2	#
.L6:
# src/fir_filter_core.c:5:         int32_t acc = 0;
	movl	$0, -8(%rbp)	#, acc
# src/fir_filter_core.c:7:         for (uint32_t k = 0; k < coeffs_length; k++) {
	movl	$0, -12(%rbp)	#, k
# src/fir_filter_core.c:7:         for (uint32_t k = 0; k < coeffs_length; k++) {
	jmp	.L3	#
.L5:
# src/fir_filter_core.c:8:             if (n >= k) {
	movl	-4(%rbp), %eax	# n, tmp113
	cmpl	-12(%rbp), %eax	# k, tmp113
	jb	.L4	#,
# src/fir_filter_core.c:9:                 acc += (int32_t)input->input_data_buffer[n - k] * coeffs[k];
	movl	-4(%rbp), %eax	# n, tmp114
	subl	-12(%rbp), %eax	# k, tmp114
	movl	%eax, %edx	# tmp114, _1
# src/fir_filter_core.c:9:                 acc += (int32_t)input->input_data_buffer[n - k] * coeffs[k];
	movq	-24(%rbp), %rax	# input, tmp115
	movl	%edx, %edx	# _1, tmp116
	movzwl	(%rax,%rdx,2), %eax	# input_31(D)->input_data_buffer[_1], _2
# src/fir_filter_core.c:9:                 acc += (int32_t)input->input_data_buffer[n - k] * coeffs[k];
	movswl	%ax, %edx	# _2, _3
# src/fir_filter_core.c:9:                 acc += (int32_t)input->input_data_buffer[n - k] * coeffs[k];
	movl	-12(%rbp), %eax	# k, _4
	leaq	(%rax,%rax), %rcx	#, _5
	movq	-48(%rbp), %rax	# coeffs, tmp117
	addq	%rcx, %rax	# _5, _6
	movzwl	(%rax), %eax	# *_6, _7
	cwtl
# src/fir_filter_core.c:9:                 acc += (int32_t)input->input_data_buffer[n - k] * coeffs[k];
	imull	%edx, %eax	# _3, _9
# src/fir_filter_core.c:9:                 acc += (int32_t)input->input_data_buffer[n - k] * coeffs[k];
	addl	%eax, -8(%rbp)	# _9, acc
.L4:
# src/fir_filter_core.c:7:         for (uint32_t k = 0; k < coeffs_length; k++) {
	addl	$1, -12(%rbp)	#, k
.L3:
# src/fir_filter_core.c:7:         for (uint32_t k = 0; k < coeffs_length; k++) {
	movl	-12(%rbp), %eax	# k, tmp118
	cmpl	-52(%rbp), %eax	# coeffs_length, tmp118
	jb	.L5	#,
# src/fir_filter_core.c:12:         output[n] = (int16_t)(acc >> scale_factor);
	movswl	-38(%rbp), %eax	# scale_factor, _10
	movl	-8(%rbp), %edx	# acc, tmp119
	movl	%eax, %ecx	# _10, tmp125
	sarl	%cl, %edx	# tmp125, tmp119
	movl	%edx, %ecx	# tmp119, _11
# src/fir_filter_core.c:12:         output[n] = (int16_t)(acc >> scale_factor);
	movl	-4(%rbp), %eax	# n, _12
	leaq	(%rax,%rax), %rdx	#, _13
	movq	-32(%rbp), %rax	# output, tmp120
	addq	%rdx, %rax	# _13, _14
# src/fir_filter_core.c:12:         output[n] = (int16_t)(acc >> scale_factor);
	movl	%ecx, %edx	# _11, _15
# src/fir_filter_core.c:12:         output[n] = (int16_t)(acc >> scale_factor);
	movw	%dx, (%rax)	# _15, *_14
# src/fir_filter_core.c:4:     for (uint32_t n = 0; n < input_length; n++) {
	addl	$1, -4(%rbp)	#, n
.L2:
# src/fir_filter_core.c:4:     for (uint32_t n = 0; n < input_length; n++) {
	movl	-4(%rbp), %eax	# n, tmp121
	cmpl	-36(%rbp), %eax	# input_length, tmp121
	jb	.L6	#,
# src/fir_filter_core.c:14: }
	nop	
	nop	
	popq	%rbp	#
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE0:
	.size	fir_filter, .-fir_filter
	.ident	"GCC: (GNU) 16.1.1 20260515 (Red Hat 16.1.1-2)"
	.section	.note.GNU-stack,"",@progbits
