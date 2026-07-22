	.file	"tests.c"
# GNU C23 (GCC) version 16.1.1 20260515 (Red Hat 16.1.1-2) (x86_64-redhat-linux)
#	compiled by GNU C version 16.1.1 20260515 (Red Hat 16.1.1-2), GMP version 6.3.0, MPFR version 4.2.2, MPC version 1.4.1, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mtune=generic -march=x86-64 -mtls-dialect=gnu2
	.text
	.section	.rodata
.LC0:
	.string	"tools/data.csv"
.LC1:
	.string	"tools/FIR_filter_coeffs.txt"
.LC2:
	.string	"w"
.LC3:
	.string	"data samples: %d coeffs: %d"
.LC4:
	.string	"input_samples[%d]: %d\n"
.LC5:
	.string	"coeffs[%d]: %d\n"
	.text
	.globl	test_parser
	.type	test_parser, @function
test_parser:
.LFB0:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$64, %rsp	#,
	movq	%rdi, -40(%rbp)	# output, output
	movq	%rsi, -48(%rbp)	# input_data, input_data
	movq	%rdx, -56(%rbp)	# filter, filter
# src/tests.c:11:     int data_samples = load_accelerometer_data_fixed("tools/data.csv",
	movq	-48(%rbp), %rax	# input_data, tmp102
	movl	$300000, %edx	#,
	movq	%rax, %rsi	# tmp102,
	movl	$.LC0, %edi	#,
	call	load_accelerometer_data_fixed	#
	movl	%eax, -12(%rbp)	# tmp103, data_samples
# src/tests.c:14:         load_coefficients_fixed("tools/FIR_filter_coeffs.txt", FIR, filter);
	movq	-56(%rbp), %rax	# filter, tmp104
	movq	%rax, %rdx	# tmp104,
	movl	$0, %esi	#,
	movl	$.LC1, %edi	#,
	call	load_coefficients_fixed	#
	movl	%eax, -16(%rbp)	# tmp105, coeffs
# src/tests.c:15:     FILE *file = fopen(output, "w");
	movq	-40(%rbp), %rax	# output, tmp106
	movl	$.LC2, %esi	#,
	movq	%rax, %rdi	# tmp106,
	call	fopen	#
	movq	%rax, -24(%rbp)	# tmp107, file
# src/tests.c:16:     fprintf(file, "data samples: %d coeffs: %d", data_samples, coeffs);
	movl	-16(%rbp), %ecx	# coeffs, tmp108
	movl	-12(%rbp), %edx	# data_samples, tmp109
	movq	-24(%rbp), %rax	# file, tmp110
	movl	$.LC3, %esi	#,
	movq	%rax, %rdi	# tmp110,
	movl	$0, %eax	#,
	call	fprintf	#
# src/tests.c:17:     for (int i = 0; i < data_samples; i++)
	movl	$0, -4(%rbp)	#, i
# src/tests.c:17:     for (int i = 0; i < data_samples; i++)
	jmp	.L2	#
.L3:
# src/tests.c:20:                 input_data->input_data_buffer[i]);
	movq	-48(%rbp), %rax	# input_data, tmp111
	movl	-4(%rbp), %edx	# i, tmp113
	movslq	%edx, %rdx	# tmp113, tmp112
	movzwl	(%rax,%rdx,2), %eax	# input_data_10(D)->input_data_buffer[i_5], _1
# src/tests.c:19:         fprintf(file, "input_samples[%d]: %d\n", i,
	movswl	%ax, %ecx	# _1, _2
	movl	-4(%rbp), %edx	# i, tmp114
	movq	-24(%rbp), %rax	# file, tmp115
	movl	$.LC4, %esi	#,
	movq	%rax, %rdi	# tmp115,
	movl	$0, %eax	#,
	call	fprintf	#
# src/tests.c:17:     for (int i = 0; i < data_samples; i++)
	addl	$1, -4(%rbp)	#, i
.L2:
# src/tests.c:17:     for (int i = 0; i < data_samples; i++)
	movl	-4(%rbp), %eax	# i, tmp116
	cmpl	-12(%rbp), %eax	# data_samples, tmp116
	jl	.L3	#,
# src/tests.c:22:     for (int i = 0; i < coeffs; i++)
	movl	$0, -8(%rbp)	#, i
# src/tests.c:22:     for (int i = 0; i < coeffs; i++)
	jmp	.L4	#
.L5:
# src/tests.c:24:         fprintf(file, "coeffs[%d]: %d\n", i, filter->x[i]);
	movq	-56(%rbp), %rax	# filter, tmp117
	movl	-8(%rbp), %edx	# i, tmp119
	movslq	%edx, %rdx	# tmp119, tmp118
	movzwl	(%rax,%rdx,2), %eax	# filter_13(D)->x[i_6], _3
# src/tests.c:24:         fprintf(file, "coeffs[%d]: %d\n", i, filter->x[i]);
	movswl	%ax, %ecx	# _3, _4
	movl	-8(%rbp), %edx	# i, tmp120
	movq	-24(%rbp), %rax	# file, tmp121
	movl	$.LC5, %esi	#,
	movq	%rax, %rdi	# tmp121,
	movl	$0, %eax	#,
	call	fprintf	#
# src/tests.c:22:     for (int i = 0; i < coeffs; i++)
	addl	$1, -8(%rbp)	#, i
.L4:
# src/tests.c:22:     for (int i = 0; i < coeffs; i++)
	movl	-8(%rbp), %eax	# i, tmp122
	cmpl	-16(%rbp), %eax	# coeffs, tmp122
	jl	.L5	#,
# src/tests.c:26: }
	nop	
	nop	
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE0:
	.size	test_parser, .-test_parser
	.section	.rodata
	.align 8
.LC6:
	.string	"max: %d, scale factor: 2^%d, input[0]: %f output[0]: %d"
	.text
	.globl	test_fixed_point_math
	.type	test_fixed_point_math, @function
test_fixed_point_math:
.LFB1:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	addq	$-128, %rsp	#,
	movq	%rdi, -120(%rbp)	# input, input
	movw	%si, -122(%rbp)	# size, size
