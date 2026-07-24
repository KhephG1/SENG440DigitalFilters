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
# src/tests.c:12:     int data_samples = load_accelerometer_data_fixed("tools/data.csv",
	movq	-48(%rbp), %rax	# input_data, tmp102
	movl	$300000, %edx	#,
	movq	%rax, %rsi	# tmp102,
	movl	$.LC0, %edi	#,
	call	load_accelerometer_data_fixed	#
	movl	%eax, -12(%rbp)	# tmp103, data_samples
# src/tests.c:15:         load_coefficients_fixed("tools/FIR_filter_coeffs.txt", FIR, filter);
	movq	-56(%rbp), %rax	# filter, tmp104
	movq	%rax, %rdx	# tmp104,
	movl	$0, %esi	#,
	movl	$.LC1, %edi	#,
	call	load_coefficients_fixed	#
	movl	%eax, -16(%rbp)	# tmp105, coeffs
# src/tests.c:16:     FILE *file = fopen(output, "w");
	movq	-40(%rbp), %rax	# output, tmp106
	movl	$.LC2, %esi	#,
	movq	%rax, %rdi	# tmp106,
	call	fopen	#
	movq	%rax, -24(%rbp)	# tmp107, file
# src/tests.c:17:     fprintf(file, "data samples: %d coeffs: %d", data_samples, coeffs);
	movl	-16(%rbp), %ecx	# coeffs, tmp108
	movl	-12(%rbp), %edx	# data_samples, tmp109
	movq	-24(%rbp), %rax	# file, tmp110
	movl	$.LC3, %esi	#,
	movq	%rax, %rdi	# tmp110,
	movl	$0, %eax	#,
	call	fprintf	#
# src/tests.c:18:     for (int i = 0; i < data_samples; i++)
	movl	$0, -4(%rbp)	#, i
# src/tests.c:18:     for (int i = 0; i < data_samples; i++)
	jmp	.L2	#
.L3:
# src/tests.c:21:                 input_data->input_data_buffer[i]);
	movq	-48(%rbp), %rax	# input_data, tmp111
	movl	-4(%rbp), %edx	# i, tmp113
	movslq	%edx, %rdx	# tmp113, tmp112
	movzwl	(%rax,%rdx,2), %eax	# input_data_10(D)->input_data_buffer[i_5], _1
# src/tests.c:20:         fprintf(file, "input_samples[%d]: %d\n", i,
	movswl	%ax, %ecx	# _1, _2
	movl	-4(%rbp), %edx	# i, tmp114
	movq	-24(%rbp), %rax	# file, tmp115
	movl	$.LC4, %esi	#,
	movq	%rax, %rdi	# tmp115,
	movl	$0, %eax	#,
	call	fprintf	#
# src/tests.c:18:     for (int i = 0; i < data_samples; i++)
	addl	$1, -4(%rbp)	#, i
.L2:
# src/tests.c:18:     for (int i = 0; i < data_samples; i++)
	movl	-4(%rbp), %eax	# i, tmp116
	cmpl	-12(%rbp), %eax	# data_samples, tmp116
	jl	.L3	#,
# src/tests.c:23:     for (int i = 0; i < coeffs; i++)
	movl	$0, -8(%rbp)	#, i
# src/tests.c:23:     for (int i = 0; i < coeffs; i++)
	jmp	.L4	#
.L5:
# src/tests.c:25:         fprintf(file, "coeffs[%d]: %d\n", i, filter->x[i]);
	movq	-56(%rbp), %rax	# filter, tmp117
	movl	-8(%rbp), %edx	# i, tmp119
	movslq	%edx, %rdx	# tmp119, tmp118
	movzwl	(%rax,%rdx,2), %eax	# filter_13(D)->x[i_6], _3
# src/tests.c:25:         fprintf(file, "coeffs[%d]: %d\n", i, filter->x[i]);
	movswl	%ax, %ecx	# _3, _4
	movl	-8(%rbp), %edx	# i, tmp120
	movq	-24(%rbp), %rax	# file, tmp121
	movl	$.LC5, %esi	#,
	movq	%rax, %rdi	# tmp121,
	movl	$0, %eax	#,
	call	fprintf	#
# src/tests.c:23:     for (int i = 0; i < coeffs; i++)
	addl	$1, -8(%rbp)	#, i
.L4:
# src/tests.c:23:     for (int i = 0; i < coeffs; i++)
	movl	-8(%rbp), %eax	# i, tmp122
	cmpl	-16(%rbp), %eax	# coeffs, tmp122
	jl	.L5	#,
# src/tests.c:27: }
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
# src/tests.c:30:     if (size == 0)
	cmpw	$0, -122(%rbp)	#, size
	je	.L14	#,
# src/tests.c:34:     int16_t output[MAX_TEST_SIZE] = {};
	pxor	%xmm0, %xmm0	# tmp116
	movaps	%xmm0, -112(%rbp)	# tmp116, output
	movaps	%xmm0, -96(%rbp)	# tmp116, output
	movaps	%xmm0, -80(%rbp)	# tmp116, output
	movaps	%xmm0, -64(%rbp)	# tmp116, output
	movaps	%xmm0, -48(%rbp)	# tmp116, output
	movaps	%xmm0, -32(%rbp)	# tmp116, output
	movd	%xmm0, -16(%rbp)	# tmp116, output
# src/tests.c:35:     uint16_t max = 0;
	movw	$0, -2(%rbp)	#, max
# src/tests.c:36:     for (int i = 0; i < (int)size; i++)
	movl	$0, -8(%rbp)	#, i
# src/tests.c:36:     for (int i = 0; i < (int)size; i++)
	jmp	.L9	#
.L12:
# src/tests.c:38:         if (input[i] > max)
	movl	-8(%rbp), %eax	# i, tmp117
	cltq
	leaq	0(,%rax,4), %rdx	#, _2
	movq	-120(%rbp), %rax	# input, tmp118
	addq	%rdx, %rax	# _2, _3
	movss	(%rax), %xmm0	# *_3, _4
