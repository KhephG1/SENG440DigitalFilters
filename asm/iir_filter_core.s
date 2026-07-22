	.file	"iir_filter_core.c"
# GNU C23 (GCC) version 16.1.1 20260515 (Red Hat 16.1.1-2) (x86_64-redhat-linux)
#	compiled by GNU C version 16.1.1 20260515 (Red Hat 16.1.1-2), GMP version 6.3.0, MPFR version 4.2.2, MPC version 1.4.1, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mtune=generic -march=x86-64 -mtls-dialect=gnu2
	.text
	.section	.rodata
.LC0:
	.string	"%d\n"
	.text
	.globl	iir_filter_biquad
	.type	iir_filter_biquad, @function
iir_filter_biquad:
.LFB0:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$80, %rsp	#,
	movq	%rdi, -56(%rbp)	# input, input
	movq	%rsi, -64(%rbp)	# output, output
	movl	%edx, -68(%rbp)	# input_length, input_length
	movq	%rcx, -80(%rbp)	# biquad, biquad
# src/iir_filter_core.c:10:     const int32_t temp_sf = input->scale_factor_exp;
	movq	-56(%rbp), %rax	# input, tmp141
	movzbl	600000(%rax), %eax	# input_51(D)->scale_factor_exp, _1
# src/iir_filter_core.c:10:     const int32_t temp_sf = input->scale_factor_exp;
	movsbl	%al, %eax	# _1, tmp142
	movl	%eax, -20(%rbp)	# tmp142, temp_sf
# src/iir_filter_core.c:11:     const int32_t sf_diff = biquad->num_sf - biquad->den_sf;
	movq	-80(%rbp), %rax	# biquad, tmp143
	movzbl	10(%rax), %eax	# biquad_53(D)->num_sf, _2
	movzbl	%al, %edx	# _2, _3
# src/iir_filter_core.c:11:     const int32_t sf_diff = biquad->num_sf - biquad->den_sf;
	movq	-80(%rbp), %rax	# biquad, tmp144
	movzbl	11(%rax), %eax	# biquad_53(D)->den_sf, _4
	movzbl	%al, %eax	# _4, _5
# src/iir_filter_core.c:11:     const int32_t sf_diff = biquad->num_sf - biquad->den_sf;
	subl	%eax, %edx	# _5, tmp145
	movl	%edx, -24(%rbp)	# tmp145, sf_diff
# src/iir_filter_core.c:12:     int32_t t1 = 0, t2 = 0, t3 = 0, d1 = 0, d2 = 0;
	movl	$0, -28(%rbp)	#, t1
# src/iir_filter_core.c:12:     int32_t t1 = 0, t2 = 0, t3 = 0, d1 = 0, d2 = 0;
	movl	$0, -4(%rbp)	#, t2
# src/iir_filter_core.c:12:     int32_t t1 = 0, t2 = 0, t3 = 0, d1 = 0, d2 = 0;
	movl	$0, -32(%rbp)	#, t3
# src/iir_filter_core.c:12:     int32_t t1 = 0, t2 = 0, t3 = 0, d1 = 0, d2 = 0;
	movl	$0, -8(%rbp)	#, d1
# src/iir_filter_core.c:12:     int32_t t1 = 0, t2 = 0, t3 = 0, d1 = 0, d2 = 0;
	movl	$0, -12(%rbp)	#, d2
# src/iir_filter_core.c:14:     for (int i = 0; i < (int)input_length; i++)
	movl	$0, -16(%rbp)	#, i
# src/iir_filter_core.c:14:     for (int i = 0; i < (int)input_length; i++)
	jmp	.L2	#
.L7:
# src/iir_filter_core.c:16:         int32_t x = input->input_data_buffer[i];
	movq	-56(%rbp), %rax	# input, tmp146
	movl	-16(%rbp), %edx	# i, tmp148
	movslq	%edx, %rdx	# tmp148, tmp147
	movzwl	(%rax,%rdx,2), %eax	# input_51(D)->input_data_buffer[i_48], _6
# src/iir_filter_core.c:16:         int32_t x = input->input_data_buffer[i];
	cwtl
	movl	%eax, -36(%rbp)	# tmp149, x