# src/tests.c:29:     if (size == 0)
	cmpw	$0, -122(%rbp)	#, size
	je	.L14	#,
# src/tests.c:33:     int16_t output[MAX_TEST_SIZE] = {};
	pxor	%xmm0, %xmm0	# tmp116
	movaps	%xmm0, -112(%rbp)	# tmp116, output
	movaps	%xmm0, -96(%rbp)	# tmp116, output
	movaps	%xmm0, -80(%rbp)	# tmp116, output
	movaps	%xmm0, -64(%rbp)	# tmp116, output
	movaps	%xmm0, -48(%rbp)	# tmp116, output
	movaps	%xmm0, -32(%rbp)	# tmp116, output
	movd	%xmm0, -16(%rbp)	# tmp116, output
# src/tests.c:34:     uint16_t max = 0;
	movw	$0, -2(%rbp)	#, max
# src/tests.c:35:     for (int i = 0; i < (int)size; i++)
	movl	$0, -8(%rbp)	#, i
# src/tests.c:35:     for (int i = 0; i < (int)size; i++)
	jmp	.L9	#
.L12:
# src/tests.c:37:         if (input[i] > max)
	movl	-8(%rbp), %eax	# i, tmp117
	cltq
	leaq	0(,%rax,4), %rdx	#, _2
	movq	-120(%rbp), %rax	# input, tmp118
	addq	%rdx, %rax	# _2, _3
	movss	(%rax), %xmm0	# *_3, _4
# src/tests.c:37:         if (input[i] > max)
	movzwl	-2(%rbp), %eax	# max, _5
	pxor	%xmm1, %xmm1	# _6
	cvtsi2ssl	%eax, %xmm1	# _5, _6
# src/tests.c:37:         if (input[i] > max)
	comiss	%xmm1, %xmm0	# _6, _4
	jbe	.L10	#,
# src/tests.c:39:             max = input[i];
	movl	-8(%rbp), %eax	# i, tmp119
	cltq
	leaq	0(,%rax,4), %rdx	#, _8
	movq	-120(%rbp), %rax	# input, tmp120
	addq	%rdx, %rax	# _8, _9
	movss	(%rax), %xmm0	# *_9, _10
# src/tests.c:39:             max = input[i];
	cvttss2sil	%xmm0, %eax	# _10, tmp121
	movw	%ax, -2(%rbp)	# tmp121, max
.L10:
# src/tests.c:35:     for (int i = 0; i < (int)size; i++)
	addl	$1, -8(%rbp)	#, i
.L9:
# src/tests.c:35:     for (int i = 0; i < (int)size; i++)
	movzwl	-122(%rbp), %eax	# size, _11
# src/tests.c:35:     for (int i = 0; i < (int)size; i++)
	cmpl	%eax, -8(%rbp)	# _11, i
	jl	.L12	#,
# src/tests.c:42:     int8_t sf = convert_to_fixed(input, output, size);
	movzwl	-122(%rbp), %edx	# size, _12
	leaq	-112(%rbp), %rcx	#, tmp122
	movq	-120(%rbp), %rax	# input, tmp123
	movq	%rcx, %rsi	# tmp122,
	movq	%rax, %rdi	# tmp123,
	call	convert_to_fixed	#
	movb	%al, -9(%rbp)	# tmp124, sf
# src/tests.c:45:            input[0], output[0]);
	movzwl	-112(%rbp), %eax	# output[0], _13
# src/tests.c:44:     printf("max: %d, scale factor: 2^%d, input[0]: %f output[0]: %d", max, sf,
	movswl	%ax, %ecx	# _13, _14
# src/tests.c:45:            input[0], output[0]);
	movq	-120(%rbp), %rax	# input, tmp125
	movss	(%rax), %xmm0	# *input_28(D), _15
# src/tests.c:44:     printf("max: %d, scale factor: 2^%d, input[0]: %f output[0]: %d", max, sf,
	pxor	%xmm2, %xmm2	# _16
	cvtss2sd	%xmm0, %xmm2	# _15, _16
	movq	%xmm2, %rsi	# _16, _16
	movsbl	-9(%rbp), %edx	# sf, _17
	movzwl	-2(%rbp), %eax	# max, _18
	movq	%rsi, %xmm0	# _16,
	movl	%eax, %esi	# _18,
	movl	$.LC6, %edi	#,
	movl	$1, %eax	#,
	call	printf	#
	jmp	.L6	#
.L14:
# src/tests.c:31:         return;
	nop	
.L6:
# src/tests.c:46: }
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE1:
	.size	test_fixed_point_math, .-test_fixed_point_math
	.section	.rodata
.LC7:
	.string	"tools/IIR_filter_coeffs.txt"
.LC8:
	.string	"filter x: %f\n"
.LC9:
	.string	"ycoeffs: %d\n"
.LC10:
	.string	"filter y: %d %f\n"
.LC11:
	.string	"time elapsed in ticks: %d\n"
.LC12:
	.string	"%f\n"
	.text
	.globl	test_iir_filter_float
	.type	test_iir_filter_float, @function
test_iir_filter_float:
.LFB2:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$1200080, %rsp	#,
	movq	%rdi, -1200040(%rbp)	# outputfile, outputfile
	movq	%rsi, -1200048(%rbp)	# input_data, input_data
	movq	%rdx, -1200056(%rbp)	# filter_x, filter_x
	movq	%rcx, -1200064(%rbp)	# filter_y, filter_y
	movq	%r8, -1200072(%rbp)	# coeffs_x, coeffs_x
	movq	%r9, -1200080(%rbp)	# coeffs_y, coeffs_y
# src/tests.c:50:     int data_samples = load_accelerometer_data_float("tools/data.csv",
	movq	-1200048(%rbp), %rax	# input_data, tmp115
	movl	$300000, %edx	#,
	movq	%rax, %rsi	# tmp115,
	movl	$.LC0, %edi	#,
	call	load_accelerometer_data_float	#
	movl	%eax, -16(%rbp)	# tmp116, data_samples