# src/tests.c:38:         if (input[i] > max)
	movzwl	-2(%rbp), %eax	# max, _5
	pxor	%xmm1, %xmm1	# _6
	cvtsi2ssl	%eax, %xmm1	# _5, _6
# src/tests.c:38:         if (input[i] > max)
	comiss	%xmm1, %xmm0	# _6, _4
	jbe	.L10	#,
# src/tests.c:40:             max = input[i];
	movl	-8(%rbp), %eax	# i, tmp119
	cltq
	leaq	0(,%rax,4), %rdx	#, _8
	movq	-120(%rbp), %rax	# input, tmp120
	addq	%rdx, %rax	# _8, _9
	movss	(%rax), %xmm0	# *_9, _10
# src/tests.c:40:             max = input[i];
	cvttss2sil	%xmm0, %eax	# _10, tmp121
	movw	%ax, -2(%rbp)	# tmp121, max
.L10:
# src/tests.c:36:     for (int i = 0; i < (int)size; i++)
	addl	$1, -8(%rbp)	#, i
.L9:
# src/tests.c:36:     for (int i = 0; i < (int)size; i++)
	movzwl	-122(%rbp), %eax	# size, _11
# src/tests.c:36:     for (int i = 0; i < (int)size; i++)
	cmpl	%eax, -8(%rbp)	# _11, i
	jl	.L12	#,
# src/tests.c:43:     int8_t sf = convert_to_fixed(input, output, size, pow(2, 15));
	movzwl	-122(%rbp), %edx	# size, _12
	leaq	-112(%rbp), %rsi	#, tmp122
	movq	-120(%rbp), %rax	# input, tmp123
	movl	$32768, %ecx	#,
	movq	%rax, %rdi	# tmp123,
	call	convert_to_fixed	#
	movb	%al, -9(%rbp)	# tmp124, sf
# src/tests.c:46:            input[0], output[0]);
	movzwl	-112(%rbp), %eax	# output[0], _13
# src/tests.c:45:     printf("max: %d, scale factor: 2^%d, input[0]: %f output[0]: %d", max, sf,
	movswl	%ax, %ecx	# _13, _14
# src/tests.c:46:            input[0], output[0]);
	movq	-120(%rbp), %rax	# input, tmp125
	movss	(%rax), %xmm0	# *input_28(D), _15
# src/tests.c:45:     printf("max: %d, scale factor: 2^%d, input[0]: %f output[0]: %d", max, sf,
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
# src/tests.c:32:         return;
	nop	
.L6:
# src/tests.c:47: }
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE1:
	.size	test_fixed_point_math, .-test_fixed_point_math
	.section	.rodata
.LC7:
	.string	"tools/test_data/data.csv"
	.align 8
.LC8:
	.string	"tools/filter_coefficients/IIR_filter_coeffs.txt"
.LC9:
	.string	"filter x: %f\n"
.LC10:
	.string	"ycoeffs: %d\n"
.LC11:
	.string	"filter y: %d %f\n"
.LC12:
	.string	"time elapsed in ticks: %d\n"
.LC13:
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
# src/tests.c:51:     int data_samples = load_accelerometer_data_float("tools/test_data/data.csv",
	movq	-1200048(%rbp), %rax	# input_data, tmp115
	movl	$300000, %edx	#,
	movq	%rax, %rsi	# tmp115,
	movl	$.LC7, %edi	#,
	call	load_accelerometer_data_float	#
	movl	%eax, -16(%rbp)	# tmp116, data_samples
# src/tests.c:53:     load_coefficients_float("tools/filter_coefficients/IIR_filter_coeffs.txt",
	movq	-1200080(%rbp), %rsi	# coeffs_y, tmp117
	movq	-1200072(%rbp), %rcx	# coeffs_x, tmp118
	movq	-1200064(%rbp), %rdx	# filter_y, tmp119
	movq	-1200056(%rbp), %rax	# filter_x, tmp120
	movq	%rsi, %r9	# tmp117,
	movq	%rcx, %r8	# tmp118,
	movq	%rdx, %rcx	# tmp119,
	movq	%rax, %rdx	# tmp120,
	movl	$1, %esi	#,
	movl	$.LC8, %edi	#,
	call	load_coefficients_float	#
# src/tests.c:55:     for (int i = 0; i < *coeffs_x; i++)
	movl	$0, -4(%rbp)	#, i
# src/tests.c:55:     for (int i = 0; i < *coeffs_x; i++)
	jmp	.L16	#
.L17:
# src/tests.c:57:         printf("filter x: %f\n", filter_x[i]);
	movl	-4(%rbp), %eax	# i, tmp121
	cltq
	leaq	0(,%rax,4), %rdx	#, _2
	movq	-1200056(%rbp), %rax	# filter_x, tmp122
	addq	%rdx, %rax	# _2, _3
	movss	(%rax), %xmm0	# *_3, _4
# src/tests.c:57:         printf("filter x: %f\n", filter_x[i]);
	pxor	%xmm1, %xmm1	# _5
	cvtss2sd	%xmm0, %xmm1	# _4, _5
	movq	%xmm1, %rax	# _5, _5
	movq	%rax, %xmm0	# _5,
	movl	$.LC9, %edi	#,
	movl	$1, %eax	#,
	call	printf	#
# src/tests.c:55:     for (int i = 0; i < *coeffs_x; i++)
	addl	$1, -4(%rbp)	#, i
.L16:
# src/tests.c:55:     for (int i = 0; i < *coeffs_x; i++)
	movq	-1200072(%rbp), %rax	# coeffs_x, tmp123
	movl	(%rax), %eax	# *coeffs_x_30(D), _6
# src/tests.c:55:     for (int i = 0; i < *coeffs_x; i++)
	cmpl	%eax, -4(%rbp)	# _6, i
	jl	.L17	#,
# src/tests.c:59:     printf("ycoeffs: %d\n", *coeffs_y);
	movq	-1200080(%rbp), %rax	# coeffs_y, tmp124
	movl	(%rax), %eax	# *coeffs_y_31(D), _7
	movl	%eax, %esi	# _7,
	movl	$.LC10, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:60:     for (int i = 0; i < *coeffs_y; i++)
	movl	$0, -8(%rbp)	#, i