# src/iir_filter_core.c:18:         t1 = x * biquad->b0;
	movq	-80(%rbp), %rax	# biquad, tmp150
	movzwl	(%rax), %eax	# biquad_53(D)->b0, _7
	cwtl
# src/iir_filter_core.c:18:         t1 = x * biquad->b0;
	movl	-36(%rbp), %edx	# x, tmp152
	imull	%edx, %eax	# tmp152, t1_63
	movl	%eax, -28(%rbp)	# t1_63, t1
# src/iir_filter_core.c:19:         t3 = t1 + d1;
	movl	-28(%rbp), %edx	# t1, tmp157
	movl	-8(%rbp), %eax	# d1, tmp158
	addl	%edx, %eax	# tmp157, t3_64
	movl	%eax, -32(%rbp)	# t3_64, t3
# src/iir_filter_core.c:21:         output[i] = (int16_t)((t3 + (1 << (temp_sf - 1))) >> temp_sf);
	movl	-20(%rbp), %eax	# temp_sf, tmp159
	subl	$1, %eax	#, _9
# src/iir_filter_core.c:21:         output[i] = (int16_t)((t3 + (1 << (temp_sf - 1))) >> temp_sf);
	movl	$1, %edx	#, tmp160
	movl	%eax, %ecx	# _9, tmp195
	sall	%cl, %edx	# tmp195, _10
# src/iir_filter_core.c:21:         output[i] = (int16_t)((t3 + (1 << (temp_sf - 1))) >> temp_sf);
	movl	-32(%rbp), %eax	# t3, tmp161
	addl	%eax, %edx	# tmp161, _11
# src/iir_filter_core.c:21:         output[i] = (int16_t)((t3 + (1 << (temp_sf - 1))) >> temp_sf);
	movl	-20(%rbp), %eax	# temp_sf, tmp162
	movl	%eax, %ecx	# tmp162, tmp197
	sarl	%cl, %edx	# tmp197, _11
	movl	%edx, %ecx	# _11, _12
# src/iir_filter_core.c:21:         output[i] = (int16_t)((t3 + (1 << (temp_sf - 1))) >> temp_sf);
	movl	-16(%rbp), %eax	# i, tmp163
	cltq
	leaq	(%rax,%rax), %rdx	#, _14
	movq	-64(%rbp), %rax	# output, tmp164
	addq	%rdx, %rax	# _14, _15
# src/iir_filter_core.c:21:         output[i] = (int16_t)((t3 + (1 << (temp_sf - 1))) >> temp_sf);
	movl	%ecx, %edx	# _12, _16
# src/iir_filter_core.c:21:         output[i] = (int16_t)((t3 + (1 << (temp_sf - 1))) >> temp_sf);
	movw	%dx, (%rax)	# _16, *_15
# src/iir_filter_core.c:22:         printf("%d\n", output[i]);
	movl	-16(%rbp), %eax	# i, tmp165
	cltq
	leaq	(%rax,%rax), %rdx	#, _18
	movq	-64(%rbp), %rax	# output, tmp166
	addq	%rdx, %rax	# _18, _19
	movzwl	(%rax), %eax	# *_19, _20
# src/iir_filter_core.c:22:         printf("%d\n", output[i]);
	cwtl
	movl	%eax, %esi	# _21,
	movl	$.LC0, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/iir_filter_core.c:23:         t1 = x * biquad->b1;
	movq	-80(%rbp), %rax	# biquad, tmp167
	movzwl	2(%rax), %eax	# biquad_53(D)->b1, _22
	cwtl
# src/iir_filter_core.c:23:         t1 = x * biquad->b1;
	movl	-36(%rbp), %edx	# x, tmp169
	imull	%edx, %eax	# tmp169, t1_68
	movl	%eax, -28(%rbp)	# t1_68, t1
# src/iir_filter_core.c:24:         t2 = output[i] * biquad->a1;
	movl	-16(%rbp), %eax	# i, tmp170
	cltq
	leaq	(%rax,%rax), %rdx	#, _25
	movq	-64(%rbp), %rax	# output, tmp171
	addq	%rdx, %rax	# _25, _26
	movzwl	(%rax), %eax	# *_26, _27
	movswl	%ax, %edx	# _27, _28