# src/tests.c:52:     load_coefficients_float("tools/IIR_filter_coeffs.txt", IIR, filter_x,
	movq	-1200080(%rbp), %rsi	# coeffs_y, tmp117
	movq	-1200072(%rbp), %rcx	# coeffs_x, tmp118
	movq	-1200064(%rbp), %rdx	# filter_y, tmp119
	movq	-1200056(%rbp), %rax	# filter_x, tmp120
	movq	%rsi, %r9	# tmp117,
	movq	%rcx, %r8	# tmp118,
	movq	%rdx, %rcx	# tmp119,
	movq	%rax, %rdx	# tmp120,
	movl	$1, %esi	#,
	movl	$.LC7, %edi	#,
	call	load_coefficients_float	#
# src/tests.c:54:     for (int i = 0; i < *coeffs_x; i++)
	movl	$0, -4(%rbp)	#, i
# src/tests.c:54:     for (int i = 0; i < *coeffs_x; i++)
	jmp	.L16	#
.L17:
# src/tests.c:56:         printf("filter x: %f\n", filter_x[i]);
	movl	-4(%rbp), %eax	# i, tmp121
	cltq
	leaq	0(,%rax,4), %rdx	#, _2
	movq	-1200056(%rbp), %rax	# filter_x, tmp122
	addq	%rdx, %rax	# _2, _3
	movss	(%rax), %xmm0	# *_3, _4
# src/tests.c:56:         printf("filter x: %f\n", filter_x[i]);
	pxor	%xmm1, %xmm1	# _5
	cvtss2sd	%xmm0, %xmm1	# _4, _5
	movq	%xmm1, %rax	# _5, _5
	movq	%rax, %xmm0	# _5,
	movl	$.LC8, %edi	#,
	movl	$1, %eax	#,
	call	printf	#
# src/tests.c:54:     for (int i = 0; i < *coeffs_x; i++)
	addl	$1, -4(%rbp)	#, i
.L16:
# src/tests.c:54:     for (int i = 0; i < *coeffs_x; i++)
	movq	-1200072(%rbp), %rax	# coeffs_x, tmp123
	movl	(%rax), %eax	# *coeffs_x_30(D), _6
# src/tests.c:54:     for (int i = 0; i < *coeffs_x; i++)
	cmpl	%eax, -4(%rbp)	# _6, i
	jl	.L17	#,
# src/tests.c:58:     printf("ycoeffs: %d\n", *coeffs_y);
	movq	-1200080(%rbp), %rax	# coeffs_y, tmp124
	movl	(%rax), %eax	# *coeffs_y_31(D), _7
	movl	%eax, %esi	# _7,
	movl	$.LC9, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:59:     for (int i = 0; i < *coeffs_y; i++)
	movl	$0, -8(%rbp)	#, i
# src/tests.c:59:     for (int i = 0; i < *coeffs_y; i++)
	jmp	.L18	#
.L19:
# src/tests.c:61:         printf("filter y: %d %f\n", i, filter_y[i]);
	movl	-8(%rbp), %eax	# i, tmp125
	cltq
	leaq	0(,%rax,4), %rdx	#, _9
	movq	-1200064(%rbp), %rax	# filter_y, tmp126
	addq	%rdx, %rax	# _9, _10
	movss	(%rax), %xmm0	# *_10, _11
# src/tests.c:61:         printf("filter y: %d %f\n", i, filter_y[i]);
	pxor	%xmm2, %xmm2	# _12
	cvtss2sd	%xmm0, %xmm2	# _11, _12
	movq	%xmm2, %rdx	# _12, _12
	movl	-8(%rbp), %eax	# i, tmp127
	movq	%rdx, %xmm0	# _12,
	movl	%eax, %esi	# tmp127,
	movl	$.LC10, %edi	#,
	movl	$1, %eax	#,
	call	printf	#
# src/tests.c:59:     for (int i = 0; i < *coeffs_y; i++)
	addl	$1, -8(%rbp)	#, i
.L18:
# src/tests.c:59:     for (int i = 0; i < *coeffs_y; i++)
	movq	-1200080(%rbp), %rax	# coeffs_y, tmp128
	movl	(%rax), %eax	# *coeffs_y_31(D), _13
# src/tests.c:59:     for (int i = 0; i < *coeffs_y; i++)
	cmpl	%eax, -8(%rbp)	# _13, i
	jl	.L19	#,
# src/tests.c:64:     float filter_output[MAX_SAMPLES] = {};
	leaq	-1200032(%rbp), %rax	#, tmp129
	movl	$1200000, %edx	#, tmp130
	movl	$0, %esi	#,
	movq	%rax, %rdi	# tmp129,
	call	memset	#
# src/tests.c:65:     profiler_start();
	call	profiler_start	#
# src/tests.c:66:     iir_filter_naive(input_data, filter_output, data_samples, filter_x,
	movl	-16(%rbp), %edx	# data_samples, data_samples.0_14
	movq	-1200072(%rbp), %r8	# coeffs_x, tmp133
	movq	-1200064(%rbp), %rdi	# filter_y, tmp134
	movq	-1200056(%rbp), %rcx	# filter_x, tmp135
	leaq	-1200032(%rbp), %rsi	#, tmp136
	movq	-1200048(%rbp), %rax	# input_data, tmp137
	subq	$8, %rsp	#,
	pushq	-1200080(%rbp)	# coeffs_y
	movq	%r8, %r9	# tmp133,
	movq	%rdi, %r8	# tmp134,
	movq	%rax, %rdi	# tmp137,
	call	iir_filter_naive	#
	addq	$16, %rsp	#,
# src/tests.c:68:     profiler_stop();
	call	profiler_stop	#
# src/tests.c:69:     printf("time elapsed in ticks: %d\n", profiler_get_elapsed_time());
	call	profiler_get_elapsed_time	#
# src/tests.c:69:     printf("time elapsed in ticks: %d\n", profiler_get_elapsed_time());
	movl	%eax, %esi	# _15,
	movl	$.LC11, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:70:     FILE *file = fopen(outputfile, "w");
	movq	-1200040(%rbp), %rax	# outputfile, tmp138
	movl	$.LC2, %esi	#,
	movq	%rax, %rdi	# tmp138,
	call	fopen	#
	movq	%rax, -24(%rbp)	# tmp139, file
