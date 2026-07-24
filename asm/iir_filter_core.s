	.file	"iir_filter_core.c"
# GNU C23 (GCC) version 16.1.1 20260515 (Red Hat 16.1.1-2) (x86_64-redhat-linux)
#	compiled by GNU C version 16.1.1 20260515 (Red Hat 16.1.1-2), GMP version 6.3.0, MPFR version 4.2.2, MPC version 1.4.1, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mtune=generic -march=x86-64 -mtls-dialect=gnu2
	.text
	.type	saturate_int16, @function
saturate_int16:
.LFB0:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)	# x, x
# src/iir_filter_core.c:9:     if (x > INT16_MAX)
	cmpq	$32767, -8(%rbp)	#, x
	jle	.L2	#,
# src/iir_filter_core.c:11:         return INT16_MAX;
	movl	$32767, %eax	#, _1
	jmp	.L3	#
.L2:
# src/iir_filter_core.c:13:     else if (x < INT16_MIN)
	cmpq	$-32768, -8(%rbp)	#, x
	jge	.L4	#,
# src/iir_filter_core.c:15:         return INT16_MIN;
	movl	$-32768, %eax	#, _1
	jmp	.L3	#
.L4:
# src/iir_filter_core.c:19:         return (int16_t)x;
	movq	-8(%rbp), %rax	# x, tmp100
.L3:
# src/iir_filter_core.c:21: }
	popq	%rbp	#
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE0:
	.size	saturate_int16, .-saturate_int16
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
	pushq	%rbx	#
	subq	$96, %rsp	#,
	.cfi_offset 3, -24
	movq	%rdi, -80(%rbp)	# input, input
	movq	%rsi, -88(%rbp)	# output, output
	movl	%edx, -92(%rbp)	# input_length, input_length
	movq	%rcx, -104(%rbp)	# filter, filter
# src/iir_filter_core.c:26:     const int num_sf = filter->num_scale_factor_exp;
	movq	-104(%rbp), %rax	# filter, tmp132
	movzbl	404(%rax), %eax	# filter_44(D)->num_scale_factor_exp, _1
# src/iir_filter_core.c:26:     const int num_sf = filter->num_scale_factor_exp;
	movzbl	%al, %eax	# _1, tmp133
	movl	%eax, -48(%rbp)	# tmp133, num_sf
# src/iir_filter_core.c:27:     const int den_sf = filter->den_scale_factor_exp;
	movq	-104(%rbp), %rax	# filter, tmp134
	movzbl	405(%rax), %eax	# filter_44(D)->den_scale_factor_exp, _2
# src/iir_filter_core.c:27:     const int den_sf = filter->den_scale_factor_exp;
	movzbl	%al, %eax	# _2, tmp135
	movl	%eax, -52(%rbp)	# tmp135, den_sf
# src/iir_filter_core.c:28:     const int acc_sf = (num_sf > den_sf) ? num_sf : den_sf;
	movl	-52(%rbp), %edx	# den_sf, tmp137
	movl	-48(%rbp), %eax	# num_sf, tmp167
	cmpl	%eax, %edx	# tmp167, tmp137
	cmovge	%edx, %eax	# tmp137,, acc_sf_47
	movl	%eax, -56(%rbp)	# acc_sf_47, acc_sf
# src/iir_filter_core.c:31:     for (int i = 0; i < (int)input_length; i++)
	movl	$0, -12(%rbp)	#, i
# src/iir_filter_core.c:31:     for (int i = 0; i < (int)input_length; i++)
	jmp	.L6	#
.L13:
# src/iir_filter_core.c:35:         int64_t num_acc = 0;
	movq	$0, -24(%rbp)	#, num_acc
# src/iir_filter_core.c:36:         for (int j = 0; j < filter->x_coeffs; j++)
	movl	$0, -28(%rbp)	#, j
# src/iir_filter_core.c:36:         for (int j = 0; j < filter->x_coeffs; j++)
	jmp	.L7	#