# src/tests.c:60:     for (int i = 0; i < *coeffs_y; i++)
	jmp	.L18	#
.L19:
# src/tests.c:62:         printf("filter y: %d %f\n", i, filter_y[i]);
	movl	-8(%rbp), %eax	# i, tmp125
	cltq
	leaq	0(,%rax,4), %rdx	#, _9
	movq	-1200064(%rbp), %rax	# filter_y, tmp126
	addq	%rdx, %rax	# _9, _10
	movss	(%rax), %xmm0	# *_10, _11
# src/tests.c:62:         printf("filter y: %d %f\n", i, filter_y[i]);
	pxor	%xmm2, %xmm2	# _12
	cvtss2sd	%xmm0, %xmm2	# _11, _12
	movq	%xmm2, %rdx	# _12, _12
	movl	-8(%rbp), %eax	# i, tmp127
	movq	%rdx, %xmm0	# _12,
	movl	%eax, %esi	# tmp127,
	movl	$.LC11, %edi	#,
	movl	$1, %eax	#,
	call	printf	#
# src/tests.c:60:     for (int i = 0; i < *coeffs_y; i++)
	addl	$1, -8(%rbp)	#, i
.L18:
# src/tests.c:60:     for (int i = 0; i < *coeffs_y; i++)
	movq	-1200080(%rbp), %rax	# coeffs_y, tmp128
	movl	(%rax), %eax	# *coeffs_y_31(D), _13
# src/tests.c:60:     for (int i = 0; i < *coeffs_y; i++)
	cmpl	%eax, -8(%rbp)	# _13, i
	jl	.L19	#,
# src/tests.c:65:     float filter_output[MAX_SAMPLES] = {};
	leaq	-1200032(%rbp), %rax	#, tmp129
	movl	$1200000, %edx	#, tmp130
	movl	$0, %esi	#,
	movq	%rax, %rdi	# tmp129,
	call	memset	#
# src/tests.c:66:     profiler_start();
	call	profiler_start	#
# src/tests.c:67:     iir_filter_naive(input_data, filter_output, data_samples, filter_x,
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
# src/tests.c:69:     profiler_stop();
	call	profiler_stop	#
# src/tests.c:70:     printf("time elapsed in ticks: %d\n", profiler_get_elapsed_time());
	call	profiler_get_elapsed_time	#
# src/tests.c:70:     printf("time elapsed in ticks: %d\n", profiler_get_elapsed_time());
	movl	%eax, %esi	# _15,
	movl	$.LC12, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:71:     FILE *file = fopen(outputfile, "w");
	movq	-1200040(%rbp), %rax	# outputfile, tmp138
	movl	$.LC2, %esi	#,
	movq	%rax, %rdi	# tmp138,
	call	fopen	#
	movq	%rax, -24(%rbp)	# tmp139, file
# src/tests.c:72:     for (int i = 0; i < data_samples; i++)
	movl	$0, -12(%rbp)	#, i
# src/tests.c:72:     for (int i = 0; i < data_samples; i++)
	jmp	.L20	#
.L21:
# src/tests.c:74:         fprintf(file, "%f\n", filter_output[i]);
	movl	-12(%rbp), %eax	# i, tmp141
	cltq
	movss	-1200032(%rbp,%rax,4), %xmm0	# filter_output[i_20], _16
# src/tests.c:74:         fprintf(file, "%f\n", filter_output[i]);
	pxor	%xmm3, %xmm3	# _17
	cvtss2sd	%xmm0, %xmm3	# _16, _17
	movq	%xmm3, %rdx	# _17, _17
	movq	-24(%rbp), %rax	# file, tmp142
	movq	%rdx, %xmm0	# _17,
	movl	$.LC13, %esi	#,
	movq	%rax, %rdi	# tmp142,
	movl	$1, %eax	#,
	call	fprintf	#
# src/tests.c:72:     for (int i = 0; i < data_samples; i++)
	addl	$1, -12(%rbp)	#, i
.L20:
# src/tests.c:72:     for (int i = 0; i < data_samples; i++)
	movl	-12(%rbp), %eax	# i, tmp143
	cmpl	-16(%rbp), %eax	# data_samples, tmp143
	jl	.L21	#,
# src/tests.c:76:     fclose(file);
	movq	-24(%rbp), %rax	# file, tmp144
	movq	%rax, %rdi	# tmp144,
	call	fclose	#
# src/tests.c:77: }
	nop	
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE2:
	.size	test_iir_filter_float, .-test_iir_filter_float
	.section	.rodata
	.align 8
.LC14:
	.string	"tools/test_data/limit_cycle_test.csv"
	.align 8
.LC15:
	.string	"input data sf: %d, filter sf: num %d den %d\n"
.LC16:
	.string	"filter x: %d\n"
.LC17:
	.string	"filter y: %d %d\n"
.LC18:
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
# src/tests.c:82:     int data_samples = load_accelerometer_data_fixed(
	movq	-600048(%rbp), %rax	# input_data, tmp118
	movl	$300000, %edx	#,
	movq	%rax, %rsi	# tmp118,
	movl	$.LC14, %edi	#,
	call	load_accelerometer_data_fixed	#
	movl	%eax, -16(%rbp)	# tmp119, data_samples
# src/tests.c:84:     load_coefficients_fixed("tools/filter_coefficients/IIR_filter_coeffs.txt",
	movq	-600056(%rbp), %rax	# filter, tmp120
	movq	%rax, %rdx	# tmp120,
	movl	$1, %esi	#,
	movl	$.LC8, %edi	#,
	call	load_coefficients_fixed	#
# src/tests.c:88:            filter->den_scale_factor_exp);
	movq	-600056(%rbp), %rax	# filter, tmp121
	movzbl	405(%rax), %eax	# filter_31(D)->den_scale_factor_exp, _1