# src/tests.c:71:     for (int i = 0; i < data_samples; i++)
	movl	$0, -12(%rbp)	#, i
# src/tests.c:71:     for (int i = 0; i < data_samples; i++)
	jmp	.L20	#
.L21:
# src/tests.c:73:         fprintf(file, "%f\n", filter_output[i]);
	movl	-12(%rbp), %eax	# i, tmp141
	cltq
	movss	-1200032(%rbp,%rax,4), %xmm0	# filter_output[i_20], _16
# src/tests.c:73:         fprintf(file, "%f\n", filter_output[i]);
	pxor	%xmm3, %xmm3	# _17
	cvtss2sd	%xmm0, %xmm3	# _16, _17
	movq	%xmm3, %rdx	# _17, _17
	movq	-24(%rbp), %rax	# file, tmp142
	movq	%rdx, %xmm0	# _17,
	movl	$.LC12, %esi	#,
	movq	%rax, %rdi	# tmp142,
	movl	$1, %eax	#,
	call	fprintf	#
# src/tests.c:71:     for (int i = 0; i < data_samples; i++)
	addl	$1, -12(%rbp)	#, i
.L20:
# src/tests.c:71:     for (int i = 0; i < data_samples; i++)
	movl	-12(%rbp), %eax	# i, tmp143
	cmpl	-16(%rbp), %eax	# data_samples, tmp143
	jl	.L21	#,
# src/tests.c:75:     fclose(file);
	movq	-24(%rbp), %rax	# file, tmp144
	movq	%rax, %rdi	# tmp144,
	call	fclose	#
# src/tests.c:76: }
	nop	
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE2:
	.size	test_iir_filter_float, .-test_iir_filter_float
	.section	.rodata
.LC13:
	.string	"tools/limit_cycle_test.csv"
	.align 8
.LC14:
	.string	"input data sf: %d, filter sf: num %d den %d\n"
.LC15:
	.string	"filter x: %d\n"
.LC16:
	.string	"filter y: %d %d\n"
.LC17:
	.string	"%d\n"
	.text
	.globl	test_iir_filter_fixed
	.type	test_iir_filter_fixed, @function
test_iir_filter_fixed:
.LFB3:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$600064, %rsp	#,
	movq	%rdi, -600040(%rbp)	# outputfile, outputfile
	movq	%rsi, -600048(%rbp)	# input_data, input_data
	movq	%rdx, -600056(%rbp)	# filter, filter
# src/tests.c:81:     int data_samples = load_accelerometer_data_fixed(
	movq	-600048(%rbp), %rax	# input_data, tmp118
	movl	$300000, %edx	#,
	movq	%rax, %rsi	# tmp118,
	movl	$.LC13, %edi	#,
	call	load_accelerometer_data_fixed	#
	movl	%eax, -16(%rbp)	# tmp119, data_samples
# src/tests.c:83:     load_coefficients_fixed("tools/IIR_filter_coeffs.txt", IIR, filter);
	movq	-600056(%rbp), %rax	# filter, tmp120
	movq	%rax, %rdx	# tmp120,
	movl	$1, %esi	#,
	movl	$.LC7, %edi	#,
	call	load_coefficients_fixed	#
# src/tests.c:86:            filter->den_scale_factor_exp);
	movq	-600056(%rbp), %rax	# filter, tmp121
	movzbl	405(%rax), %eax	# filter_31(D)->den_scale_factor_exp, _1
# src/tests.c:84:     printf("input data sf: %d, filter sf: num %d den %d\n",
	movzbl	%al, %ecx	# _1, _2
# src/tests.c:85:            input_data->scale_factor_exp, filter->num_scale_factor_exp,
	movq	-600056(%rbp), %rax	# filter, tmp122
	movzbl	404(%rax), %eax	# filter_31(D)->num_scale_factor_exp, _3
# src/tests.c:84:     printf("input data sf: %d, filter sf: num %d den %d\n",
	movzbl	%al, %edx	# _3, _4
# src/tests.c:85:            input_data->scale_factor_exp, filter->num_scale_factor_exp,
	movq	-600048(%rbp), %rax	# input_data, tmp123
	movzbl	600000(%rax), %eax	# input_data_28(D)->scale_factor_exp, _5
# src/tests.c:84:     printf("input data sf: %d, filter sf: num %d den %d\n",
	movsbl	%al, %eax	# _5, _6
	movl	%eax, %esi	# _6,
	movl	$.LC14, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:87:     for (int i = 0; i < filter->x_coeffs; i++)
	movl	$0, -4(%rbp)	#, i
# src/tests.c:87:     for (int i = 0; i < filter->x_coeffs; i++)
	jmp	.L23	#
.L24:
# src/tests.c:89:         printf("filter x: %d\n", filter->x[i]);
	movq	-600056(%rbp), %rax	# filter, tmp124
	movl	-4(%rbp), %edx	# i, tmp126
	movslq	%edx, %rdx	# tmp126, tmp125
	movzwl	(%rax,%rdx,2), %eax	# filter_31(D)->x[i_21], _7
# src/tests.c:89:         printf("filter x: %d\n", filter->x[i]);
	cwtl
	movl	%eax, %esi	# _8,
	movl	$.LC15, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:87:     for (int i = 0; i < filter->x_coeffs; i++)
	addl	$1, -4(%rbp)	#, i
.L23:
# src/tests.c:87:     for (int i = 0; i < filter->x_coeffs; i++)
	movq	-600056(%rbp), %rax	# filter, tmp127
	movzwl	400(%rax), %eax	# filter_31(D)->x_coeffs, _9
	movzwl	%ax, %eax	# _9, _10
# src/tests.c:87:     for (int i = 0; i < filter->x_coeffs; i++)
	cmpl	%eax, -4(%rbp)	# _10, i
	jl	.L24	#,
# src/tests.c:91:     printf("ycoeffs: %d\n", filter->y_coeffs);
	movq	-600056(%rbp), %rax	# filter, tmp128
	movzwl	402(%rax), %eax	# filter_31(D)->y_coeffs, _11