# src/iir_filter_core.c:24:         t2 = output[i] * biquad->a1;
	movq	-80(%rbp), %rax	# biquad, tmp172
	movzwl	6(%rax), %eax	# biquad_53(D)->a1, _29
	cwtl
# src/iir_filter_core.c:24:         t2 = output[i] * biquad->a1;
	imull	%edx, %eax	# _28, t2_69
	movl	%eax, -4(%rbp)	# t2_69, t2
# src/iir_filter_core.c:26:         if (sf_diff > 0)
	cmpl	$0, -24(%rbp)	#, sf_diff
	jle	.L3	#,
# src/iir_filter_core.c:27:             t2 <<= sf_diff;
	movl	-24(%rbp), %eax	# sf_diff, tmp174
	movl	%eax, %ecx	# tmp174, tmp198
	sall	%cl, -4(%rbp)	# tmp198, t2
	jmp	.L4	#
.L3:
# src/iir_filter_core.c:29:             t2 >>= -sf_diff;
	movl	-24(%rbp), %eax	# sf_diff, tmp175
	negl	%eax	# _31
# src/iir_filter_core.c:29:             t2 >>= -sf_diff;
	movl	%eax, %ecx	# _31, tmp199
	sarl	%cl, -4(%rbp)	# tmp199, t2
.L4:
# src/iir_filter_core.c:31:         d1 = t1 - t2 + d2;
	movl	-28(%rbp), %eax	# t1, tmp176
	subl	-4(%rbp), %eax	# t2, tmp176
	movl	%eax, %edx	# tmp176, _32
# src/iir_filter_core.c:31:         d1 = t1 - t2 + d2;
	movl	-12(%rbp), %eax	# d2, tmp180
	addl	%edx, %eax	# _32, d1_72
	movl	%eax, -8(%rbp)	# d1_72, d1
# src/iir_filter_core.c:33:         t1 = x * biquad->b2;
	movq	-80(%rbp), %rax	# biquad, tmp181
	movzwl	4(%rax), %eax	# biquad_53(D)->b2, _33
	cwtl
# src/iir_filter_core.c:33:         t1 = x * biquad->b2;
	movl	-36(%rbp), %edx	# x, tmp183
	imull	%edx, %eax	# tmp183, t1_73
	movl	%eax, -28(%rbp)	# t1_73, t1
# src/iir_filter_core.c:34:         t2 = output[i] * biquad->a2;
	movl	-16(%rbp), %eax	# i, tmp184
	cltq
	leaq	(%rax,%rax), %rdx	#, _36
	movq	-64(%rbp), %rax	# output, tmp185
	addq	%rdx, %rax	# _36, _37
	movzwl	(%rax), %eax	# *_37, _38
	movswl	%ax, %edx	# _38, _39
# src/iir_filter_core.c:34:         t2 = output[i] * biquad->a2;
	movq	-80(%rbp), %rax	# biquad, tmp186
	movzwl	8(%rax), %eax	# biquad_53(D)->a2, _40
	cwtl
# src/iir_filter_core.c:34:         t2 = output[i] * biquad->a2;
	imull	%edx, %eax	# _39, t2_74
	movl	%eax, -4(%rbp)	# t2_74, t2
# src/iir_filter_core.c:36:         if (sf_diff > 0)
	cmpl	$0, -24(%rbp)	#, sf_diff
	jle	.L5	#,
# src/iir_filter_core.c:37:             t2 <<= sf_diff;
	movl	-24(%rbp), %eax	# sf_diff, tmp188
	movl	%eax, %ecx	# tmp188, tmp201
	sall	%cl, -4(%rbp)	# tmp201, t2
	jmp	.L6	#
.L5:
# src/iir_filter_core.c:39:             t2 >>= -sf_diff;
	movl	-24(%rbp), %eax	# sf_diff, tmp189
	negl	%eax	# _42