# src/tests.c:86:     printf("input data sf: %d, filter sf: num %d den %d\n",
	movzbl	%al, %ecx	# _1, _2
# src/tests.c:87:            input_data->scale_factor_exp, filter->num_scale_factor_exp,
	movq	-600056(%rbp), %rax	# filter, tmp122
	movzbl	404(%rax), %eax	# filter_31(D)->num_scale_factor_exp, _3
# src/tests.c:86:     printf("input data sf: %d, filter sf: num %d den %d\n",
	movzbl	%al, %edx	# _3, _4
# src/tests.c:87:            input_data->scale_factor_exp, filter->num_scale_factor_exp,
	movq	-600048(%rbp), %rax	# input_data, tmp123
	movzbl	600000(%rax), %eax	# input_data_28(D)->scale_factor_exp, _5
# src/tests.c:86:     printf("input data sf: %d, filter sf: num %d den %d\n",
	movsbl	%al, %eax	# _5, _6
	movl	%eax, %esi	# _6,
	movl	$.LC15, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:89:     for (int i = 0; i < filter->x_coeffs; i++)
	movl	$0, -4(%rbp)	#, i
# src/tests.c:89:     for (int i = 0; i < filter->x_coeffs; i++)
	jmp	.L23	#
.L24:
# src/tests.c:91:         printf("filter x: %d\n", filter->x[i]);
	movq	-600056(%rbp), %rax	# filter, tmp124
	movl	-4(%rbp), %edx	# i, tmp126
	movslq	%edx, %rdx	# tmp126, tmp125
	movzwl	(%rax,%rdx,2), %eax	# filter_31(D)->x[i_21], _7
# src/tests.c:91:         printf("filter x: %d\n", filter->x[i]);
	cwtl
	movl	%eax, %esi	# _8,
	movl	$.LC16, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:89:     for (int i = 0; i < filter->x_coeffs; i++)
	addl	$1, -4(%rbp)	#, i
.L23:
# src/tests.c:89:     for (int i = 0; i < filter->x_coeffs; i++)
	movq	-600056(%rbp), %rax	# filter, tmp127
	movzwl	400(%rax), %eax	# filter_31(D)->x_coeffs, _9
	movzwl	%ax, %eax	# _9, _10
# src/tests.c:89:     for (int i = 0; i < filter->x_coeffs; i++)
	cmpl	%eax, -4(%rbp)	# _10, i
	jl	.L24	#,
# src/tests.c:93:     printf("ycoeffs: %d\n", filter->y_coeffs);
	movq	-600056(%rbp), %rax	# filter, tmp128
	movzwl	402(%rax), %eax	# filter_31(D)->y_coeffs, _11
# src/tests.c:93:     printf("ycoeffs: %d\n", filter->y_coeffs);
	movzwl	%ax, %eax	# _11, _12
	movl	%eax, %esi	# _12,
	movl	$.LC10, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:94:     for (int i = 0; i < filter->y_coeffs; i++)
	movl	$0, -8(%rbp)	#, i
# src/tests.c:94:     for (int i = 0; i < filter->y_coeffs; i++)
	jmp	.L25	#
.L26:
# src/tests.c:96:         printf("filter y: %d %d\n", i, filter->y[i]);
	movq	-600056(%rbp), %rax	# filter, tmp129
	movl	-8(%rbp), %edx	# i, tmp131
	movslq	%edx, %rdx	# tmp131, tmp130
	addq	$96, %rdx	#, tmp132
	movzwl	8(%rax,%rdx,2), %eax	# filter_31(D)->y[i_22], _13
# src/tests.c:96:         printf("filter y: %d %d\n", i, filter->y[i]);
	movswl	%ax, %edx	# _13, _14
	movl	-8(%rbp), %eax	# i, tmp133
	movl	%eax, %esi	# tmp133,
	movl	$.LC17, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:94:     for (int i = 0; i < filter->y_coeffs; i++)
	addl	$1, -8(%rbp)	#, i
.L25:
# src/tests.c:94:     for (int i = 0; i < filter->y_coeffs; i++)
	movq	-600056(%rbp), %rax	# filter, tmp134
	movzwl	402(%rax), %eax	# filter_31(D)->y_coeffs, _15
	movzwl	%ax, %eax	# _15, _16
# src/tests.c:94:     for (int i = 0; i < filter->y_coeffs; i++)
	cmpl	%eax, -8(%rbp)	# _16, i
	jl	.L26	#,
# src/tests.c:99:     int16_t filter_output[MAX_SAMPLES] = {};
	leaq	-600032(%rbp), %rax	#, tmp135
	movl	$600000, %edx	#, tmp136
	movl	$0, %esi	#,
	movq	%rax, %rdi	# tmp135,
	call	memset	#
# src/tests.c:100:     profiler_start();
	call	profiler_start	#
# src/tests.c:101:     iir_filter_fixed_point(input_data, filter_output, data_samples, filter);
	movl	-16(%rbp), %edx	# data_samples, data_samples.1_17
	movq	-600056(%rbp), %rcx	# filter, tmp139
	leaq	-600032(%rbp), %rsi	#, tmp140
	movq	-600048(%rbp), %rax	# input_data, tmp141
	movq	%rax, %rdi	# tmp141,
	call	iir_filter_fixed_point	#
# src/tests.c:102:     profiler_stop();
	call	profiler_stop	#
# src/tests.c:103:     printf("time elapsed in ticks: %d\n", profiler_get_elapsed_time());
	call	profiler_get_elapsed_time	#
# src/tests.c:103:     printf("time elapsed in ticks: %d\n", profiler_get_elapsed_time());
	movl	%eax, %esi	# _18,
	movl	$.LC12, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:104:     FILE *file = fopen(outputfile, "w");
	movq	-600040(%rbp), %rax	# outputfile, tmp142
	movl	$.LC2, %esi	#,
	movq	%rax, %rdi	# tmp142,
	call	fopen	#
	movq	%rax, -24(%rbp)	# tmp143, file
# src/tests.c:105:     for (int i = 0; i < data_samples; i++)
	movl	$0, -12(%rbp)	#, i