# src/tests.c:91:     printf("ycoeffs: %d\n", filter->y_coeffs);
	movzwl	%ax, %eax	# _11, _12
	movl	%eax, %esi	# _12,
	movl	$.LC9, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:92:     for (int i = 0; i < filter->y_coeffs; i++)
	movl	$0, -8(%rbp)	#, i
# src/tests.c:92:     for (int i = 0; i < filter->y_coeffs; i++)
	jmp	.L25	#
.L26:
# src/tests.c:94:         printf("filter y: %d %d\n", i, filter->y[i]);
	movq	-600056(%rbp), %rax	# filter, tmp129
	movl	-8(%rbp), %edx	# i, tmp131
	movslq	%edx, %rdx	# tmp131, tmp130
	addq	$96, %rdx	#, tmp132
	movzwl	8(%rax,%rdx,2), %eax	# filter_31(D)->y[i_22], _13
# src/tests.c:94:         printf("filter y: %d %d\n", i, filter->y[i]);
	movswl	%ax, %edx	# _13, _14
	movl	-8(%rbp), %eax	# i, tmp133
	movl	%eax, %esi	# tmp133,
	movl	$.LC16, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:92:     for (int i = 0; i < filter->y_coeffs; i++)
	addl	$1, -8(%rbp)	#, i
.L25:
# src/tests.c:92:     for (int i = 0; i < filter->y_coeffs; i++)
	movq	-600056(%rbp), %rax	# filter, tmp134
	movzwl	402(%rax), %eax	# filter_31(D)->y_coeffs, _15
	movzwl	%ax, %eax	# _15, _16
# src/tests.c:92:     for (int i = 0; i < filter->y_coeffs; i++)
	cmpl	%eax, -8(%rbp)	# _16, i
	jl	.L26	#,
# src/tests.c:97:     int16_t filter_output[MAX_SAMPLES] = {};
	leaq	-600032(%rbp), %rax	#, tmp135
	movl	$600000, %edx	#, tmp136
	movl	$0, %esi	#,
	movq	%rax, %rdi	# tmp135,
	call	memset	#
# src/tests.c:98:     profiler_start();
	call	profiler_start	#
# src/tests.c:99:     iir_filter_fixed_point(input_data, filter_output, data_samples, filter);
	movl	-16(%rbp), %edx	# data_samples, data_samples.1_17
	movq	-600056(%rbp), %rcx	# filter, tmp139
	leaq	-600032(%rbp), %rsi	#, tmp140
	movq	-600048(%rbp), %rax	# input_data, tmp141
	movq	%rax, %rdi	# tmp141,
	call	iir_filter_fixed_point	#
# src/tests.c:100:     profiler_stop();
	call	profiler_stop	#
# src/tests.c:101:     printf("time elapsed in ticks: %d\n", profiler_get_elapsed_time());
	call	profiler_get_elapsed_time	#
# src/tests.c:101:     printf("time elapsed in ticks: %d\n", profiler_get_elapsed_time());
	movl	%eax, %esi	# _18,
	movl	$.LC11, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:102:     FILE *file = fopen(outputfile, "w");
	movq	-600040(%rbp), %rax	# outputfile, tmp142
	movl	$.LC2, %esi	#,
	movq	%rax, %rdi	# tmp142,
	call	fopen	#
	movq	%rax, -24(%rbp)	# tmp143, file
# src/tests.c:103:     for (int i = 0; i < data_samples; i++)
	movl	$0, -12(%rbp)	#, i
# src/tests.c:103:     for (int i = 0; i < data_samples; i++)
	jmp	.L27	#
.L28:
# src/tests.c:105:         fprintf(file, "%d\n", (int)filter_output[i]);
	movl	-12(%rbp), %eax	# i, tmp145
	cltq
	movzwl	-600032(%rbp,%rax,2), %eax	# filter_output[i_23], _19
# src/tests.c:105:         fprintf(file, "%d\n", (int)filter_output[i]);
	movswl	%ax, %edx	# _19, _20
	movq	-24(%rbp), %rax	# file, tmp146
	movl	$.LC17, %esi	#,
	movq	%rax, %rdi	# tmp146,
	movl	$0, %eax	#,
	call	fprintf	#
# src/tests.c:103:     for (int i = 0; i < data_samples; i++)
	addl	$1, -12(%rbp)	#, i
.L27:
# src/tests.c:103:     for (int i = 0; i < data_samples; i++)
	movl	-12(%rbp), %eax	# i, tmp147
	cmpl	-16(%rbp), %eax	# data_samples, tmp147
	jl	.L28	#,
# src/tests.c:107:     fclose(file);
	movq	-24(%rbp), %rax	# file, tmp148
	movq	%rax, %rdi	# tmp148,
	call	fclose	#
# src/tests.c:108: }
	nop	
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE3:
	.size	test_iir_filter_fixed, .-test_iir_filter_fixed
	.section	.rodata
.LC18:
	.string	"tools/biquad1.txt"
.LC19:
	.string	"tools/biquad2.txt"
.LC20:
	.string	"input data sf: %d\n"
.LC21:
	.string	"biquad sf: num %d den %d\n"
.LC22:
	.string	"b coefficients:"
.LC23:
	.string	"b0: %d\n"
.LC24:
	.string	"b1: %d\n"
.LC25:
	.string	"b2: %d\n"
.LC26:
	.string	"a coefficients:"
.LC27:
	.string	"a1: %d\n"
.LC28:
	.string	"a2: %d\n"
	.text
	.globl	test_iir_biquad_fixed
	.type	test_iir_biquad_fixed, @function
test_iir_biquad_fixed:
.LFB4:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$1200096, %rsp	#,
	movq	%rdi, -1200088(%rbp)	# outputfile, outputfile
	movq	%rsi, -1200096(%rbp)	# input_data, input_data
# src/tests.c:111:     int data_samples = load_accelerometer_data_fixed(
	movq	-1200096(%rbp), %rax	# input_data, tmp134
	movl	$300000, %edx	#,
	movq	%rax, %rsi	# tmp134,
	movl	$.LC13, %edi	#,
	call	load_accelerometer_data_fixed	#
	movl	%eax, -8(%rbp)	# tmp135, data_samples