# src/iir_filter_core.c:39:             t2 >>= -sf_diff;
	movl	%eax, %ecx	# _42, tmp202
	sarl	%cl, -4(%rbp)	# tmp202, t2
.L6:
# src/iir_filter_core.c:41:         d2 = t1 - t2;
	movl	-28(%rbp), %eax	# t1, tmp193
	subl	-4(%rbp), %eax	# t2, d2_77
	movl	%eax, -12(%rbp)	# d2_77, d2
# src/iir_filter_core.c:14:     for (int i = 0; i < (int)input_length; i++)
	addl	$1, -16(%rbp)	#, i
.L2:
# src/iir_filter_core.c:14:     for (int i = 0; i < (int)input_length; i++)
	movl	-68(%rbp), %eax	# input_length, input_length.0_43
# src/iir_filter_core.c:14:     for (int i = 0; i < (int)input_length; i++)
	cmpl	%eax, -16(%rbp)	# input_length.0_43, i
	jl	.L7	#,
# src/iir_filter_core.c:43: }
	nop	
	nop	
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE0:
	.size	iir_filter_biquad, .-iir_filter_biquad
	.globl	iir_filter_fixed_point
	.type	iir_filter_fixed_point, @function
iir_filter_fixed_point:
.LFB1:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	movq	%rdi, -72(%rbp)	# input, input
	movq	%rsi, -80(%rbp)	# output, output
	movl	%edx, -84(%rbp)	# input_length, input_length
	movq	%rcx, -96(%rbp)	# filter, filter
# src/iir_filter_core.c:48:     const int num_sf = filter->num_scale_factor_exp;
	movq	-96(%rbp), %rax	# filter, tmp132
	movzbl	404(%rax), %eax	# filter_44(D)->num_scale_factor_exp, _1
# src/iir_filter_core.c:48:     const int num_sf = filter->num_scale_factor_exp;
	movzbl	%al, %eax	# _1, tmp133
	movl	%eax, -40(%rbp)	# tmp133, num_sf
# src/iir_filter_core.c:49:     const int den_sf = filter->den_scale_factor_exp;
	movq	-96(%rbp), %rax	# filter, tmp134
	movzbl	405(%rax), %eax	# filter_44(D)->den_scale_factor_exp, _2
# src/iir_filter_core.c:49:     const int den_sf = filter->den_scale_factor_exp;
	movzbl	%al, %eax	# _2, tmp135
	movl	%eax, -44(%rbp)	# tmp135, den_sf
# src/iir_filter_core.c:50:     const int acc_sf = (num_sf > den_sf) ? num_sf : den_sf;
	movl	-44(%rbp), %edx	# den_sf, tmp137
	movl	-40(%rbp), %eax	# num_sf, tmp167
	cmpl	%eax, %edx	# tmp167, tmp137
	cmovge	%edx, %eax	# tmp137,, acc_sf_47
	movl	%eax, -48(%rbp)	# acc_sf_47, acc_sf
# src/iir_filter_core.c:53:     for (int i = 0; i < (int)input_length; i++)
	movl	$0, -4(%rbp)	#, i
# src/iir_filter_core.c:53:     for (int i = 0; i < (int)input_length; i++)
	jmp	.L9	#
.L16:
# src/iir_filter_core.c:57:         int64_t num_acc = 0;
	movq	$0, -16(%rbp)	#, num_acc
# src/iir_filter_core.c:58:         for (int j = 0; j < filter->x_coeffs; j++)
	movl	$0, -20(%rbp)	#, j
# src/iir_filter_core.c:58:         for (int j = 0; j < filter->x_coeffs; j++)
	jmp	.L10	#
.L12:
# src/iir_filter_core.c:60:             if (i >= j)
	movl	-4(%rbp), %eax	# i, tmp138
	cmpl	-20(%rbp), %eax	# j, tmp138
	jl	.L11	#,
# src/iir_filter_core.c:63:                     (int64_t)filter->x[j] * input->input_data_buffer[i - j];
	movq	-96(%rbp), %rax	# filter, tmp139
	movl	-20(%rbp), %edx	# j, tmp141
	movslq	%edx, %rdx	# tmp141, tmp140
	movzwl	(%rax,%rdx,2), %eax	# filter_44(D)->x[j_38], _3
