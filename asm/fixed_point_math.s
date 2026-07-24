	.file	"fixed_point_math.c"
# GNU C23 (GCC) version 16.1.1 20260515 (Red Hat 16.1.1-2) (x86_64-redhat-linux)
#	compiled by GNU C version 16.1.1 20260515 (Red Hat 16.1.1-2), GMP version 6.3.0, MPFR version 4.2.2, MPC version 1.4.1, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mtune=generic -march=x86-64 -mtls-dialect=gnu2
	.text
	.section	.rodata
.LC2:
	.string	"max val %f\n"
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
	movl	%ecx, -56(%rbp)	# representation_max, representation_max
# src/fixed_point_math.c:14:     float max_val = 0;
	pxor	%xmm0, %xmm0	# tmp131
	movss	%xmm0, -4(%rbp)	# tmp131, max_val
# src/fixed_point_math.c:15:     for (int i = 0; i < size; i++)
	movl	$0, -8(%rbp)	#, i
# src/fixed_point_math.c:15:     for (int i = 0; i < size; i++)
	jmp	.L2	#
.L5:
# src/fixed_point_math.c:17:         if (fabsf(input[i]) > max_val)
	movl	-8(%rbp), %eax	# i, tmp132
	cltq
	leaq	0(,%rax,4), %rdx	#, _2
	movq	-40(%rbp), %rax	# input, tmp133
	addq	%rdx, %rax	# _2, _3
	movss	(%rax), %xmm0	# *_3, _4
# src/fixed_point_math.c:17:         if (fabsf(input[i]) > max_val)
	movss	.LC1(%rip), %xmm1	#, tmp134
	andps	%xmm1, %xmm0	# tmp134, _5
# src/fixed_point_math.c:17:         if (fabsf(input[i]) > max_val)
	comiss	-4(%rbp), %xmm0	# max_val, _5
	jbe	.L3	#,
# src/fixed_point_math.c:19:             max_val = fabsf(input[i]);
	movl	-8(%rbp), %eax	# i, tmp135
	cltq
	leaq	0(,%rax,4), %rdx	#, _7
	movq	-40(%rbp), %rax	# input, tmp136
	addq	%rdx, %rax	# _7, _8
	movss	(%rax), %xmm0	# *_8, _9
# src/fixed_point_math.c:19:             max_val = fabsf(input[i]);
	movss	.LC1(%rip), %xmm1	#, tmp138
	andps	%xmm1, %xmm0	# tmp138, max_val_63
	movss	%xmm0, -4(%rbp)	# max_val_63, max_val
.L3:
# src/fixed_point_math.c:15:     for (int i = 0; i < size; i++)
	addl	$1, -8(%rbp)	#, i
.L2:
# src/fixed_point_math.c:15:     for (int i = 0; i < size; i++)
	movl	-8(%rbp), %eax	# i, i.0_10
	cmpl	-52(%rbp), %eax	# size, i.0_10
	jb	.L5	#,
# src/fixed_point_math.c:23:     if (max_val == 0.0f)
	pxor	%xmm0, %xmm0	# tmp139
	ucomiss	-4(%rbp), %xmm0	# max_val, tmp139
	jp	.L6	#,
	pxor	%xmm0, %xmm0	# tmp140
	ucomiss	-4(%rbp), %xmm0	# max_val, tmp140
	jne	.L6	#,
# src/fixed_point_math.c:25:         for (int i = 0; i < (int)size; i++)
	movl	$0, -12(%rbp)	#, i
# src/fixed_point_math.c:25:         for (int i = 0; i < (int)size; i++)
	jmp	.L8	#
.L9:
# src/fixed_point_math.c:26:             output[i] = 0;
	movl	-12(%rbp), %eax	# i, tmp141
	cltq
	leaq	(%rax,%rax), %rdx	#, _12
	movq	-48(%rbp), %rax	# output, tmp142
	addq	%rdx, %rax	# _12, _13
# src/fixed_point_math.c:26:             output[i] = 0;
	movw	$0, (%rax)	#, *_13
# src/fixed_point_math.c:25:         for (int i = 0; i < (int)size; i++)
	addl	$1, -12(%rbp)	#, i
.L8:
# src/fixed_point_math.c:25:         for (int i = 0; i < (int)size; i++)
	movl	-52(%rbp), %eax	# size, size.1_14
# src/fixed_point_math.c:25:         for (int i = 0; i < (int)size; i++)
	cmpl	%eax, -12(%rbp)	# size.1_14, i
	jl	.L9	#,
# src/fixed_point_math.c:27:         return 0;
	movl	$0, %eax	#, _38
	jmp	.L10	#
.L6:
# src/fixed_point_math.c:29:     printf("max val %f\n", max_val);
	pxor	%xmm2, %xmm2	# _15
	cvtss2sd	-4(%rbp), %xmm2	# max_val, _15
	movq	%xmm2, %rax	# _15, _15
	movq	%rax, %xmm0	# _15,
	movl	$.LC2, %edi	#,
	movl	$1, %eax	#,
	call	printf	#