# src/tests.c:114:     const char *biquad_files[] = {"tools/biquad1.txt", "tools/biquad2.txt"
	movq	$.LC18, -32(%rbp)	#, biquad_files[0]
	movq	$.LC19, -24(%rbp)	#, biquad_files[1]
# src/tests.c:118:     biquad_t biquads[2] = {};
	pxor	%xmm0, %xmm0	# tmp136
	movaps	%xmm0, -64(%rbp)	# tmp136, biquads
	movq	%xmm0, -48(%rbp)	# tmp136, biquads
# src/tests.c:120:     load_biquad_fixed(biquad_files, biquads, 2);
	leaq	-64(%rbp), %rcx	#, tmp137
	leaq	-32(%rbp), %rax	#, tmp138
	movl	$2, %edx	#,
	movq	%rcx, %rsi	# tmp137,
	movq	%rax, %rdi	# tmp138,
	call	load_biquad_fixed	#
# src/tests.c:122:     printf("input data sf: %d\n", input_data->scale_factor_exp);
	movq	-1200096(%rbp), %rax	# input_data, tmp139
	movzbl	600000(%rax), %eax	# input_data_40(D)->scale_factor_exp, _1
# src/tests.c:122:     printf("input data sf: %d\n", input_data->scale_factor_exp);
	movsbl	%al, %eax	# _1, _2
	movl	%eax, %esi	# _2,
	movl	$.LC20, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:123:     printf("biquad sf: num %d den %d\n", biquads[0].num_sf, biquads[0].den_sf);
	movzbl	-53(%rbp), %eax	# biquads[0].den_sf, _3
# src/tests.c:123:     printf("biquad sf: num %d den %d\n", biquads[0].num_sf, biquads[0].den_sf);
	movzbl	%al, %edx	# _3, _4
# src/tests.c:123:     printf("biquad sf: num %d den %d\n", biquads[0].num_sf, biquads[0].den_sf);
	movzbl	-54(%rbp), %eax	# biquads[0].num_sf, _5
# src/tests.c:123:     printf("biquad sf: num %d den %d\n", biquads[0].num_sf, biquads[0].den_sf);
	movzbl	%al, %eax	# _5, _6
	movl	%eax, %esi	# _6,
	movl	$.LC21, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:124:     printf("biquad sf: num %d den %d\n", biquads[1].num_sf, biquads[1].den_sf);
	movzbl	-41(%rbp), %eax	# biquads[1].den_sf, _7
# src/tests.c:124:     printf("biquad sf: num %d den %d\n", biquads[1].num_sf, biquads[1].den_sf);
	movzbl	%al, %edx	# _7, _8
# src/tests.c:124:     printf("biquad sf: num %d den %d\n", biquads[1].num_sf, biquads[1].den_sf);
	movzbl	-42(%rbp), %eax	# biquads[1].num_sf, _9
# src/tests.c:124:     printf("biquad sf: num %d den %d\n", biquads[1].num_sf, biquads[1].den_sf);
	movzbl	%al, %eax	# _9, _10
	movl	%eax, %esi	# _10,
	movl	$.LC21, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:126:     printf("b coefficients:\n");
	movl	$.LC22, %edi	#,
	call	puts	#
# src/tests.c:127:     printf("b0: %d\n", biquads[0].b0);
	movzwl	-64(%rbp), %eax	# biquads[0].b0, _11
# src/tests.c:127:     printf("b0: %d\n", biquads[0].b0);
	cwtl
	movl	%eax, %esi	# _12,
	movl	$.LC23, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:128:     printf("b1: %d\n", biquads[0].b1);
	movzwl	-62(%rbp), %eax	# biquads[0].b1, _13
# src/tests.c:128:     printf("b1: %d\n", biquads[0].b1);
	cwtl
	movl	%eax, %esi	# _14,
	movl	$.LC24, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:129:     printf("b2: %d\n", biquads[0].b2);
	movzwl	-60(%rbp), %eax	# biquads[0].b2, _15
# src/tests.c:129:     printf("b2: %d\n", biquads[0].b2);
	cwtl
	movl	%eax, %esi	# _16,
	movl	$.LC25, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:131:     printf("a coefficients:\n");
	movl	$.LC26, %edi	#,
	call	puts	#
# src/tests.c:132:     printf("a1: %d\n", biquads[0].a1);
	movzwl	-58(%rbp), %eax	# biquads[0].a1, _17
# src/tests.c:132:     printf("a1: %d\n", biquads[0].a1);
	cwtl
	movl	%eax, %esi	# _18,
	movl	$.LC27, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:133:     printf("a2: %d\n", biquads[0].a2);
	movzwl	-56(%rbp), %eax	# biquads[0].a2, _19
# src/tests.c:133:     printf("a2: %d\n", biquads[0].a2);
	cwtl
	movl	%eax, %esi	# _20,
	movl	$.LC28, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:135:     printf("b coefficients:\n");
	movl	$.LC22, %edi	#,
	call	puts	#
# src/tests.c:136:     printf("b0: %d\n", biquads[1].b0);
	movzwl	-52(%rbp), %eax	# biquads[1].b0, _21
# src/tests.c:136:     printf("b0: %d\n", biquads[1].b0);
	cwtl
	movl	%eax, %esi	# _22,
	movl	$.LC23, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:137:     printf("b1: %d\n", biquads[1].b1);
	movzwl	-50(%rbp), %eax	# biquads[1].b1, _23
# src/tests.c:137:     printf("b1: %d\n", biquads[1].b1);
	cwtl
	movl	%eax, %esi	# _24,
	movl	$.LC24, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:138:     printf("b2: %d\n", biquads[1].b2);
	movzwl	-48(%rbp), %eax	# biquads[1].b2, _25
# src/tests.c:138:     printf("b2: %d\n", biquads[1].b2);
	cwtl
	movl	%eax, %esi	# _26,
	movl	$.LC25, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:140:     printf("a coefficients:\n");
	movl	$.LC26, %edi	#,
	call	puts	#