.L9:
# src/iir_filter_core.c:38:             if (i >= j)
	movl	-12(%rbp), %eax	# i, tmp138
	cmpl	-28(%rbp), %eax	# j, tmp138
	jl	.L8	#,
# src/iir_filter_core.c:41:                     (int64_t)filter->x[j] * input->input_data_buffer[i - j];
	movq	-104(%rbp), %rax	# filter, tmp139
	movl	-28(%rbp), %edx	# j, tmp141
	movslq	%edx, %rdx	# tmp141, tmp140
	movzwl	(%rax,%rdx,2), %eax	# filter_44(D)->x[j_38], _3
# src/iir_filter_core.c:41:                     (int64_t)filter->x[j] * input->input_data_buffer[i - j];
	movswq	%ax, %rdx	# _3, _4
# src/iir_filter_core.c:41:                     (int64_t)filter->x[j] * input->input_data_buffer[i - j];
	movl	-12(%rbp), %eax	# i, tmp142
	subl	-28(%rbp), %eax	# j, tmp142
	movl	%eax, %ecx	# tmp142, _5
# src/iir_filter_core.c:41:                     (int64_t)filter->x[j] * input->input_data_buffer[i - j];
	movq	-80(%rbp), %rax	# input, tmp143
	movslq	%ecx, %rcx	# _5, tmp144
	movzwl	(%rax,%rcx,2), %eax	# input_62(D)->input_data_buffer[_5], _6
	movswq	%ax, %rax	# _6, _7
# src/iir_filter_core.c:41:                     (int64_t)filter->x[j] * input->input_data_buffer[i - j];
	imulq	%rdx, %rax	# _4, _8
# src/iir_filter_core.c:40:                 num_acc +=
	addq	%rax, -24(%rbp)	# _8, num_acc
.L8:
# src/iir_filter_core.c:36:         for (int j = 0; j < filter->x_coeffs; j++)
	addl	$1, -28(%rbp)	#, j
.L7:
# src/iir_filter_core.c:36:         for (int j = 0; j < filter->x_coeffs; j++)
	movq	-104(%rbp), %rax	# filter, tmp145
	movzwl	400(%rax), %eax	# filter_44(D)->x_coeffs, _9
	movzwl	%ax, %eax	# _9, _10
# src/iir_filter_core.c:36:         for (int j = 0; j < filter->x_coeffs; j++)
	cmpl	%eax, -28(%rbp)	# _10, j
	jl	.L9	#,
# src/iir_filter_core.c:46:         int64_t den_acc = 0;
	movq	$0, -40(%rbp)	#, den_acc
# src/iir_filter_core.c:47:         for (int j = 1; j < filter->y_coeffs; j++)
	movl	$1, -44(%rbp)	#, j
# src/iir_filter_core.c:47:         for (int j = 1; j < filter->y_coeffs; j++)
	jmp	.L10	#
.L12:
# src/iir_filter_core.c:49:             if (i >= j)
	movl	-12(%rbp), %eax	# i, tmp146
	cmpl	-44(%rbp), %eax	# j, tmp146
	jl	.L11	#,
# src/iir_filter_core.c:51:                 den_acc += (int64_t)filter->y[j] * output[i - j];
	movq	-104(%rbp), %rax	# filter, tmp147
	movl	-44(%rbp), %edx	# j, tmp149
	movslq	%edx, %rdx	# tmp149, tmp148
	addq	$96, %rdx	#, tmp150
	movzwl	8(%rax,%rdx,2), %eax	# filter_44(D)->y[j_41], _11
# src/iir_filter_core.c:51:                 den_acc += (int64_t)filter->y[j] * output[i - j];
	movswq	%ax, %rdx	# _11, _12
# src/iir_filter_core.c:51:                 den_acc += (int64_t)filter->y[j] * output[i - j];
	movl	-12(%rbp), %eax	# i, tmp151
	subl	-44(%rbp), %eax	# j, _13
	cltq
# src/iir_filter_core.c:51:                 den_acc += (int64_t)filter->y[j] * output[i - j];
	leaq	(%rax,%rax), %rcx	#, _15
	movq	-88(%rbp), %rax	# output, tmp152
	addq	%rcx, %rax	# _15, _16
	movzwl	(%rax), %eax	# *_16, _17
	movswq	%ax, %rax	# _17, _18