# src/iir_filter_core.c:63:                     (int64_t)filter->x[j] * input->input_data_buffer[i - j];
	movswq	%ax, %rdx	# _3, _4
# src/iir_filter_core.c:63:                     (int64_t)filter->x[j] * input->input_data_buffer[i - j];
	movl	-4(%rbp), %eax	# i, tmp142
	subl	-20(%rbp), %eax	# j, tmp142
	movl	%eax, %ecx	# tmp142, _5
# src/iir_filter_core.c:63:                     (int64_t)filter->x[j] * input->input_data_buffer[i - j];
	movq	-72(%rbp), %rax	# input, tmp143
	movslq	%ecx, %rcx	# _5, tmp144
	movzwl	(%rax,%rcx,2), %eax	# input_61(D)->input_data_buffer[_5], _6
	movswq	%ax, %rax	# _6, _7
# src/iir_filter_core.c:63:                     (int64_t)filter->x[j] * input->input_data_buffer[i - j];
	imulq	%rdx, %rax	# _4, _8
# src/iir_filter_core.c:62:                 num_acc +=
	addq	%rax, -16(%rbp)	# _8, num_acc
.L11:
# src/iir_filter_core.c:58:         for (int j = 0; j < filter->x_coeffs; j++)
	addl	$1, -20(%rbp)	#, j
.L10:
# src/iir_filter_core.c:58:         for (int j = 0; j < filter->x_coeffs; j++)
	movq	-96(%rbp), %rax	# filter, tmp145
	movzwl	400(%rax), %eax	# filter_44(D)->x_coeffs, _9
	movzwl	%ax, %eax	# _9, _10
# src/iir_filter_core.c:58:         for (int j = 0; j < filter->x_coeffs; j++)
	cmpl	%eax, -20(%rbp)	# _10, j
	jl	.L12	#,
# src/iir_filter_core.c:68:         int64_t den_acc = 0;
	movq	$0, -32(%rbp)	#, den_acc
# src/iir_filter_core.c:69:         for (int j = 1; j < filter->y_coeffs; j++)
	movl	$1, -36(%rbp)	#, j
# src/iir_filter_core.c:69:         for (int j = 1; j < filter->y_coeffs; j++)
	jmp	.L13	#
.L15:
# src/iir_filter_core.c:71:             if (i >= j)
	movl	-4(%rbp), %eax	# i, tmp146
	cmpl	-36(%rbp), %eax	# j, tmp146
	jl	.L14	#,
# src/iir_filter_core.c:73:                 den_acc += (int64_t)filter->y[j] * output[i - j];
	movq	-96(%rbp), %rax	# filter, tmp147
	movl	-36(%rbp), %edx	# j, tmp149
	movslq	%edx, %rdx	# tmp149, tmp148
	addq	$96, %rdx	#, tmp150
	movzwl	8(%rax,%rdx,2), %eax	# filter_44(D)->y[j_41], _11
# src/iir_filter_core.c:73:                 den_acc += (int64_t)filter->y[j] * output[i - j];
	movswq	%ax, %rdx	# _11, _12
# src/iir_filter_core.c:73:                 den_acc += (int64_t)filter->y[j] * output[i - j];
	movl	-4(%rbp), %eax	# i, tmp151
	subl	-36(%rbp), %eax	# j, _13
	cltq
# src/iir_filter_core.c:73:                 den_acc += (int64_t)filter->y[j] * output[i - j];
	leaq	(%rax,%rax), %rcx	#, _15
	movq	-80(%rbp), %rax	# output, tmp152
	addq	%rcx, %rax	# _15, _16
	movzwl	(%rax), %eax	# *_16, _17
	movswq	%ax, %rax	# _17, _18
# src/iir_filter_core.c:73:                 den_acc += (int64_t)filter->y[j] * output[i - j];
	imulq	%rdx, %rax	# _12, _19
# src/iir_filter_core.c:73:                 den_acc += (int64_t)filter->y[j] * output[i - j];
	addq	%rax, -32(%rbp)	# _19, den_acc