# src/tests.c:105:     for (int i = 0; i < data_samples; i++)
	jmp	.L27	#
.L28:
# src/tests.c:107:         fprintf(file, "%d\n", (int)filter_output[i]);
	movl	-12(%rbp), %eax	# i, tmp145
	cltq
	movzwl	-600032(%rbp,%rax,2), %eax	# filter_output[i_23], _19
# src/tests.c:107:         fprintf(file, "%d\n", (int)filter_output[i]);
	movswl	%ax, %edx	# _19, _20
	movq	-24(%rbp), %rax	# file, tmp146
	movl	$.LC18, %esi	#,
	movq	%rax, %rdi	# tmp146,
	movl	$0, %eax	#,
	call	fprintf	#
# src/tests.c:105:     for (int i = 0; i < data_samples; i++)
	addl	$1, -12(%rbp)	#, i
.L27:
# src/tests.c:105:     for (int i = 0; i < data_samples; i++)
	movl	-12(%rbp), %eax	# i, tmp147
	cmpl	-16(%rbp), %eax	# data_samples, tmp147
	jl	.L28	#,
# src/tests.c:109:     fclose(file);
	movq	-24(%rbp), %rax	# file, tmp148
	movq	%rax, %rdi	# tmp148,
	call	fclose	#
# src/tests.c:110: }
	nop	
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE3:
	.size	test_iir_filter_fixed, .-test_iir_filter_fixed
	.section	.rodata
.LC19:
	.string	"samp %d\n"
	.align 8
.LC20:
	.string	"tools/filter_coefficients/biquad_coeffs.txt"
.LC21:
	.string	"error"
.LC22:
	.string	"input data sf: %d\n"
.LC23:
	.string	"biquad sf: num %d den %d\n"
.LC24:
	.string	"b coefficients:"
.LC25:
	.string	"b0: %d\n"
.LC26:
	.string	"b1: %d\n"
.LC27:
	.string	"b2: %d\n"
.LC28:
	.string	"a coefficients:"
.LC29:
	.string	"a1: %d\n"
.LC30:
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
	subq	$1201296, %rsp	#,
	movq	%rdi, -1201288(%rbp)	# outputfile, outputfile
	movq	%rsi, -1201296(%rbp)	# input_data, input_data
# src/tests.c:113:     int data_samples = load_accelerometer_data_fixed(
	movq	-1201296(%rbp), %rax	# input_data, tmp135
	movl	$300000, %edx	#,
	movq	%rax, %rsi	# tmp135,
	movl	$.LC14, %edi	#,
	call	load_accelerometer_data_fixed	#
	movl	%eax, -8(%rbp)	# tmp136, data_samples
# src/tests.c:115:     printf("samp %d\n", data_samples);
	movl	-8(%rbp), %eax	# data_samples, tmp137
	movl	%eax, %esi	# tmp137,
	movl	$.LC19, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:116:     filter_t filter = {};
	leaq	-432(%rbp), %rax	#, tmp138
	movl	$406, %edx	#, tmp139
	movl	$0, %esi	#,
	movq	%rax, %rdi	# tmp138,
	call	memset	#
# src/tests.c:117:     if (!load_coefficients_fixed("tools/filter_coefficients/biquad_coeffs.txt",
	leaq	-432(%rbp), %rax	#, tmp142
	movq	%rax, %rdx	# tmp142,
	movl	$1, %esi	#,
	movl	$.LC20, %edi	#,
	call	load_coefficients_fixed	#
# src/tests.c:117:     if (!load_coefficients_fixed("tools/filter_coefficients/biquad_coeffs.txt",
	testl	%eax, %eax	# _1
	jne	.L30	#,
# src/tests.c:120:         printf("error");
	movl	$.LC21, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
.L30:
# src/tests.c:122:     printf("input data sf: %d\n", input_data->scale_factor_exp);
	movq	-1201296(%rbp), %rax	# input_data, tmp143
	movzbl	600000(%rax), %eax	# input_data_42(D)->scale_factor_exp, _2
# src/tests.c:122:     printf("input data sf: %d\n", input_data->scale_factor_exp);
	movsbl	%al, %eax	# _2, _3
	movl	%eax, %esi	# _3,
	movl	$.LC22, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:124:            filter.den_scale_factor_exp);
	movzbl	-27(%rbp), %eax	# filter.den_scale_factor_exp, _4
# src/tests.c:123:     printf("biquad sf: num %d den %d\n", filter.num_scale_factor_exp,
	movzbl	%al, %edx	# _4, _5
# src/tests.c:123:     printf("biquad sf: num %d den %d\n", filter.num_scale_factor_exp,
	movzbl	-28(%rbp), %eax	# filter.num_scale_factor_exp, _6
# src/tests.c:123:     printf("biquad sf: num %d den %d\n", filter.num_scale_factor_exp,
	movzbl	%al, %eax	# _6, _7
	movl	%eax, %esi	# _7,
	movl	$.LC23, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:125:     input_data_t filter1_output = {};
	leaq	-600448(%rbp), %rax	#, tmp144
	movl	$600002, %edx	#, tmp145
	movl	$0, %esi	#,
	movq	%rax, %rdi	# tmp144,
	call	memset	#
# src/tests.c:126:     filter1_output.scale_factor_exp = input_data->scale_factor_exp;
	movq	-1201296(%rbp), %rax	# input_data, tmp148
	movzbl	600000(%rax), %eax	# input_data_42(D)->scale_factor_exp, _8
# src/tests.c:126:     filter1_output.scale_factor_exp = input_data->scale_factor_exp;
	movb	%al, -448(%rbp)	# _8, filter1_output.scale_factor_exp
# src/tests.c:127:     int16_t filter_output[MAX_SAMPLES] = {};
	leaq	-1200448(%rbp), %rax	#, tmp149
	movl	$600000, %edx	#, tmp150
	movl	$0, %esi	#,
	movq	%rax, %rdi	# tmp149,
	call	memset	#