# src/tests.c:141:     printf("a1: %d\n", biquads[1].a1);
	movzwl	-46(%rbp), %eax	# biquads[1].a1, _27
# src/tests.c:141:     printf("a1: %d\n", biquads[1].a1);
	cwtl
	movl	%eax, %esi	# _28,
	movl	$.LC27, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:142:     printf("a2: %d\n", biquads[1].a2);
	movzwl	-44(%rbp), %eax	# biquads[1].a2, _29
# src/tests.c:142:     printf("a2: %d\n", biquads[1].a2);
	cwtl
	movl	%eax, %esi	# _30,
	movl	$.LC28, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:143:     input_data_t filter1_output = {};
	leaq	-600080(%rbp), %rax	#, tmp140
	movl	$600002, %edx	#, tmp141
	movl	$0, %esi	#,
	movq	%rax, %rdi	# tmp140,
	call	memset	#
# src/tests.c:144:     filter1_output.scale_factor_exp = input_data->scale_factor_exp;
	movq	-1200096(%rbp), %rax	# input_data, tmp144
	movzbl	600000(%rax), %eax	# input_data_40(D)->scale_factor_exp, _31
# src/tests.c:144:     filter1_output.scale_factor_exp = input_data->scale_factor_exp;
	movb	%al, -80(%rbp)	# _31, filter1_output.scale_factor_exp
# src/tests.c:145:     int16_t filter_output[MAX_SAMPLES] = {};
	leaq	-1200080(%rbp), %rax	#, tmp145
	movl	$600000, %edx	#, tmp146
	movl	$0, %esi	#,
	movq	%rax, %rdi	# tmp145,
	call	memset	#
# src/tests.c:146:     profiler_start();
	call	profiler_start	#
# src/tests.c:147:     iir_filter_biquad(input_data, filter1_output.input_data_buffer,
	movl	-8(%rbp), %edx	# data_samples, data_samples.2_32
	leaq	-64(%rbp), %rcx	#, tmp149
	leaq	-600080(%rbp), %rsi	#, tmp150
	movq	-1200096(%rbp), %rax	# input_data, tmp151
	movq	%rax, %rdi	# tmp151,
	call	iir_filter_biquad	#
# src/tests.c:149:     iir_filter_biquad(&filter1_output, filter_output, data_samples,
	movl	-8(%rbp), %edx	# data_samples, data_samples.3_33
	leaq	-64(%rbp), %rax	#, tmp152
	leaq	12(%rax), %rcx	#, tmp153
	leaq	-1200080(%rbp), %rsi	#, tmp154
	leaq	-600080(%rbp), %rax	#, tmp155
	movq	%rax, %rdi	# tmp155,
	call	iir_filter_biquad	#
# src/tests.c:151:     profiler_stop();
	call	profiler_stop	#
# src/tests.c:153:     printf("time elapsed in ticks: %d\n", profiler_get_elapsed_time());
	call	profiler_get_elapsed_time	#
# src/tests.c:153:     printf("time elapsed in ticks: %d\n", profiler_get_elapsed_time());
	movl	%eax, %esi	# _34,
	movl	$.LC11, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:155:     FILE *file = fopen(outputfile, "w");
	movq	-1200088(%rbp), %rax	# outputfile, tmp156
	movl	$.LC2, %esi	#,
	movq	%rax, %rdi	# tmp156,
	call	fopen	#
	movq	%rax, -16(%rbp)	# tmp157, file
# src/tests.c:157:     for (int i = 0; i < data_samples; i++)
	movl	$0, -4(%rbp)	#, i
# src/tests.c:157:     for (int i = 0; i < data_samples; i++)
	jmp	.L30	#
.L31:
# src/tests.c:159:         fprintf(file, "%d\n", (int)filter_output[i]);
	movl	-4(%rbp), %eax	# i, tmp159
	cltq
	movzwl	-1200080(%rbp,%rax,2), %eax	# filter_output[i_37], _35
# src/tests.c:159:         fprintf(file, "%d\n", (int)filter_output[i]);
	movswl	%ax, %edx	# _35, _36
	movq	-16(%rbp), %rax	# file, tmp160
	movl	$.LC17, %esi	#,
	movq	%rax, %rdi	# tmp160,
	movl	$0, %eax	#,
	call	fprintf	#
# src/tests.c:157:     for (int i = 0; i < data_samples; i++)
	addl	$1, -4(%rbp)	#, i
.L30:
# src/tests.c:157:     for (int i = 0; i < data_samples; i++)
	movl	-4(%rbp), %eax	# i, tmp161
	cmpl	-8(%rbp), %eax	# data_samples, tmp161
	jl	.L31	#,
# src/tests.c:162:     fclose(file);
	movq	-16(%rbp), %rax	# file, tmp162
	movq	%rax, %rdi	# tmp162,
	call	fclose	#
# src/tests.c:163: }
	nop	
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE4:
	.size	test_iir_biquad_fixed, .-test_iir_biquad_fixed
	.section	.rodata
	.align 8
.LC29:
	.string	"input data sf: %d, filter sf: %d\n"
	.text
	.globl	test_fir_filter
	.type	test_fir_filter, @function
test_fir_filter:
.LFB5:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$600064, %rsp	#,
	movq	%rdi, -600040(%rbp)	# outputfile, outputfile
	movq	%rsi, -600048(%rbp)	# input_data, input_data
	movq	%rdx, -600056(%rbp)	# filter, filter
# src/tests.c:168:     int data_samples = load_accelerometer_data_fixed(
	movq	-600048(%rbp), %rax	# input_data, tmp114
	movl	$300000, %edx	#,
	movq	%rax, %rsi	# tmp114,
	movl	$.LC13, %edi	#,
	call	load_accelerometer_data_fixed	#
	movl	%eax, -12(%rbp)	# tmp115, data_samples
# src/tests.c:171:     load_coefficients_fixed("tools/FIR_filter_coeffs.txt", FIR, filter);
	movq	-600056(%rbp), %rax	# filter, tmp116
	movq	%rax, %rdx	# tmp116,
	movl	$0, %esi	#,
	movl	$.LC1, %edi	#,
	call	load_coefficients_fixed	#