.L14:
# src/iir_filter_core.c:69:         for (int j = 1; j < filter->y_coeffs; j++)
	addl	$1, -36(%rbp)	#, j
.L13:
# src/iir_filter_core.c:69:         for (int j = 1; j < filter->y_coeffs; j++)
	movq	-96(%rbp), %rax	# filter, tmp153
	movzwl	402(%rax), %eax	# filter_44(D)->y_coeffs, _20
	movzwl	%ax, %eax	# _20, _21
# src/iir_filter_core.c:69:         for (int j = 1; j < filter->y_coeffs; j++)
	cmpl	%eax, -36(%rbp)	# _21, j
	jl	.L15	#,
# src/iir_filter_core.c:78:             (num_acc << (acc_sf - num_sf)) - (den_acc << (acc_sf - den_sf));
	movl	-48(%rbp), %eax	# acc_sf, tmp154
	subl	-40(%rbp), %eax	# num_sf, _22
# src/iir_filter_core.c:78:             (num_acc << (acc_sf - num_sf)) - (den_acc << (acc_sf - den_sf));
	movq	-16(%rbp), %rdx	# num_acc, tmp155
	movq	%rdx, %rsi	# tmp155, tmp155
	movl	%eax, %ecx	# _22, tmp171
	salq	%cl, %rsi	# tmp171, tmp155
# src/iir_filter_core.c:78:             (num_acc << (acc_sf - num_sf)) - (den_acc << (acc_sf - den_sf));
	movl	-48(%rbp), %eax	# acc_sf, tmp156
	subl	-44(%rbp), %eax	# den_sf, _24
# src/iir_filter_core.c:78:             (num_acc << (acc_sf - num_sf)) - (den_acc << (acc_sf - den_sf));
	movq	-32(%rbp), %rdx	# den_acc, tmp157
	movl	%eax, %ecx	# _24, tmp172
	salq	%cl, %rdx	# tmp172, _25
# src/iir_filter_core.c:77:         int64_t total =
	movq	%rsi, %rax	# _23, _23
	subq	%rdx, %rax	# _25, _23
	movq	%rax, -56(%rbp)	# tmp158, total
# src/iir_filter_core.c:80:         total = (total + (1 << (acc_sf - 1))) >> acc_sf;
	movl	-48(%rbp), %eax	# acc_sf, tmp159
	subl	$1, %eax	#, _26
# src/iir_filter_core.c:80:         total = (total + (1 << (acc_sf - 1))) >> acc_sf;
	movl	$1, %edx	#, tmp160
	movl	%eax, %ecx	# _26, tmp175
	sall	%cl, %edx	# tmp175, tmp160
	movl	%edx, %eax	# tmp160, _27
	movslq	%eax, %rdx	# _27, _28
# src/iir_filter_core.c:80:         total = (total + (1 << (acc_sf - 1))) >> acc_sf;
	movq	-56(%rbp), %rax	# total, tmp161
	addq	%rax, %rdx	# tmp161, _29
# src/iir_filter_core.c:80:         total = (total + (1 << (acc_sf - 1))) >> acc_sf;
	movl	-48(%rbp), %eax	# acc_sf, tmp162
	movl	%eax, %ecx	# tmp162, tmp177
	sarq	%cl, %rdx	# tmp177, _29
	movq	%rdx, %rax	# _29, tmp163
	movq	%rax, -56(%rbp)	# tmp163, total
# src/iir_filter_core.c:81:         output[i] = total;
	movl	-4(%rbp), %eax	# i, tmp164
	cltq
	leaq	(%rax,%rax), %rdx	#, _31
	movq	-80(%rbp), %rax	# output, tmp165
	addq	%rdx, %rax	# _31, _32
# src/iir_filter_core.c:81:         output[i] = total;
	movq	-56(%rbp), %rdx	# total, tmp166
	movw	%dx, (%rax)	# _33, *_32
# src/iir_filter_core.c:53:     for (int i = 0; i < (int)input_length; i++)
	addl	$1, -4(%rbp)	#, i