# src/tests.c:128:     filter_t filter1 = {.x_coeffs = 3,
	leaq	-1200864(%rbp), %rax	#, tmp153
	movl	$406, %edx	#, tmp154
	movl	$0, %esi	#,
	movq	%rax, %rdi	# tmp153,
	call	memset	#
	movw	$3, -1200464(%rbp)	#, filter1.x_coeffs
	movw	$3, -1200462(%rbp)	#, filter1.y_coeffs
# src/tests.c:130:                         .num_scale_factor_exp = filter.num_scale_factor_exp,
	movzbl	-28(%rbp), %eax	# filter.num_scale_factor_exp, _9
# src/tests.c:128:     filter_t filter1 = {.x_coeffs = 3,
	movb	%al, -1200460(%rbp)	# _9, filter1.num_scale_factor_exp
# src/tests.c:131:                         .den_scale_factor_exp = filter.den_scale_factor_exp};
	movzbl	-27(%rbp), %eax	# filter.den_scale_factor_exp, _10
# src/tests.c:128:     filter_t filter1 = {.x_coeffs = 3,
	movb	%al, -1200459(%rbp)	# _10, filter1.den_scale_factor_exp
# src/tests.c:132:     filter_t filter2 = {.x_coeffs = 3,
	leaq	-1201280(%rbp), %rax	#, tmp157
	movl	$406, %edx	#, tmp158
	movl	$0, %esi	#,
	movq	%rax, %rdi	# tmp157,
	call	memset	#
	movw	$3, -1200880(%rbp)	#, filter2.x_coeffs
	movw	$3, -1200878(%rbp)	#, filter2.y_coeffs
# src/tests.c:134:                         .num_scale_factor_exp = filter.num_scale_factor_exp,
	movzbl	-28(%rbp), %eax	# filter.num_scale_factor_exp, _11
# src/tests.c:132:     filter_t filter2 = {.x_coeffs = 3,
	movb	%al, -1200876(%rbp)	# _11, filter2.num_scale_factor_exp
# src/tests.c:135:                         .den_scale_factor_exp = filter.den_scale_factor_exp};
	movzbl	-27(%rbp), %eax	# filter.den_scale_factor_exp, _12
# src/tests.c:132:     filter_t filter2 = {.x_coeffs = 3,
	movb	%al, -1200875(%rbp)	# _12, filter2.den_scale_factor_exp
# src/tests.c:136:     memcpy(filter1.x, filter.x, 3 * sizeof(int16_t));
	leaq	-432(%rbp), %rcx	#, tmp161
	leaq	-1200864(%rbp), %rax	#, tmp162
	movl	$6, %edx	#,
	movq	%rcx, %rsi	# tmp161,
	movq	%rax, %rdi	# tmp162,
	call	memcpy	#
# src/tests.c:137:     memcpy(filter1.y, filter.y, 3 * sizeof(int16_t));
	leaq	-432(%rbp), %rax	#, tmp163
	leaq	200(%rax), %rcx	#, tmp164
	leaq	-1200864(%rbp), %rax	#, tmp165
	addq	$200, %rax	#, tmp166
	movl	$6, %edx	#,
	movq	%rcx, %rsi	# tmp164,
	movq	%rax, %rdi	# tmp166,
	call	memcpy	#
# src/tests.c:138:     memcpy(filter2.x, &filter.x[3], 3 * sizeof(int16_t));
	leaq	-432(%rbp), %rax	#, tmp167
	leaq	6(%rax), %rcx	#, tmp168
	leaq	-1201280(%rbp), %rax	#, tmp169
	movl	$6, %edx	#,
	movq	%rcx, %rsi	# tmp168,
	movq	%rax, %rdi	# tmp169,
	call	memcpy	#
# src/tests.c:139:     memcpy(filter2.y, &filter.y[3], 3 * sizeof(int16_t));
	leaq	-432(%rbp), %rax	#, tmp170
	leaq	206(%rax), %rcx	#, tmp171
	leaq	-1201280(%rbp), %rax	#, tmp172
	addq	$200, %rax	#, tmp173
	movl	$6, %edx	#,
	movq	%rcx, %rsi	# tmp171,
	movq	%rax, %rdi	# tmp173,
	call	memcpy	#
# src/tests.c:140:     printf("b coefficients:\n");
	movl	$.LC24, %edi	#,
	call	puts	#
# src/tests.c:141:     printf("b0: %d\n", filter1.x[0]);
	movzwl	-1200864(%rbp), %eax	# filter1.x[0], _13
# src/tests.c:141:     printf("b0: %d\n", filter1.x[0]);
	cwtl
	movl	%eax, %esi	# _14,
	movl	$.LC25, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:142:     printf("b1: %d\n", filter1.x[1]);
	movzwl	-1200862(%rbp), %eax	# filter1.x[1], _15
# src/tests.c:142:     printf("b1: %d\n", filter1.x[1]);
	cwtl
	movl	%eax, %esi	# _16,
	movl	$.LC26, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:143:     printf("b2: %d\n", filter1.x[2]);
	movzwl	-1200860(%rbp), %eax	# filter1.x[2], _17
# src/tests.c:143:     printf("b2: %d\n", filter1.x[2]);
	cwtl
	movl	%eax, %esi	# _18,
	movl	$.LC27, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:145:     printf("a coefficients:\n");
	movl	$.LC28, %edi	#,
	call	puts	#
# src/tests.c:146:     printf("a1: %d\n", filter1.y[0]);
	movzwl	-1200664(%rbp), %eax	# filter1.y[0], _19
# src/tests.c:146:     printf("a1: %d\n", filter1.y[0]);
	cwtl
	movl	%eax, %esi	# _20,
	movl	$.LC29, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:147:     printf("a2: %d\n", filter1.y[1]);
	movzwl	-1200662(%rbp), %eax	# filter1.y[1], _21
# src/tests.c:147:     printf("a2: %d\n", filter1.y[1]);
	cwtl
	movl	%eax, %esi	# _22,
	movl	$.LC30, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:149:     printf("b coefficients:\n");
	movl	$.LC24, %edi	#,
	call	puts	#