# src/fixed_point_math.c:34:     int8_t exponent = (int8_t)floorf(log2f(representation_max / max_val));
	movl	-56(%rbp), %eax	# representation_max, tmp143
	testq	%rax, %rax	# tmp143
	js	.L11	#,
	pxor	%xmm0, %xmm0	# _16
	cvtsi2ssq	%rax, %xmm0	# tmp143, _16
	jmp	.L12	#
.L11:
	movq	%rax, %rdx	# tmp143, tmp145
	shrq	%rdx	# tmp145
	andl	$1, %eax	#, tmp146
	orq	%rax, %rdx	# tmp146, tmp145
	pxor	%xmm0, %xmm0	# tmp144
	cvtsi2ssq	%rdx, %xmm0	# tmp145, tmp144
	addss	%xmm0, %xmm0	# tmp144, _16
.L12:
	divss	-4(%rbp), %xmm0	# max_val, _16
	movd	%xmm0, %eax	# _16, _17
	movd	%eax, %xmm0	# _17,
	call	log2f	#
	movd	%xmm0, %eax	#, _18
# src/fixed_point_math.c:34:     int8_t exponent = (int8_t)floorf(log2f(representation_max / max_val));
	movd	%eax, %xmm0	# _18,
	call	floorf	#
# src/fixed_point_math.c:34:     int8_t exponent = (int8_t)floorf(log2f(representation_max / max_val));
	cvttss2sil	%xmm0, %eax	# _19, tmp147
	movb	%al, -13(%rbp)	# tmp147, exponent
# src/fixed_point_math.c:35:     if (exponent < 0)
	cmpb	$0, -13(%rbp)	#, exponent
	jns	.L13	#,
# src/fixed_point_math.c:36:         exponent = 0;
	movb	$0, -13(%rbp)	#, exponent
.L13:
# src/fixed_point_math.c:37:     float scale_factor = ldexpf(1.0f, exponent);
	movsbl	-13(%rbp), %eax	# exponent, _20
	movl	%eax, %edi	# _20,
	movl	.LC3(%rip), %eax	#, tmp148
	movd	%eax, %xmm0	# tmp148,
	call	ldexpf	#
	movd	%xmm0, %eax	#, tmp149
	movl	%eax, -24(%rbp)	# tmp149, scale_factor
# src/fixed_point_math.c:38:     for (int i = 0; i < (int)size; i++)
	movl	$0, -20(%rbp)	#, i
# src/fixed_point_math.c:38:     for (int i = 0; i < (int)size; i++)
	jmp	.L14	#
.L15:
# src/fixed_point_math.c:40:         output[i] = (int16_t)roundf(input[i] * scale_factor);
	movl	-20(%rbp), %eax	# i, tmp150
	cltq
	leaq	0(,%rax,4), %rdx	#, _22
	movq	-40(%rbp), %rax	# input, tmp151
	addq	%rdx, %rax	# _22, _23
	movss	(%rax), %xmm0	# *_23, _24
# src/fixed_point_math.c:40:         output[i] = (int16_t)roundf(input[i] * scale_factor);
	mulss	-24(%rbp), %xmm0	# scale_factor, _24
	movd	%xmm0, %eax	# _24, _25
	movd	%eax, %xmm0	# _25,
	call	roundf	#
# src/fixed_point_math.c:40:         output[i] = (int16_t)roundf(input[i] * scale_factor);
	movl	-20(%rbp), %eax	# i, tmp152
	cltq
	leaq	(%rax,%rax), %rdx	#, _28
	movq	-48(%rbp), %rax	# output, tmp153
	addq	%rdx, %rax	# _28, _29
# src/fixed_point_math.c:40:         output[i] = (int16_t)roundf(input[i] * scale_factor);
	cvttss2sil	%xmm0, %edx	# _26, tmp154
# src/fixed_point_math.c:40:         output[i] = (int16_t)roundf(input[i] * scale_factor);
	movw	%dx, (%rax)	# _30, *_29
# src/fixed_point_math.c:38:     for (int i = 0; i < (int)size; i++)
	addl	$1, -20(%rbp)	#, i
.L14:
# src/fixed_point_math.c:38:     for (int i = 0; i < (int)size; i++)
	movl	-52(%rbp), %eax	# size, size.2_31
# src/fixed_point_math.c:38:     for (int i = 0; i < (int)size; i++)
	cmpl	%eax, -20(%rbp)	# size.2_31, i
	jl	.L15	#,
# src/fixed_point_math.c:43:     return exponent;
	movzbl	-13(%rbp), %eax	# exponent, _38
.L10:
# src/fixed_point_math.c:44: }
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
.LC3:
	.long	1065353216
	.ident	"GCC: (GNU) 16.1.1 20260515 (Red Hat 16.1.1-2)"
	.section	.note.GNU-stack,"",@progbits