.L9:
# src/iir_filter_core.c:53:     for (int i = 0; i < (int)input_length; i++)
	movl	-84(%rbp), %eax	# input_length, input_length.1_34
# src/iir_filter_core.c:53:     for (int i = 0; i < (int)input_length; i++)
	cmpl	%eax, -4(%rbp)	# input_length.1_34, i
	jl	.L16	#,
# src/iir_filter_core.c:83: }
	nop	
	nop	
	popq	%rbp	#
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE1:
	.size	iir_filter_fixed_point, .-iir_filter_fixed_point
	.globl	iir_filter_naive
	.type	iir_filter_naive, @function
iir_filter_naive:
.LFB2:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	movq	%rdi, -40(%rbp)	# input, input
	movq	%rsi, -48(%rbp)	# output, output
	movl	%edx, -52(%rbp)	# input_length, input_length
	movq	%rcx, -64(%rbp)	# filter_x, filter_x
	movq	%r8, -72(%rbp)	# filter_y, filter_y
	movq	%r9, -80(%rbp)	# coeffsx, coeffsx
# src/iir_filter_core.c:90:     for (int i = 0; i < (int)input_length; i++)
	movl	$0, -4(%rbp)	#, i
# src/iir_filter_core.c:90:     for (int i = 0; i < (int)input_length; i++)
	jmp	.L18	#
.L25:
# src/iir_filter_core.c:92:         float num_acc = 0;
	pxor	%xmm0, %xmm0	# tmp125
	movss	%xmm0, -8(%rbp)	# tmp125, num_acc
# src/iir_filter_core.c:93:         for (int j = 0; j < *coeffsx; j++)
	movl	$0, -12(%rbp)	#, j
# src/iir_filter_core.c:93:         for (int j = 0; j < *coeffsx; j++)
	jmp	.L19	#
.L21:
# src/iir_filter_core.c:95:             if (i >= j)
	movl	-4(%rbp), %eax	# i, tmp126
	cmpl	-12(%rbp), %eax	# j, tmp126
	jl	.L20	#,
# src/iir_filter_core.c:97:                 num_acc += filter_x[j] * input[i - j];
	movl	-12(%rbp), %eax	# j, tmp127
	cltq
	leaq	0(,%rax,4), %rdx	#, _2
	movq	-64(%rbp), %rax	# filter_x, tmp128
	addq	%rdx, %rax	# _2, _3
	movss	(%rax), %xmm1	# *_3, _4
# src/iir_filter_core.c:97:                 num_acc += filter_x[j] * input[i - j];
	movl	-4(%rbp), %eax	# i, tmp129
	subl	-12(%rbp), %eax	# j, _5
	cltq
# src/iir_filter_core.c:97:                 num_acc += filter_x[j] * input[i - j];
	leaq	0(,%rax,4), %rdx	#, _7
	movq	-40(%rbp), %rax	# input, tmp130
	addq	%rdx, %rax	# _7, _8
	movss	(%rax), %xmm0	# *_8, _9
# src/iir_filter_core.c:97:                 num_acc += filter_x[j] * input[i - j];
	mulss	%xmm1, %xmm0	# _4, _10
# src/iir_filter_core.c:97:                 num_acc += filter_x[j] * input[i - j];
	movss	-8(%rbp), %xmm1	# num_acc, tmp132
	addss	%xmm1, %xmm0	# tmp132, num_acc_53
	movss	%xmm0, -8(%rbp)	# num_acc_53, num_acc
.L20:
# src/iir_filter_core.c:93:         for (int j = 0; j < *coeffsx; j++)
	addl	$1, -12(%rbp)	#, j
.L19:
# src/iir_filter_core.c:93:         for (int j = 0; j < *coeffsx; j++)
	movq	-80(%rbp), %rax	# coeffsx, tmp133
	movl	(%rax), %eax	# *coeffsx_41(D), _11
# src/iir_filter_core.c:93:         for (int j = 0; j < *coeffsx; j++)
	cmpl	%eax, -12(%rbp)	# _11, j
	jl	.L21	#,
# src/iir_filter_core.c:102:         float den_acc = 0;
	pxor	%xmm0, %xmm0	# tmp134
	movss	%xmm0, -16(%rbp)	# tmp134, den_acc