# src/tests.c:150:     printf("b0: %d\n", filter2.x[0]);
	movzwl	-1201280(%rbp), %eax	# filter2.x[0], _23
# src/tests.c:150:     printf("b0: %d\n", filter2.x[0]);
	cwtl
	movl	%eax, %esi	# _24,
	movl	$.LC25, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:151:     printf("b1: %d\n", filter2.x[1]);
	movzwl	-1201278(%rbp), %eax	# filter2.x[1], _25
# src/tests.c:151:     printf("b1: %d\n", filter2.x[1]);
	cwtl
	movl	%eax, %esi	# _26,
	movl	$.LC26, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:152:     printf("b2: %d\n", filter2.x[2]);
	movzwl	-1201276(%rbp), %eax	# filter2.x[2], _27
# src/tests.c:152:     printf("b2: %d\n", filter2.x[2]);
	cwtl
	movl	%eax, %esi	# _28,
	movl	$.LC27, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:154:     printf("a coefficients:\n");
	movl	$.LC28, %edi	#,
	call	puts	#
# src/tests.c:155:     printf("a1: %d\n", filter2.y[0]);
	movzwl	-1201080(%rbp), %eax	# filter2.y[0], _29
# src/tests.c:155:     printf("a1: %d\n", filter2.y[0]);
	cwtl
	movl	%eax, %esi	# _30,
	movl	$.LC29, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:156:     printf("a2: %d\n", filter2.y[1]);
	movzwl	-1201078(%rbp), %eax	# filter2.y[1], _31
# src/tests.c:156:     printf("a2: %d\n", filter2.y[1]);
	cwtl
	movl	%eax, %esi	# _32,
	movl	$.LC30, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:158:     profiler_start();
	call	profiler_start	#
# src/tests.c:159:     iir_filter_fixed_point(input_data, filter1_output.input_data_buffer,
	movl	-8(%rbp), %edx	# data_samples, data_samples.2_33
	leaq	-1200864(%rbp), %rcx	#, tmp174
	leaq	-600448(%rbp), %rsi	#, tmp175
	movq	-1201296(%rbp), %rax	# input_data, tmp176
	movq	%rax, %rdi	# tmp176,
	call	iir_filter_fixed_point	#
# src/tests.c:161:     iir_filter_fixed_point(&filter1_output, filter_output, data_samples,
	movl	-8(%rbp), %edx	# data_samples, data_samples.3_34
	leaq	-1201280(%rbp), %rcx	#, tmp177
	leaq	-1200448(%rbp), %rsi	#, tmp178
	leaq	-600448(%rbp), %rax	#, tmp179
	movq	%rax, %rdi	# tmp179,
	call	iir_filter_fixed_point	#
# src/tests.c:163:     profiler_stop();
	call	profiler_stop	#
# src/tests.c:165:     printf("time elapsed in ticks: %d\n", profiler_get_elapsed_time());
	call	profiler_get_elapsed_time	#
# src/tests.c:165:     printf("time elapsed in ticks: %d\n", profiler_get_elapsed_time());
	movl	%eax, %esi	# _35,
	movl	$.LC12, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:167:     FILE *file = fopen(outputfile, "w");
	movq	-1201288(%rbp), %rax	# outputfile, tmp180
	movl	$.LC2, %esi	#,
	movq	%rax, %rdi	# tmp180,
	call	fopen	#
	movq	%rax, -16(%rbp)	# tmp181, file
# src/tests.c:169:     for (int i = 0; i < data_samples; i++)
	movl	$0, -4(%rbp)	#, i
# src/tests.c:169:     for (int i = 0; i < data_samples; i++)
	jmp	.L31	#
.L32:
# src/tests.c:171:         fprintf(file, "%d\n", (int)filter_output[i]);
	movl	-4(%rbp), %eax	# i, tmp183
	cltq
	movzwl	-1200448(%rbp,%rax,2), %eax	# filter_output[i_38], _36
# src/tests.c:171:         fprintf(file, "%d\n", (int)filter_output[i]);
	movswl	%ax, %edx	# _36, _37
	movq	-16(%rbp), %rax	# file, tmp184
	movl	$.LC18, %esi	#,
	movq	%rax, %rdi	# tmp184,
	movl	$0, %eax	#,
	call	fprintf	#
# src/tests.c:169:     for (int i = 0; i < data_samples; i++)
	addl	$1, -4(%rbp)	#, i
.L31:
# src/tests.c:169:     for (int i = 0; i < data_samples; i++)
	movl	-4(%rbp), %eax	# i, tmp185
	cmpl	-8(%rbp), %eax	# data_samples, tmp185
	jl	.L32	#,
# src/tests.c:174:     fclose(file);
	movq	-16(%rbp), %rax	# file, tmp186
	movq	%rax, %rdi	# tmp186,
	call	fclose	#
# src/tests.c:175: }
	nop	
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE4:
	.size	test_iir_biquad_fixed, .-test_iir_biquad_fixed
	.section	.rodata
	.align 8
.LC31:
	.string	"tools/test_data/data_normalized.csv"
	.align 8
.LC32:
	.string	"tools/filter_coefficients/FIR_filter_coeffs.txt"
	.align 8
.LC33:
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
# src/tests.c:180:     int data_samples = load_accelerometer_data_fixed(
	movq	-600048(%rbp), %rax	# input_data, tmp114
	movl	$300000, %edx	#,
	movq	%rax, %rsi	# tmp114,
	movl	$.LC31, %edi	#,
	call	load_accelerometer_data_fixed	#
	movl	%eax, -12(%rbp)	# tmp115, data_samples
# src/tests.c:183:     load_coefficients_fixed("tools/filter_coefficients/FIR_filter_coeffs.txt",
	movq	-600056(%rbp), %rax	# filter, tmp116
	movq	%rax, %rdx	# tmp116,
	movl	$0, %esi	#,
	movl	$.LC32, %edi	#,
	call	load_coefficients_fixed	#
