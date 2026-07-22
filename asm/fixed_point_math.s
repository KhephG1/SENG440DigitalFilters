	.file	"fixed_point_math.c"
# GNU C23 (GCC) version 16.1.1 20260515 (Red Hat 16.1.1-2) (x86_64-redhat-linux)
#	compiled by GNU C version 16.1.1 20260515 (Red Hat 16.1.1-2), GMP version 6.3.0, MPFR version 4.2.2, MPC version 1.4.1, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mtune=generic -march=x86-64 -mtls-dialect=gnu2
	.text
	.globl	convert_to_fixed
	.type	convert_to_fixed, @function
convert_to_fixed:
.LFB6:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$64, %rsp	#,
	movq	%rdi, -40(%rbp)	# input, input
	movq	%rsi, -48(%rbp)	# output, output
	movl	%edx, -52(%rbp)	# size, size
# src/fixed_point_math.c:11:     float max_val = 0;
	pxor	%xmm0, %xmm0	# tmp129
	movss	%xmm0, -4(%rbp)	# tmp129, max_val
# src/fixed_point_math.c:12:     for (int i = 0; i < size; i++)
	movl	$0, -8(%rbp)	#, i
# src/fixed_point_math.c:12:     for (int i = 0; i < size; i++)
	jmp	.L2	#
.L5:
# src/fixed_point_math.c:14:         if (fabsf(input[i]) > max_val)
	movl	-8(%rbp), %eax	# i, tmp130
	cltq
	leaq	0(,%rax,4), %rdx	#, _2
	movq	-40(%rbp), %rax	# input, tmp131
	addq	%rdx, %rax	# _2, _3
	movss	(%rax), %xmm0	# *_3, _4
# src/fixed_point_math.c:14:         if (fabsf(input[i]) > max_val)
	movss	.LC1(%rip), %xmm1	#, tmp132
	andps	%xmm1, %xmm0	# tmp132, _5
# src/fixed_point_math.c:14:         if (fabsf(input[i]) > max_val)
	comiss	-4(%rbp), %xmm0	# max_val, _5
	jbe	.L3	#,
# src/fixed_point_math.c:16:             max_val = fabsf(input[i]);
	movl	-8(%rbp), %eax	# i, tmp133
	cltq
	leaq	0(,%rax,4), %rdx	#, _7
	movq	-40(%rbp), %rax	# input, tmp134
	addq	%rdx, %rax	# _7, _8
	movss	(%rax), %xmm0	# *_8, _9
# src/fixed_point_math.c:16:             max_val = fabsf(input[i]);
	movss	.LC1(%rip), %xmm1	#, tmp136
	andps	%xmm1, %xmm0	# tmp136, max_val_57
	movss	%xmm0, -4(%rbp)	# max_val_57, max_val
.L3:
# src/fixed_point_math.c:12:     for (int i = 0; i < size; i++)
	addl	$1, -8(%rbp)	#, i
.L2:
# src/fixed_point_math.c:12:     for (int i = 0; i < size; i++)
	movl	-8(%rbp), %eax	# i, i.0_10
	cmpl	-52(%rbp), %eax	# size, i.0_10
	jb	.L5	#,
# src/fixed_point_math.c:20:     if (max_val == 0.0f)
	pxor	%xmm0, %xmm0	# tmp137
	ucomiss	-4(%rbp), %xmm0	# max_val, tmp137
	jp	.L6	#,
	pxor	%xmm0, %xmm0	# tmp138
	ucomiss	-4(%rbp), %xmm0	# max_val, tmp138
	jne	.L6	#,
# src/fixed_point_math.c:22:         for (int i = 0; i < (int)size; i++)
	movl	$0, -12(%rbp)	#, i
# src/fixed_point_math.c:22:         for (int i = 0; i < (int)size; i++)
	jmp	.L8	#
.L9:
# src/fixed_point_math.c:23:             output[i] = 0;
	movl	-12(%rbp), %eax	# i, tmp139
	cltq
	leaq	(%rax,%rax), %rdx	#, _12
	movq	-48(%rbp), %rax	# output, tmp140
	addq	%rdx, %rax	# _12, _13
# src/fixed_point_math.c:23:             output[i] = 0;
	movw	$0, (%rax)	#, *_13
# src/fixed_point_math.c:22:         for (int i = 0; i < (int)size; i++)
	addl	$1, -12(%rbp)	#, i
.L8:
# src/fixed_point_math.c:22:         for (int i = 0; i < (int)size; i++)
	movl	-52(%rbp), %eax	# size, size.1_14