# src/iir_filter_core.c:51:                 den_acc += (int64_t)filter->y[j] * output[i - j];
	imulq	%rdx, %rax	# _12, _19
# src/iir_filter_core.c:51:                 den_acc += (int64_t)filter->y[j] * output[i - j];
	addq	%rax, -40(%rbp)	# _19, den_acc
.L11:
# src/iir_filter_core.c:47:         for (int j = 1; j < filter->y_coeffs; j++)
	addl	$1, -44(%rbp)	#, j
.L10:
# src/iir_filter_core.c:47:         for (int j = 1; j < filter->y_coeffs; j++)
	movq	-104(%rbp), %rax	# filter, tmp153
	movzwl	402(%rax), %eax	# filter_44(D)->y_coeffs, _20
	movzwl	%ax, %eax	# _20, _21
# src/iir_filter_core.c:47:         for (int j = 1; j < filter->y_coeffs; j++)
	cmpl	%eax, -44(%rbp)	# _21, j
	jl	.L12	#,
# src/iir_filter_core.c:56:             (num_acc << (acc_sf - num_sf)) - (den_acc << (acc_sf - den_sf));
	movl	-56(%rbp), %eax	# acc_sf, tmp154
	subl	-48(%rbp), %eax	# num_sf, _22
# src/iir_filter_core.c:56:             (num_acc << (acc_sf - num_sf)) - (den_acc << (acc_sf - den_sf));
	movq	-24(%rbp), %rdx	# num_acc, tmp155
	movq	%rdx, %rsi	# tmp155, tmp155
	movl	%eax, %ecx	# _22, tmp171
	salq	%cl, %rsi	# tmp171, tmp155
# src/iir_filter_core.c:56:             (num_acc << (acc_sf - num_sf)) - (den_acc << (acc_sf - den_sf));
	movl	-56(%rbp), %eax	# acc_sf, tmp156
	subl	-52(%rbp), %eax	# den_sf, _24
# src/iir_filter_core.c:56:             (num_acc << (acc_sf - num_sf)) - (den_acc << (acc_sf - den_sf));
	movq	-40(%rbp), %rdx	# den_acc, tmp157
	movl	%eax, %ecx	# _24, tmp172
	salq	%cl, %rdx	# tmp172, _25
# src/iir_filter_core.c:55:         int64_t total =
	movq	%rsi, %rax	# _23, _23
	subq	%rdx, %rax	# _25, _23
	movq	%rax, -64(%rbp)	# tmp158, total
# src/iir_filter_core.c:58:         total = (total + (1 << (acc_sf - 1))) >> acc_sf;
	movl	-56(%rbp), %eax	# acc_sf, tmp159
	subl	$1, %eax	#, _26
# src/iir_filter_core.c:58:         total = (total + (1 << (acc_sf - 1))) >> acc_sf;
	movl	$1, %edx	#, tmp160
	movl	%eax, %ecx	# _26, tmp175
	sall	%cl, %edx	# tmp175, tmp160
	movl	%edx, %eax	# tmp160, _27
	movslq	%eax, %rdx	# _27, _28
# src/iir_filter_core.c:58:         total = (total + (1 << (acc_sf - 1))) >> acc_sf;
	movq	-64(%rbp), %rax	# total, tmp161
	addq	%rax, %rdx	# tmp161, _29
# src/iir_filter_core.c:58:         total = (total + (1 << (acc_sf - 1))) >> acc_sf;
	movl	-56(%rbp), %eax	# acc_sf, tmp162
	movl	%eax, %ecx	# tmp162, tmp177
	sarq	%cl, %rdx	# tmp177, _29
	movq	%rdx, %rax	# _29, tmp163
	movq	%rax, -64(%rbp)	# tmp163, total