# src/tests.c:187:            filter->num_scale_factor_exp);
	movq	-600056(%rbp), %rax	# filter, tmp117
	movzbl	404(%rax), %eax	# filter_25(D)->num_scale_factor_exp, _1
# src/tests.c:186:     printf("input data sf: %d, filter sf: %d\n", input_data->scale_factor_exp,
	movzbl	%al, %edx	# _1, _2
# src/tests.c:186:     printf("input data sf: %d, filter sf: %d\n", input_data->scale_factor_exp,
	movq	-600048(%rbp), %rax	# input_data, tmp118
	movzbl	600000(%rax), %eax	# input_data_22(D)->scale_factor_exp, _3
# src/tests.c:186:     printf("input data sf: %d, filter sf: %d\n", input_data->scale_factor_exp,
	movsbl	%al, %eax	# _3, _4
	movl	%eax, %esi	# _4,
	movl	$.LC33, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:189:     for (int i = 0; i < filter->x_coeffs; i++)
	movl	$0, -4(%rbp)	#, i
# src/tests.c:189:     for (int i = 0; i < filter->x_coeffs; i++)
	jmp	.L34	#
.L35:
# src/tests.c:191:         printf("filter x: %d\n", filter->x[i]);
	movq	-600056(%rbp), %rax	# filter, tmp119
	movl	-4(%rbp), %edx	# i, tmp121
	movslq	%edx, %rdx	# tmp121, tmp120
	movzwl	(%rax,%rdx,2), %eax	# filter_25(D)->x[i_17], _5
# src/tests.c:191:         printf("filter x: %d\n", filter->x[i]);
	cwtl
	movl	%eax, %esi	# _6,
	movl	$.LC16, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/tests.c:189:     for (int i = 0; i < filter->x_coeffs; i++)
	addl	$1, -4(%rbp)	#, i
.L34:
# src/tests.c:189:     for (int i = 0; i < filter->x_coeffs; i++)
	movq	-600056(%rbp), %rax	# filter, tmp122
	movzwl	400(%rax), %eax	# filter_25(D)->x_coeffs, _7
	movzwl	%ax, %eax	# _7, _8
# src/tests.c:189:     for (int i = 0; i < filter->x_coeffs; i++)
	cmpl	%eax, -4(%rbp)	# _8, i
	jl	.L35	#,
# src/tests.c:194:     int16_t filter_output[MAX_SAMPLES] = {};
	leaq	-600032(%rbp), %rax	#, tmp123
	movl	$600000, %edx	#, tmp124
	movl	$0, %esi	#,
	movq	%rax, %rdi	# tmp123,
	call	memset	#
# src/tests.c:197:                filter->num_scale_factor_exp, filter->x_coeffs);
	movq	-600056(%rbp), %rax	# filter, tmp127
	movzwl	400(%rax), %eax	# filter_25(D)->x_coeffs, _9
# src/tests.c:196:     fir_filter(input_data, filter_output, data_samples, filter->x,
	movzwl	%ax, %r8d	# _9, _10
# src/tests.c:197:                filter->num_scale_factor_exp, filter->x_coeffs);
	movq	-600056(%rbp), %rax	# filter, tmp128
	movzbl	404(%rax), %eax	# filter_25(D)->num_scale_factor_exp, _11
# src/tests.c:196:     fir_filter(input_data, filter_output, data_samples, filter->x,
	movzbl	%al, %eax	# _11, _12
# src/tests.c:196:     fir_filter(input_data, filter_output, data_samples, filter->x,
	movq	-600056(%rbp), %rcx	# filter, _13
# src/tests.c:196:     fir_filter(input_data, filter_output, data_samples, filter->x,
	movl	-12(%rbp), %edx	# data_samples, data_samples.4_14
	movswl	%ax, %edi	# _12, tmp129
	leaq	-600032(%rbp), %rsi	#, tmp130
	movq	-600048(%rbp), %rax	# input_data, tmp131
	movl	%r8d, %r9d	# _10,
	movl	%edi, %r8d	# tmp129,
	movq	%rax, %rdi	# tmp131,
	call	fir_filter	#
# src/tests.c:199:     FILE *file = fopen(outputfile, "w");
	movq	-600040(%rbp), %rax	# outputfile, tmp132
	movl	$.LC2, %esi	#,
	movq	%rax, %rdi	# tmp132,
	call	fopen	#
	movq	%rax, -24(%rbp)	# tmp133, file
# src/tests.c:201:     for (int i = 0; i < data_samples; i++)
	movl	$0, -8(%rbp)	#, i
# src/tests.c:201:     for (int i = 0; i < data_samples; i++)
	jmp	.L36	#
.L37:
# src/tests.c:203:         fprintf(file, "%d\n", filter_output[i]);
	movl	-8(%rbp), %eax	# i, tmp135
	cltq
	movzwl	-600032(%rbp,%rax,2), %eax	# filter_output[i_18], _15
# src/tests.c:203:         fprintf(file, "%d\n", filter_output[i]);
	movswl	%ax, %edx	# _15, _16
	movq	-24(%rbp), %rax	# file, tmp136
	movl	$.LC18, %esi	#,
	movq	%rax, %rdi	# tmp136,
	movl	$0, %eax	#,
	call	fprintf	#
# src/tests.c:201:     for (int i = 0; i < data_samples; i++)
	addl	$1, -8(%rbp)	#, i
.L36:
# src/tests.c:201:     for (int i = 0; i < data_samples; i++)
	movl	-8(%rbp), %eax	# i, tmp137
	cmpl	-12(%rbp), %eax	# data_samples, tmp137
	jl	.L37	#,
# src/tests.c:205:     fclose(file);
	movq	-24(%rbp), %rax	# file, tmp138
	movq	%rax, %rdi	# tmp138,
	call	fclose	#
# src/tests.c:206: }
	nop	
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE5:
	.size	test_fir_filter, .-test_fir_filter
	.ident	"GCC: (GNU) 16.1.1 20260515 (Red Hat 16.1.1-2)"
	.section	.note.GNU-stack,"",@progbits