# src/tests.c:174:            filter->num_scale_factor_exp);
	movq	-600056(%rbp), %rax	# filter, tmp117
	movzbl	404(%rax), %eax	# filter_25(D)->num_scale_factor_exp, _1
# src/tests.c:173:     printf("input data sf: %d, filter sf: %d\n", input_data->scale_factor_exp,
	movzbl	%al, %edx	# _1, _2
# src/tests.c:173:     printf("input data sf: %d, filter sf: %d\n", input_data->scale_factor_exp,
	movq	-600048(%rbp), %rax	# input_data, tmp118
	movzbl	600000(%rax), %eax	# input_data_22(D)->scale_factor_exp, _3
# src/tests.c:173:     printf("input data sf: %d, filter sf: %d\n", input_data->scale_factor_exp,
	movsbl	%al, %eax	# _3, _4
	movl	%eax, %esi	# _4,
	movl	$.LC29, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:176:     for (int i = 0; i < filter->x_coeffs; i++)
	movl	$0, -4(%rbp)	#, i
# src/tests.c:176:     for (int i = 0; i < filter->x_coeffs; i++)
	jmp	.L33	#
.L34:
# src/tests.c:178:         printf("filter x: %d\n", filter->x[i]);
	movq	-600056(%rbp), %rax	# filter, tmp119
	movl	-4(%rbp), %edx	# i, tmp121
	movslq	%edx, %rdx	# tmp121, tmp120
	movzwl	(%rax,%rdx,2), %eax	# filter_25(D)->x[i_17], _5
# src/tests.c:178:         printf("filter x: %d\n", filter->x[i]);
	cwtl
	movl	%eax, %esi	# _6,
	movl	$.LC15, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:176:     for (int i = 0; i < filter->x_coeffs; i++)
	addl	$1, -4(%rbp)	#, i
.L33:
# src/tests.c:176:     for (int i = 0; i < filter->x_coeffs; i++)
	movq	-600056(%rbp), %rax	# filter, tmp122
	movzwl	400(%rax), %eax	# filter_25(D)->x_coeffs, _7
	movzwl	%ax, %eax	# _7, _8
# src/tests.c:176:     for (int i = 0; i < filter->x_coeffs; i++)
	cmpl	%eax, -4(%rbp)	# _8, i
	jl	.L34	#,
# src/tests.c:181:     int16_t filter_output[MAX_SAMPLES] = {};
	leaq	-600032(%rbp), %rax	#, tmp123
	movl	$600000, %edx	#, tmp124
	movl	$0, %esi	#,
	movq	%rax, %rdi	# tmp123,
	call	memset	#
# src/tests.c:184:                filter->num_scale_factor_exp, filter->x_coeffs);
	movq	-600056(%rbp), %rax	# filter, tmp127
	movzwl	400(%rax), %eax	# filter_25(D)->x_coeffs, _9
# src/tests.c:183:     fir_filter(input_data, filter_output, data_samples, filter->x,
	movzwl	%ax, %r8d	# _9, _10
# src/tests.c:184:                filter->num_scale_factor_exp, filter->x_coeffs);
	movq	-600056(%rbp), %rax	# filter, tmp128
	movzbl	404(%rax), %eax	# filter_25(D)->num_scale_factor_exp, _11
# src/tests.c:183:     fir_filter(input_data, filter_output, data_samples, filter->x,
	movzbl	%al, %eax	# _11, _12
# src/tests.c:183:     fir_filter(input_data, filter_output, data_samples, filter->x,
	movq	-600056(%rbp), %rcx	# filter, _13
# src/tests.c:183:     fir_filter(input_data, filter_output, data_samples, filter->x,
	movl	-12(%rbp), %edx	# data_samples, data_samples.4_14
	movswl	%ax, %edi	# _12, tmp129
	leaq	-600032(%rbp), %rsi	#, tmp130
	movq	-600048(%rbp), %rax	# input_data, tmp131
	movl	%r8d, %r9d	# _10,
	movl	%edi, %r8d	# tmp129,
	movq	%rax, %rdi	# tmp131,
	call	fir_filter	#
# src/tests.c:186:     FILE *file = fopen(outputfile, "w");
	movq	-600040(%rbp), %rax	# outputfile, tmp132
	movl	$.LC2, %esi	#,
	movq	%rax, %rdi	# tmp132,
	call	fopen	#
	movq	%rax, -24(%rbp)	# tmp133, file
# src/tests.c:188:     for (int i = 0; i < data_samples; i++)
	movl	$0, -8(%rbp)	#, i
# src/tests.c:188:     for (int i = 0; i < data_samples; i++)
	jmp	.L35	#
.L36:
# src/tests.c:190:         fprintf(file, "%d\n", filter_output[i]);
	movl	-8(%rbp), %eax	# i, tmp135
	cltq
	movzwl	-600032(%rbp,%rax,2), %eax	# filter_output[i_18], _15
# src/tests.c:190:         fprintf(file, "%d\n", filter_output[i]);
	movswl	%ax, %edx	# _15, _16
	movq	-24(%rbp), %rax	# file, tmp136
	movl	$.LC17, %esi	#,
	movq	%rax, %rdi	# tmp136,
	movl	$0, %eax	#,
	call	fprintf	#
# src/tests.c:188:     for (int i = 0; i < data_samples; i++)
	addl	$1, -8(%rbp)	#, i
.L35:
# src/tests.c:188:     for (int i = 0; i < data_samples; i++)
	movl	-8(%rbp), %eax	# i, tmp137
	cmpl	-12(%rbp), %eax	# data_samples, tmp137
	jl	.L36	#,
# src/tests.c:192:     fclose(file);
	movq	-24(%rbp), %rax	# file, tmp138
	movq	%rax, %rdi	# tmp138,
	call	fclose	#
# src/tests.c:193: }
	nop	
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE5:
	.size	test_fir_filter, .-test_fir_filter
	.ident	"GCC: (GNU) 16.1.1 20260515 (Red Hat 16.1.1-2)"
	.section	.note.GNU-stack,"",@progbits