# src/iir_filter_core.c:59:         output[i] = saturate_int16(total);
	movl	-12(%rbp), %eax	# i, tmp164
	cltq
	leaq	(%rax,%rax), %rdx	#, _31
	movq	-88(%rbp), %rax	# output, tmp165
	leaq	(%rdx,%rax), %rbx	#, _32
# src/iir_filter_core.c:59:         output[i] = saturate_int16(total);
	movq	-64(%rbp), %rax	# total, tmp166
	movq	%rax, %rdi	# tmp166,
	call	saturate_int16	#
# src/iir_filter_core.c:59:         output[i] = saturate_int16(total);
	movw	%ax, (%rbx)	# _33, *_32
# src/iir_filter_core.c:31:     for (int i = 0; i < (int)input_length; i++)
	addl	$1, -12(%rbp)	#, i
.L6:
# src/iir_filter_core.c:31:     for (int i = 0; i < (int)input_length; i++)
	movl	-92(%rbp), %eax	# input_length, input_length.0_34
# src/iir_filter_core.c:31:     for (int i = 0; i < (int)input_length; i++)
	cmpl	%eax, -12(%rbp)	# input_length.0_34, i
	jl	.L13	#,
# src/iir_filter_core.c:61: }
	nop	
	nop	
	movq	-8(%rbp), %rbx	#,
	leave	
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
# src/iir_filter_core.c:68:     for (int i = 0; i < (int)input_length; i++)
	movl	$0, -4(%rbp)	#, i
# src/iir_filter_core.c:68:     for (int i = 0; i < (int)input_length; i++)
	jmp	.L15	#
.L22:
# src/iir_filter_core.c:70:         float num_acc = 0;
	pxor	%xmm0, %xmm0	# tmp125
	movss	%xmm0, -8(%rbp)	# tmp125, num_acc
# src/iir_filter_core.c:71:         for (int j = 0; j < *coeffsx; j++)
	movl	$0, -12(%rbp)	#, j
# src/iir_filter_core.c:71:         for (int j = 0; j < *coeffsx; j++)
	jmp	.L16	#
.L18:
# src/iir_filter_core.c:73:             if (i >= j)
	movl	-4(%rbp), %eax	# i, tmp126
	cmpl	-12(%rbp), %eax	# j, tmp126
	jl	.L17	#,
# src/iir_filter_core.c:75:                 num_acc += filter_x[j] * input[i - j];
	movl	-12(%rbp), %eax	# j, tmp127
	cltq
	leaq	0(,%rax,4), %rdx	#, _2
	movq	-64(%rbp), %rax	# filter_x, tmp128
	addq	%rdx, %rax	# _2, _3
	movss	(%rax), %xmm1	# *_3, _4
# src/iir_filter_core.c:75:                 num_acc += filter_x[j] * input[i - j];
	movl	-4(%rbp), %eax	# i, tmp129
	subl	-12(%rbp), %eax	# j, _5
	cltq
# src/iir_filter_core.c:75:                 num_acc += filter_x[j] * input[i - j];
	leaq	0(,%rax,4), %rdx	#, _7
	movq	-40(%rbp), %rax	# input, tmp130
	addq	%rdx, %rax	# _7, _8
	movss	(%rax), %xmm0	# *_8, _9
# src/iir_filter_core.c:75:                 num_acc += filter_x[j] * input[i - j];
	mulss	%xmm1, %xmm0	# _4, _10
# src/iir_filter_core.c:75:                 num_acc += filter_x[j] * input[i - j];
	movss	-8(%rbp), %xmm1	# num_acc, tmp132
	addss	%xmm1, %xmm0	# tmp132, num_acc_53
	movss	%xmm0, -8(%rbp)	# num_acc_53, num_acc
.L17:
# src/iir_filter_core.c:71:         for (int j = 0; j < *coeffsx; j++)
	addl	$1, -12(%rbp)	#, j
.L16:
# src/iir_filter_core.c:71:         for (int j = 0; j < *coeffsx; j++)
	movq	-80(%rbp), %rax	# coeffsx, tmp133
	movl	(%rax), %eax	# *coeffsx_41(D), _11