# src/iir_filter_core.c:103:         for (int j = 1; j < *coeffsy; j++)
	movl	$1, -20(%rbp)	#, j
# src/iir_filter_core.c:103:         for (int j = 1; j < *coeffsy; j++)
	jmp	.L22	#
.L24:
# src/iir_filter_core.c:105:             if (i >= j)
	movl	-4(%rbp), %eax	# i, tmp135
	cmpl	-20(%rbp), %eax	# j, tmp135
	jl	.L23	#,
# src/iir_filter_core.c:107:                 den_acc += filter_y[j] * output[i - j];
	movl	-20(%rbp), %eax	# j, tmp136
	cltq
	leaq	0(,%rax,4), %rdx	#, _13
	movq	-72(%rbp), %rax	# filter_y, tmp137
	addq	%rdx, %rax	# _13, _14
	movss	(%rax), %xmm1	# *_14, _15
# src/iir_filter_core.c:107:                 den_acc += filter_y[j] * output[i - j];
	movl	-4(%rbp), %eax	# i, tmp138
	subl	-20(%rbp), %eax	# j, _16
	cltq
# src/iir_filter_core.c:107:                 den_acc += filter_y[j] * output[i - j];
	leaq	0(,%rax,4), %rdx	#, _18
	movq	-48(%rbp), %rax	# output, tmp139
	addq	%rdx, %rax	# _18, _19
	movss	(%rax), %xmm0	# *_19, _20
# src/iir_filter_core.c:107:                 den_acc += filter_y[j] * output[i - j];
	mulss	%xmm1, %xmm0	# _15, _21
# src/iir_filter_core.c:107:                 den_acc += filter_y[j] * output[i - j];
	movss	-16(%rbp), %xmm1	# den_acc, tmp141
	addss	%xmm1, %xmm0	# tmp141, den_acc_49
	movss	%xmm0, -16(%rbp)	# den_acc_49, den_acc
.L23:
# src/iir_filter_core.c:103:         for (int j = 1; j < *coeffsy; j++)
	addl	$1, -20(%rbp)	#, j
.L22:
# src/iir_filter_core.c:103:         for (int j = 1; j < *coeffsy; j++)
	movq	16(%rbp), %rax	# coeffsy, tmp142
	movl	(%rax), %eax	# *coeffsy_44(D), _22
# src/iir_filter_core.c:103:         for (int j = 1; j < *coeffsy; j++)
	cmpl	%eax, -20(%rbp)	# _22, j
	jl	.L24	#,
# src/iir_filter_core.c:110:         output[i] = num_acc - den_acc;
	movl	-4(%rbp), %eax	# i, tmp143
	cltq
	leaq	0(,%rax,4), %rdx	#, _24
	movq	-48(%rbp), %rax	# output, tmp144
	addq	%rdx, %rax	# _24, _25
# src/iir_filter_core.c:110:         output[i] = num_acc - den_acc;
	movss	-8(%rbp), %xmm0	# num_acc, tmp145
	subss	-16(%rbp), %xmm0	# den_acc, _26
# src/iir_filter_core.c:110:         output[i] = num_acc - den_acc;
	movss	%xmm0, (%rax)	# _26, *_25
# src/iir_filter_core.c:90:     for (int i = 0; i < (int)input_length; i++)
	addl	$1, -4(%rbp)	#, i
.L18:
# src/iir_filter_core.c:90:     for (int i = 0; i < (int)input_length; i++)
	movl	-52(%rbp), %eax	# input_length, input_length.2_27
# src/iir_filter_core.c:90:     for (int i = 0; i < (int)input_length; i++)
	cmpl	%eax, -4(%rbp)	# input_length.2_27, i
	jl	.L25	#,
# src/iir_filter_core.c:112: }
	nop	
	nop	
	popq	%rbp	#
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE2:
	.size	iir_filter_naive, .-iir_filter_naive
	.ident	"GCC: (GNU) 16.1.1 20260515 (Red Hat 16.1.1-2)"
	.section	.note.GNU-stack,"",@progbits