# src/fixed_point_math.c:22:         for (int i = 0; i < (int)size; i++)
	cmpl	%eax, -12(%rbp)	# size.1_14, i
	jl	.L9	#,
# src/fixed_point_math.c:24:         return 0;
	movl	$0, %eax	#, _35
	jmp	.L10	#
.L6:
# src/fixed_point_math.c:30:     int8_t exponent = (int8_t)floorf(log2f(32767.0f / max_val));
	movss	.LC2(%rip), %xmm0	#, tmp141
	divss	-4(%rbp), %xmm0	# max_val, tmp141
	movd	%xmm0, %eax	# tmp141, _15
	movd	%eax, %xmm0	# _15,
	call	log2f	#
	movd	%xmm0, %eax	#, _16
# src/fixed_point_math.c:30:     int8_t exponent = (int8_t)floorf(log2f(32767.0f / max_val));
	movd	%eax, %xmm0	# _16,
	call	floorf	#
# src/fixed_point_math.c:30:     int8_t exponent = (int8_t)floorf(log2f(32767.0f / max_val));
	cvttss2sil	%xmm0, %eax	# _17, tmp142
	movb	%al, -17(%rbp)	# tmp142, exponent
# src/fixed_point_math.c:31:     float scale_factor = ldexpf(1.0f, exponent);
	movsbl	-17(%rbp), %eax	# exponent, _18
	movl	%eax, %edi	# _18,
	movl	.LC3(%rip), %eax	#, tmp143
	movd	%eax, %xmm0	# tmp143,
	call	ldexpf	#
	movd	%xmm0, %eax	#, tmp144
	movl	%eax, -24(%rbp)	# tmp144, scale_factor
# src/fixed_point_math.c:32:     for (int i = 0; i < (int)size; i++)
	movl	$0, -16(%rbp)	#, i
# src/fixed_point_math.c:32:     for (int i = 0; i < (int)size; i++)
	jmp	.L11	#
.L12:
# src/fixed_point_math.c:34:         output[i] = (int16_t)roundf(input[i] * scale_factor);
	movl	-16(%rbp), %eax	# i, tmp145
	cltq
	leaq	0(,%rax,4), %rdx	#, _20
	movq	-40(%rbp), %rax	# input, tmp146
	addq	%rdx, %rax	# _20, _21
	movss	(%rax), %xmm0	# *_21, _22
# src/fixed_point_math.c:34:         output[i] = (int16_t)roundf(input[i] * scale_factor);
	mulss	-24(%rbp), %xmm0	# scale_factor, _22
	movd	%xmm0, %eax	# _22, _23
	movd	%eax, %xmm0	# _23,
	call	roundf	#
# src/fixed_point_math.c:34:         output[i] = (int16_t)roundf(input[i] * scale_factor);
	movl	-16(%rbp), %eax	# i, tmp147
	cltq
	leaq	(%rax,%rax), %rdx	#, _26
	movq	-48(%rbp), %rax	# output, tmp148
	addq	%rdx, %rax	# _26, _27
# src/fixed_point_math.c:34:         output[i] = (int16_t)roundf(input[i] * scale_factor);
	cvttss2sil	%xmm0, %edx	# _24, tmp149
# src/fixed_point_math.c:34:         output[i] = (int16_t)roundf(input[i] * scale_factor);
	movw	%dx, (%rax)	# _28, *_27
# src/fixed_point_math.c:32:     for (int i = 0; i < (int)size; i++)
	addl	$1, -16(%rbp)	#, i
.L11:
# src/fixed_point_math.c:32:     for (int i = 0; i < (int)size; i++)
	movl	-52(%rbp), %eax	# size, size.2_29
# src/fixed_point_math.c:32:     for (int i = 0; i < (int)size; i++)
	cmpl	%eax, -16(%rbp)	# size.2_29, i
	jl	.L12	#,
# src/fixed_point_math.c:37:     return exponent;
	movzbl	-17(%rbp), %eax	# exponent, _35
.L10:
# src/fixed_point_math.c:38: }
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE6:
	.size	convert_to_fixed, .-convert_to_fixed
	.section	.rodata
	.align 16
.LC1:
	.long	2147483647
	.long	0
	.long	0
	.long	0
	.align 4
.LC2:
	.long	1191181824
	.align 4
.LC3:
	.long	1065353216
	.ident	"GCC: (GNU) 16.1.1 20260515 (Red Hat 16.1.1-2)"
	.section	.note.GNU-stack,"",@progbits