# src/iir_filter_core.c:71:         for (int j = 0; j < *coeffsx; j++)
	cmpl	%eax, -12(%rbp)	# _11, j
	jl	.L18	#,
# src/iir_filter_core.c:80:         float den_acc = 0;
	pxor	%xmm0, %xmm0	# tmp134
	movss	%xmm0, -16(%rbp)	# tmp134, den_acc
# src/iir_filter_core.c:81:         for (int j = 1; j < *coeffsy; j++)
	movl	$1, -20(%rbp)	#, j
# src/iir_filter_core.c:81:         for (int j = 1; j < *coeffsy; j++)
	jmp	.L19	#
.L21:
# src/iir_filter_core.c:83:             if (i >= j)
	movl	-4(%rbp), %eax	# i, tmp135
	cmpl	-20(%rbp), %eax	# j, tmp135
	jl	.L20	#,
# src/iir_filter_core.c:85:                 den_acc += filter_y[j] * output[i - j];
	movl	-20(%rbp), %eax	# j, tmp136
	cltq
	leaq	0(,%rax,4), %rdx	#, _13
	movq	-72(%rbp), %rax	# filter_y, tmp137
	addq	%rdx, %rax	# _13, _14
	movss	(%rax), %xmm1	# *_14, _15
# src/iir_filter_core.c:85:                 den_acc += filter_y[j] * output[i - j];
	movl	-4(%rbp), %eax	# i, tmp138
	subl	-20(%rbp), %eax	# j, _16
	cltq
# src/iir_filter_core.c:85:                 den_acc += filter_y[j] * output[i - j];
	leaq	0(,%rax,4), %rdx	#, _18
	movq	-48(%rbp), %rax	# output, tmp139
	addq	%rdx, %rax	# _18, _19
	movss	(%rax), %xmm0	# *_19, _20
# src/iir_filter_core.c:85:                 den_acc += filter_y[j] * output[i - j];
	mulss	%xmm1, %xmm0	# _15, _21
# src/iir_filter_core.c:85:                 den_acc += filter_y[j] * output[i - j];
	movss	-16(%rbp), %xmm1	# den_acc, tmp141
	addss	%xmm1, %xmm0	# tmp141, den_acc_49
	movss	%xmm0, -16(%rbp)	# den_acc_49, den_acc
.L20:
# src/iir_filter_core.c:81:         for (int j = 1; j < *coeffsy; j++)
	addl	$1, -20(%rbp)	#, j
.L19:
# src/iir_filter_core.c:81:         for (int j = 1; j < *coeffsy; j++)
	movq	16(%rbp), %rax	# coeffsy, tmp142
	movl	(%rax), %eax	# *coeffsy_44(D), _22
# src/iir_filter_core.c:81:         for (int j = 1; j < *coeffsy; j++)
	cmpl	%eax, -20(%rbp)	# _22, j
	jl	.L21	#,
# src/iir_filter_core.c:88:         output[i] = num_acc - den_acc;
	movl	-4(%rbp), %eax	# i, tmp143
	cltq
	leaq	0(,%rax,4), %rdx	#, _24
	movq	-48(%rbp), %rax	# output, tmp144
	addq	%rdx, %rax	# _24, _25
# src/iir_filter_core.c:88:         output[i] = num_acc - den_acc;
	movss	-8(%rbp), %xmm0	# num_acc, tmp145
	subss	-16(%rbp), %xmm0	# den_acc, _26
# src/iir_filter_core.c:88:         output[i] = num_acc - den_acc;
	movss	%xmm0, (%rax)	# _26, *_25
# src/iir_filter_core.c:68:     for (int i = 0; i < (int)input_length; i++)
	addl	$1, -4(%rbp)	#, i
.L15:
# src/iir_filter_core.c:68:     for (int i = 0; i < (int)input_length; i++)
	movl	-52(%rbp), %eax	# input_length, input_length.1_27
# src/iir_filter_core.c:68:     for (int i = 0; i < (int)input_length; i++)
	cmpl	%eax, -4(%rbp)	# input_length.1_27, i
	jl	.L22	#,
# src/iir_filter_core.c:90: }
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
