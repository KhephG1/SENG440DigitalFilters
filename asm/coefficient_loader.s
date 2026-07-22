	.file	"coefficient_loader.c"
# GNU C23 (GCC) version 16.1.1 20260515 (Red Hat 16.1.1-2) (x86_64-redhat-linux)
#	compiled by GNU C version 16.1.1 20260515 (Red Hat 16.1.1-2), GMP version 6.3.0, MPFR version 4.2.2, MPC version 1.4.1, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mtune=generic -march=x86-64 -mtls-dialect=gnu2
	.text
	.section	.rodata
.LC0:
	.string	"r"
.LC1:
	.string	"num\n"
.LC3:
	.string	"%f"
	.text
	.globl	load_coefficients_fixed
	.type	load_coefficients_fixed, @function
load_coefficients_fixed:
.LFB0:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$544, %rsp	#,
	movq	%rdi, -520(%rbp)	# filename, filename
	movl	%esi, -524(%rbp)	# type, type
	movq	%rdx, -536(%rbp)	# filter, filter
# src/coefficient_loader.c:13:     FILE *input = fopen(filename, "r");
	movq	-520(%rbp), %rax	# filename, tmp125
	movl	$.LC0, %esi	#,
	movq	%rax, %rdi	# tmp125,
	call	fopen	#
	movq	%rax, -16(%rbp)	# tmp126, input
# src/coefficient_loader.c:14:     float temp[MAX_COEFFS] = {};
	leaq	-432(%rbp), %rax	#, tmp127
	movl	$400, %edx	#, tmp128
	movl	$0, %esi	#,
	movq	%rax, %rdi	# tmp127,
	call	memset	#
# src/coefficient_loader.c:15:     if (!input)
	cmpq	$0, -16(%rbp)	#, input
	jne	.L2	#,
# src/coefficient_loader.c:17:         return -1;  // invalid file path
	movl	$-1, %eax	#, _29
	jmp	.L17	#
.L2:
# src/coefficient_loader.c:20:     int i = 0;
	movl	$0, -4(%rbp)	#, i
# src/coefficient_loader.c:21:     int j = 0;
	movl	$0, -8(%rbp)	#, j
# src/coefficient_loader.c:23:     char *result = fgets(label, MAXLINE, input);
	movq	-16(%rbp), %rdx	# input, tmp131
	leaq	-496(%rbp), %rax	#, tmp132
	movl	$50, %esi	#,
	movq	%rax, %rdi	# tmp132,
	call	fgets	#
	movq	%rax, -24(%rbp)	# tmp133, result
# src/coefficient_loader.c:24:     if (!result || strcmp(label, "num\n") != 0)
	cmpq	$0, -24(%rbp)	#, result
	je	.L4	#,
# src/coefficient_loader.c:24:     if (!result || strcmp(label, "num\n") != 0)
	leaq	-496(%rbp), %rax	#, tmp134
	movl	$.LC1, %esi	#,
	movq	%rax, %rdi	# tmp134,
	call	strcmp	#
# src/coefficient_loader.c:24:     if (!result || strcmp(label, "num\n") != 0)
	testl	%eax, %eax	# _1
	je	.L5	#,
.L4:
# src/coefficient_loader.c:26:         return -1;  // invalid filter file format
	movl	$-1, %eax	#, _29
	jmp	.L17	#
.L5:
# src/coefficient_loader.c:29:     if (type == FIR)
	cmpl	$0, -524(%rbp)	#, type
	jne	.L6	#,
# src/coefficient_loader.c:32:         float coef = 0.f;
	pxor	%xmm0, %xmm0	# tmp135
	movss	%xmm0, -500(%rbp)	# tmp135, coef
# src/coefficient_loader.c:33:         while (fscanf(input, "%f", &coef) == 1 && i < MAX_COEFFS)
	jmp	.L7	#
.L9:
# src/coefficient_loader.c:35:             temp[i] = coef;
	movss	-500(%rbp), %xmm0	# coef, coef.0_2
	movl	-4(%rbp), %eax	# i, tmp137
	cltq
	movss	%xmm0, -432(%rbp,%rax,4)	# coef.0_2, temp[i_26]
# src/coefficient_loader.c:36:             i++;
	addl	$1, -4(%rbp)	#, i
.L7:
# src/coefficient_loader.c:33:         while (fscanf(input, "%f", &coef) == 1 && i < MAX_COEFFS)
	leaq	-500(%rbp), %rdx	#, tmp138
	movq	-16(%rbp), %rax	# input, tmp139
	movl	$.LC3, %esi	#,
	movq	%rax, %rdi	# tmp139,
	movl	$0, %eax	#,
	call	__isoc23_fscanf	#
# src/coefficient_loader.c:33:         while (fscanf(input, "%f", &coef) == 1 && i < MAX_COEFFS)
	cmpl	$1, %eax	#, _3
	jne	.L8	#,
# src/coefficient_loader.c:33:         while (fscanf(input, "%f", &coef) == 1 && i < MAX_COEFFS)
	cmpl	$99, -4(%rbp)	#, i
	jle	.L9	#,
.L8:
# src/coefficient_loader.c:38:         filter->x_coeffs = i;
	movl	-4(%rbp), %eax	# i, tmp140
	movl	%eax, %edx	# tmp140, _4
	movq	-536(%rbp), %rax	# filter, tmp141
	movw	%dx, 400(%rax)	# _4, filter_49(D)->x_coeffs
# src/coefficient_loader.c:40:             convert_to_fixed(temp, filter->x, filter->x_coeffs);
	movq	-536(%rbp), %rax	# filter, tmp142
	movzwl	400(%rax), %eax	# filter_49(D)->x_coeffs, _5
# src/coefficient_loader.c:40:             convert_to_fixed(temp, filter->x, filter->x_coeffs);
	movzwl	%ax, %edx	# _5, _6
# src/coefficient_loader.c:40:             convert_to_fixed(temp, filter->x, filter->x_coeffs);
	movq	-536(%rbp), %rcx	# filter, _7
# src/coefficient_loader.c:40:             convert_to_fixed(temp, filter->x, filter->x_coeffs);
	leaq	-432(%rbp), %rax	#, tmp143
	movq	%rcx, %rsi	# _7,
	movq	%rax, %rdi	# tmp143,
	call	convert_to_fixed	#
# src/coefficient_loader.c:40:             convert_to_fixed(temp, filter->x, filter->x_coeffs);
	movl	%eax, %edx	# _8, _9
# src/coefficient_loader.c:39:         filter->num_scale_factor_exp =
	movq	-536(%rbp), %rax	# filter, tmp144
	movb	%dl, 404(%rax)	# _9, filter_49(D)->num_scale_factor_exp
# src/coefficient_loader.c:41:         fclose(input);
	movq	-16(%rbp), %rax	# input, tmp145
	movq	%rax, %rdi	# tmp145,
	call	fclose	#
# src/coefficient_loader.c:42:         return i;
	movl	-4(%rbp), %eax	# i, _29
	jmp	.L17	#
.L6:
# src/coefficient_loader.c:44:     else if (type == IIR)
	cmpl	$1, -524(%rbp)	#, type
	jne	.L10	#,
# src/coefficient_loader.c:46:         float coef = 0.f;
	pxor	%xmm0, %xmm0	# tmp146
	movss	%xmm0, -504(%rbp)	# tmp146, coef
# src/coefficient_loader.c:47:         while (fscanf(input, "%f", &coef) == 1 && i < MAX_COEFFS)
	jmp	.L11	#
.L13:
# src/coefficient_loader.c:49:             temp[i] = coef;
	movss	-504(%rbp), %xmm0	# coef, coef.1_10
	movl	-4(%rbp), %eax	# i, tmp148
	cltq
	movss	%xmm0, -432(%rbp,%rax,4)	# coef.1_10, temp[i_27]
# src/coefficient_loader.c:50:             i++;
	addl	$1, -4(%rbp)	#, i
.L11:
# src/coefficient_loader.c:47:         while (fscanf(input, "%f", &coef) == 1 && i < MAX_COEFFS)
	leaq	-504(%rbp), %rdx	#, tmp149
	movq	-16(%rbp), %rax	# input, tmp150
	movl	$.LC3, %esi	#,
	movq	%rax, %rdi	# tmp150,
	movl	$0, %eax	#,
	call	__isoc23_fscanf	#
# src/coefficient_loader.c:47:         while (fscanf(input, "%f", &coef) == 1 && i < MAX_COEFFS)
	cmpl	$1, %eax	#, _11
	jne	.L12	#,
# src/coefficient_loader.c:47:         while (fscanf(input, "%f", &coef) == 1 && i < MAX_COEFFS)
	cmpl	$99, -4(%rbp)	#, i
	jle	.L13	#,
.L12:
# src/coefficient_loader.c:52:         filter->x_coeffs = i;
	movl	-4(%rbp), %eax	# i, tmp151
	movl	%eax, %edx	# tmp151, _12
	movq	-536(%rbp), %rax	# filter, tmp152
	movw	%dx, 400(%rax)	# _12, filter_49(D)->x_coeffs
# src/coefficient_loader.c:54:             convert_to_fixed(temp, filter->x, filter->x_coeffs);
	movq	-536(%rbp), %rax	# filter, tmp153
	movzwl	400(%rax), %eax	# filter_49(D)->x_coeffs, _13
# src/coefficient_loader.c:54:             convert_to_fixed(temp, filter->x, filter->x_coeffs);
	movzwl	%ax, %edx	# _13, _14
# src/coefficient_loader.c:54:             convert_to_fixed(temp, filter->x, filter->x_coeffs);
	movq	-536(%rbp), %rcx	# filter, _15
# src/coefficient_loader.c:54:             convert_to_fixed(temp, filter->x, filter->x_coeffs);
	leaq	-432(%rbp), %rax	#, tmp154
	movq	%rcx, %rsi	# _15,
	movq	%rax, %rdi	# tmp154,
	call	convert_to_fixed	#
# src/coefficient_loader.c:54:             convert_to_fixed(temp, filter->x, filter->x_coeffs);
	movl	%eax, %edx	# _16, _17
# src/coefficient_loader.c:53:         filter->num_scale_factor_exp =
	movq	-536(%rbp), %rax	# filter, tmp155
	movb	%dl, 404(%rax)	# _17, filter_49(D)->num_scale_factor_exp
# src/coefficient_loader.c:56:             fgets(label, MAXLINE, input);  // get rid of the "den" line
	movq	-16(%rbp), %rdx	# input, tmp156
	leaq	-496(%rbp), %rax	#, tmp157
	movl	$50, %esi	#,
	movq	%rax, %rdi	# tmp157,
	call	fgets	#
	movq	%rax, -32(%rbp)	# tmp158, result
# src/coefficient_loader.c:57:         while (fscanf(input, "%f", &coef) == 1 && j < MAX_COEFFS && result)
	jmp	.L14	#
.L16:
# src/coefficient_loader.c:60:             temp[j] = coef;
	movss	-504(%rbp), %xmm0	# coef, coef.2_18
	movl	-8(%rbp), %eax	# j, tmp160
	cltq
	movss	%xmm0, -432(%rbp,%rax,4)	# coef.2_18, temp[j_28]
# src/coefficient_loader.c:61:             j++;
	addl	$1, -8(%rbp)	#, j
.L14:
# src/coefficient_loader.c:57:         while (fscanf(input, "%f", &coef) == 1 && j < MAX_COEFFS && result)
	leaq	-504(%rbp), %rdx	#, tmp161
	movq	-16(%rbp), %rax	# input, tmp162
	movl	$.LC3, %esi	#,
	movq	%rax, %rdi	# tmp162,
	movl	$0, %eax	#,
	call	__isoc23_fscanf	#
# src/coefficient_loader.c:57:         while (fscanf(input, "%f", &coef) == 1 && j < MAX_COEFFS && result)
	cmpl	$1, %eax	#, _19
	jne	.L15	#,
# src/coefficient_loader.c:57:         while (fscanf(input, "%f", &coef) == 1 && j < MAX_COEFFS && result)
	cmpl	$99, -8(%rbp)	#, j
	jg	.L15	#,
# src/coefficient_loader.c:57:         while (fscanf(input, "%f", &coef) == 1 && j < MAX_COEFFS && result)
	cmpq	$0, -32(%rbp)	#, result
	jne	.L16	#,
.L15:
# src/coefficient_loader.c:63:         filter->y_coeffs = j;
	movl	-8(%rbp), %eax	# j, tmp163
	movl	%eax, %edx	# tmp163, _20
	movq	-536(%rbp), %rax	# filter, tmp164
	movw	%dx, 402(%rax)	# _20, filter_49(D)->y_coeffs
# src/coefficient_loader.c:65:             convert_to_fixed(temp, filter->y, filter->y_coeffs);
	movq	-536(%rbp), %rax	# filter, tmp165
	movzwl	402(%rax), %eax	# filter_49(D)->y_coeffs, _21
# src/coefficient_loader.c:65:             convert_to_fixed(temp, filter->y, filter->y_coeffs);
	movzwl	%ax, %edx	# _21, _22
# src/coefficient_loader.c:65:             convert_to_fixed(temp, filter->y, filter->y_coeffs);
	movq	-536(%rbp), %rax	# filter, tmp166
	leaq	200(%rax), %rcx	#, _23
# src/coefficient_loader.c:65:             convert_to_fixed(temp, filter->y, filter->y_coeffs);
	leaq	-432(%rbp), %rax	#, tmp167
	movq	%rcx, %rsi	# _23,
	movq	%rax, %rdi	# tmp167,
	call	convert_to_fixed	#
# src/coefficient_loader.c:65:             convert_to_fixed(temp, filter->y, filter->y_coeffs);
	movl	%eax, %edx	# _24, _25
# src/coefficient_loader.c:64:         filter->den_scale_factor_exp =
	movq	-536(%rbp), %rax	# filter, tmp168
	movb	%dl, 405(%rax)	# _25, filter_49(D)->den_scale_factor_exp
# src/coefficient_loader.c:66:         fclose(input);
	movq	-16(%rbp), %rax	# input, tmp169
	movq	%rax, %rdi	# tmp169,
	call	fclose	#
# src/coefficient_loader.c:67:         return i + j;
	movl	-4(%rbp), %edx	# i, tmp170
	movl	-8(%rbp), %eax	# j, tmp171
	addl	%edx, %eax	# tmp170, _29
	jmp	.L17	#
.L10:
# src/coefficient_loader.c:72:         return -1;
	movl	$-1, %eax	#, _29
.L17:
# src/coefficient_loader.c:74: }
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE0:
	.size	load_coefficients_fixed, .-load_coefficients_fixed
	.globl	load_coefficients_float
	.type	load_coefficients_float, @function
load_coefficients_float:
.LFB1:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$160, %rsp	#,
	movq	%rdi, -120(%rbp)	# filename, filename
	movl	%esi, -124(%rbp)	# type, type
	movq	%rdx, -136(%rbp)	# filter_x, filter_x
	movq	%rcx, -144(%rbp)	# filter_y, filter_y
	movq	%r8, -152(%rbp)	# coeffs_x, coeffs_x
	movq	%r9, -160(%rbp)	# coeffs_y, coeffs_y
# src/coefficient_loader.c:80:     FILE *input = fopen(filename, "r");
	movq	-120(%rbp), %rax	# filename, tmp116
	movl	$.LC0, %esi	#,
	movq	%rax, %rdi	# tmp116,
	call	fopen	#
	movq	%rax, -16(%rbp)	# tmp117, input
# src/coefficient_loader.c:81:     if (!input)
	cmpq	$0, -16(%rbp)	#, input
	jne	.L19	#,
# src/coefficient_loader.c:83:         return -1;  // invalid file path
	movl	$-1, %eax	#, _20
	jmp	.L34	#
.L19:
# src/coefficient_loader.c:86:     int i = 0;
	movl	$0, -4(%rbp)	#, i
# src/coefficient_loader.c:87:     int j = 0;
	movl	$0, -8(%rbp)	#, j
# src/coefficient_loader.c:89:     char *result = fgets(label, MAXLINE, input);
	movq	-16(%rbp), %rdx	# input, tmp118
	leaq	-96(%rbp), %rax	#, tmp119
	movl	$50, %esi	#,
	movq	%rax, %rdi	# tmp119,
	call	fgets	#
	movq	%rax, -24(%rbp)	# tmp120, result
# src/coefficient_loader.c:90:     if (!result || strcmp(label, "num\n") != 0)
	cmpq	$0, -24(%rbp)	#, result
	je	.L21	#,
# src/coefficient_loader.c:90:     if (!result || strcmp(label, "num\n") != 0)
	leaq	-96(%rbp), %rax	#, tmp121
	movl	$.LC1, %esi	#,
	movq	%rax, %rdi	# tmp121,
	call	strcmp	#
# src/coefficient_loader.c:90:     if (!result || strcmp(label, "num\n") != 0)
	testl	%eax, %eax	# _1
	je	.L22	#,
.L21:
# src/coefficient_loader.c:92:         return -1;  // invalid filter file format
	movl	$-1, %eax	#, _20
	jmp	.L34	#
.L22:
# src/coefficient_loader.c:95:     if (type == FIR)
	cmpl	$0, -124(%rbp)	#, type
	jne	.L23	#,
# src/coefficient_loader.c:98:         float coef = 0.f;
	pxor	%xmm0, %xmm0	# tmp122
	movss	%xmm0, -100(%rbp)	# tmp122, coef
# src/coefficient_loader.c:99:         while (fscanf(input, "%f", &coef) == 1 && i < MAX_COEFFS)
	jmp	.L24	#
.L26:
# src/coefficient_loader.c:101:             filter_x[i] = coef;
	movl	-4(%rbp), %eax	# i, tmp123
	cltq
	leaq	0(,%rax,4), %rdx	#, _3
	movq	-136(%rbp), %rax	# filter_x, tmp124
	addq	%rdx, %rax	# _3, _4
# src/coefficient_loader.c:101:             filter_x[i] = coef;
	movss	-100(%rbp), %xmm0	# coef, coef.3_5
	movss	%xmm0, (%rax)	# coef.3_5, *_4
# src/coefficient_loader.c:102:             i++;
	addl	$1, -4(%rbp)	#, i
.L24:
# src/coefficient_loader.c:99:         while (fscanf(input, "%f", &coef) == 1 && i < MAX_COEFFS)
	leaq	-100(%rbp), %rdx	#, tmp125
	movq	-16(%rbp), %rax	# input, tmp126
	movl	$.LC3, %esi	#,
	movq	%rax, %rdi	# tmp126,
	movl	$0, %eax	#,
	call	__isoc23_fscanf	#
# src/coefficient_loader.c:99:         while (fscanf(input, "%f", &coef) == 1 && i < MAX_COEFFS)
	cmpl	$1, %eax	#, _6
	jne	.L25	#,
# src/coefficient_loader.c:99:         while (fscanf(input, "%f", &coef) == 1 && i < MAX_COEFFS)
	cmpl	$99, -4(%rbp)	#, i
	jle	.L26	#,
.L25:
# src/coefficient_loader.c:104:         *coeffs_x = i;
	movq	-152(%rbp), %rax	# coeffs_x, tmp127
	movl	-4(%rbp), %edx	# i, tmp128
	movl	%edx, (%rax)	# tmp128, *coeffs_x_40(D)
# src/coefficient_loader.c:105:         fclose(input);
	movq	-16(%rbp), %rax	# input, tmp129
	movq	%rax, %rdi	# tmp129,
	call	fclose	#
# src/coefficient_loader.c:106:         return i;
	movl	-4(%rbp), %eax	# i, _20
	jmp	.L34	#
.L23:
# src/coefficient_loader.c:108:     else if (type == IIR)
	cmpl	$1, -124(%rbp)	#, type
	jne	.L27	#,
# src/coefficient_loader.c:110:         float coef = 0.f;
	pxor	%xmm0, %xmm0	# tmp130
	movss	%xmm0, -104(%rbp)	# tmp130, coef
# src/coefficient_loader.c:111:         while (fscanf(input, "%f", &coef) == 1 && i < MAX_COEFFS)
	jmp	.L28	#
.L30:
# src/coefficient_loader.c:113:             filter_x[i] = coef;
	movl	-4(%rbp), %eax	# i, tmp131
	cltq
	leaq	0(,%rax,4), %rdx	#, _8
	movq	-136(%rbp), %rax	# filter_x, tmp132
	addq	%rdx, %rax	# _8, _9
# src/coefficient_loader.c:113:             filter_x[i] = coef;
	movss	-104(%rbp), %xmm0	# coef, coef.4_10
	movss	%xmm0, (%rax)	# coef.4_10, *_9
# src/coefficient_loader.c:114:             i++;
	addl	$1, -4(%rbp)	#, i
.L28:
# src/coefficient_loader.c:111:         while (fscanf(input, "%f", &coef) == 1 && i < MAX_COEFFS)
	leaq	-104(%rbp), %rdx	#, tmp133
	movq	-16(%rbp), %rax	# input, tmp134
	movl	$.LC3, %esi	#,
	movq	%rax, %rdi	# tmp134,
	movl	$0, %eax	#,
	call	__isoc23_fscanf	#
# src/coefficient_loader.c:111:         while (fscanf(input, "%f", &coef) == 1 && i < MAX_COEFFS)
	cmpl	$1, %eax	#, _11
	jne	.L29	#,
# src/coefficient_loader.c:111:         while (fscanf(input, "%f", &coef) == 1 && i < MAX_COEFFS)
	cmpl	$99, -4(%rbp)	#, i
	jle	.L30	#,
.L29:
# src/coefficient_loader.c:116:         *coeffs_x = i;
	movq	-152(%rbp), %rax	# coeffs_x, tmp135
	movl	-4(%rbp), %edx	# i, tmp136
	movl	%edx, (%rax)	# tmp136, *coeffs_x_40(D)
# src/coefficient_loader.c:118:             fgets(label, MAXLINE, input);  // get rid of the "den" line
	movq	-16(%rbp), %rdx	# input, tmp137
	leaq	-96(%rbp), %rax	#, tmp138
	movl	$50, %esi	#,
	movq	%rax, %rdi	# tmp138,
	call	fgets	#
	movq	%rax, -32(%rbp)	# tmp139, result
# src/coefficient_loader.c:119:         while (fscanf(input, "%f", &coef) == 1 && j < MAX_COEFFS && result)
	jmp	.L31	#
.L33:
# src/coefficient_loader.c:122:             filter_y[j] = coef;
	movl	-8(%rbp), %eax	# j, tmp140
	cltq
	leaq	0(,%rax,4), %rdx	#, _13
	movq	-144(%rbp), %rax	# filter_y, tmp141
	addq	%rdx, %rax	# _13, _14
# src/coefficient_loader.c:122:             filter_y[j] = coef;
	movss	-104(%rbp), %xmm0	# coef, coef.5_15
	movss	%xmm0, (%rax)	# coef.5_15, *_14
# src/coefficient_loader.c:123:             j++;
	addl	$1, -8(%rbp)	#, j
.L31:
# src/coefficient_loader.c:119:         while (fscanf(input, "%f", &coef) == 1 && j < MAX_COEFFS && result)
	leaq	-104(%rbp), %rdx	#, tmp142
	movq	-16(%rbp), %rax	# input, tmp143
	movl	$.LC3, %esi	#,
	movq	%rax, %rdi	# tmp143,
	movl	$0, %eax	#,
	call	__isoc23_fscanf	#
# src/coefficient_loader.c:119:         while (fscanf(input, "%f", &coef) == 1 && j < MAX_COEFFS && result)
	cmpl	$1, %eax	#, _16
	jne	.L32	#,
# src/coefficient_loader.c:119:         while (fscanf(input, "%f", &coef) == 1 && j < MAX_COEFFS && result)
	cmpl	$99, -8(%rbp)	#, j
	jg	.L32	#,
# src/coefficient_loader.c:119:         while (fscanf(input, "%f", &coef) == 1 && j < MAX_COEFFS && result)
	cmpq	$0, -32(%rbp)	#, result
	jne	.L33	#,
.L32:
# src/coefficient_loader.c:125:         *coeffs_y = j;
	movq	-160(%rbp), %rax	# coeffs_y, tmp144
	movl	-8(%rbp), %edx	# j, tmp145
	movl	%edx, (%rax)	# tmp145, *coeffs_y_48(D)
# src/coefficient_loader.c:126:         fclose(input);
	movq	-16(%rbp), %rax	# input, tmp146
	movq	%rax, %rdi	# tmp146,
	call	fclose	#
# src/coefficient_loader.c:127:         return i + j;
	movl	-4(%rbp), %edx	# i, tmp147
	movl	-8(%rbp), %eax	# j, tmp148
	addl	%edx, %eax	# tmp147, _20
	jmp	.L34	#
.L27:
# src/coefficient_loader.c:132:         return -1;
	movl	$-1, %eax	#, _20
.L34:
# src/coefficient_loader.c:134: }
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE1:
	.size	load_coefficients_float, .-load_coefficients_float
	.section	.rodata
.LC4:
	.string	"%s"
.LC5:
	.string	"num"
.LC6:
	.string	"den"
.LC7:
	.string	"here: num sf %d, den_sf %d\n"
	.text
	.globl	load_biquad_fixed
	.type	load_biquad_fixed, @function
load_biquad_fixed:
.LFB2:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$144, %rsp	#,
	movq	%rdi, -120(%rbp)	# filenames, filenames
	movq	%rsi, -128(%rbp)	# biquads, biquads
	movl	%edx, -132(%rbp)	# num_biquads, num_biquads
# src/coefficient_loader.c:139:     for (int i = 0; i < num_biquads; i++)
	movl	$0, -4(%rbp)	#, i
# src/coefficient_loader.c:139:     for (int i = 0; i < num_biquads; i++)
	jmp	.L36	#
.L50:
# src/coefficient_loader.c:141:         FILE *input = fopen(filenames[i], "r");
	movl	-4(%rbp), %eax	# i, tmp152
	cltq
	leaq	0(,%rax,8), %rdx	#, _2
	movq	-120(%rbp), %rax	# filenames, tmp153
	addq	%rdx, %rax	# _2, _3
# src/coefficient_loader.c:141:         FILE *input = fopen(filenames[i], "r");
	movq	(%rax), %rax	# *_3, _4
	movl	$.LC0, %esi	#,
	movq	%rax, %rdi	# _4,
	call	fopen	#
	movq	%rax, -24(%rbp)	# tmp154, input
# src/coefficient_loader.c:143:         if (!input)
	cmpq	$0, -24(%rbp)	#, input
	jne	.L37	#,
# src/coefficient_loader.c:145:             return -1;
	movl	$-1, %eax	#, _56
	jmp	.L49	#
.L37:
# src/coefficient_loader.c:157:         if (fscanf(input, "%s", label) != 1 || strcmp(label, "num") != 0)
	leaq	-112(%rbp), %rdx	#, tmp155
	movq	-24(%rbp), %rax	# input, tmp156
	movl	$.LC4, %esi	#,
	movq	%rax, %rdi	# tmp156,
	movl	$0, %eax	#,
	call	__isoc23_fscanf	#
# src/coefficient_loader.c:157:         if (fscanf(input, "%s", label) != 1 || strcmp(label, "num") != 0)
	cmpl	$1, %eax	#, _5
	jne	.L39	#,
# src/coefficient_loader.c:157:         if (fscanf(input, "%s", label) != 1 || strcmp(label, "num") != 0)
	leaq	-112(%rbp), %rax	#, tmp157
	movl	$.LC5, %esi	#,
	movq	%rax, %rdi	# tmp157,
	call	strcmp	#
# src/coefficient_loader.c:157:         if (fscanf(input, "%s", label) != 1 || strcmp(label, "num") != 0)
	testl	%eax, %eax	# _6
	je	.L40	#,
.L39:
# src/coefficient_loader.c:159:             fclose(input);
	movq	-24(%rbp), %rax	# input, tmp158
	movq	%rax, %rdi	# tmp158,
	call	fclose	#
# src/coefficient_loader.c:160:             return -1;
	movl	$-1, %eax	#, _56
	jmp	.L49	#
.L40:
# src/coefficient_loader.c:163:         for (int j = 0; j < 3; j++)
	movl	$0, -8(%rbp)	#, j
# src/coefficient_loader.c:163:         for (int j = 0; j < 3; j++)
	jmp	.L41	#
.L43:
# src/coefficient_loader.c:165:             if (fscanf(input, "%f", &num[j]) != 1)
	leaq	-36(%rbp), %rax	#, tmp159
	movl	-8(%rbp), %edx	# j, tmp161
	movslq	%edx, %rdx	# tmp161, tmp160
	salq	$2, %rdx	#, tmp162
	addq	%rax, %rdx	# tmp159, _7
	movq	-24(%rbp), %rax	# input, tmp163
	movl	$.LC3, %esi	#,
	movq	%rax, %rdi	# tmp163,
	movl	$0, %eax	#,
	call	__isoc23_fscanf	#
# src/coefficient_loader.c:165:             if (fscanf(input, "%f", &num[j]) != 1)
	cmpl	$1, %eax	#, _8
	je	.L42	#,
# src/coefficient_loader.c:167:                 fclose(input);
	movq	-24(%rbp), %rax	# input, tmp164
	movq	%rax, %rdi	# tmp164,
	call	fclose	#
# src/coefficient_loader.c:168:                 return -1;
	movl	$-1, %eax	#, _56
	jmp	.L49	#
.L42:
# src/coefficient_loader.c:163:         for (int j = 0; j < 3; j++)
	addl	$1, -8(%rbp)	#, j
.L41:
# src/coefficient_loader.c:163:         for (int j = 0; j < 3; j++)
	cmpl	$2, -8(%rbp)	#, j
	jle	.L43	#,
# src/coefficient_loader.c:173:         if (fscanf(input, "%s", label) != 1 || strcmp(label, "den") != 0)
	leaq	-112(%rbp), %rdx	#, tmp165
	movq	-24(%rbp), %rax	# input, tmp166
	movl	$.LC4, %esi	#,
	movq	%rax, %rdi	# tmp166,
	movl	$0, %eax	#,
	call	__isoc23_fscanf	#
# src/coefficient_loader.c:173:         if (fscanf(input, "%s", label) != 1 || strcmp(label, "den") != 0)
	cmpl	$1, %eax	#, _9
	jne	.L44	#,
# src/coefficient_loader.c:173:         if (fscanf(input, "%s", label) != 1 || strcmp(label, "den") != 0)
	leaq	-112(%rbp), %rax	#, tmp167
	movl	$.LC6, %esi	#,
	movq	%rax, %rdi	# tmp167,
	call	strcmp	#
# src/coefficient_loader.c:173:         if (fscanf(input, "%s", label) != 1 || strcmp(label, "den") != 0)
	testl	%eax, %eax	# _10
	je	.L45	#,
.L44:
# src/coefficient_loader.c:175:             fclose(input);
	movq	-24(%rbp), %rax	# input, tmp168
	movq	%rax, %rdi	# tmp168,
	call	fclose	#
# src/coefficient_loader.c:176:             return -1;
	movl	$-1, %eax	#, _56
	jmp	.L49	#
.L45:
# src/coefficient_loader.c:180:         for (int j = 0; j < 2; j++)
	movl	$0, -12(%rbp)	#, j
# src/coefficient_loader.c:180:         for (int j = 0; j < 2; j++)
	jmp	.L46	#
.L48:
# src/coefficient_loader.c:182:             if (fscanf(input, "%f", &den[j]) != 1)
	leaq	-44(%rbp), %rax	#, tmp169
	movl	-12(%rbp), %edx	# j, tmp171
	movslq	%edx, %rdx	# tmp171, tmp170
	salq	$2, %rdx	#, tmp172
	addq	%rax, %rdx	# tmp169, _11
	movq	-24(%rbp), %rax	# input, tmp173
	movl	$.LC3, %esi	#,
	movq	%rax, %rdi	# tmp173,
	movl	$0, %eax	#,
	call	__isoc23_fscanf	#
# src/coefficient_loader.c:182:             if (fscanf(input, "%f", &den[j]) != 1)
	cmpl	$1, %eax	#, _12
	je	.L47	#,
# src/coefficient_loader.c:184:                 fclose(input);
	movq	-24(%rbp), %rax	# input, tmp174
	movq	%rax, %rdi	# tmp174,
	call	fclose	#
# src/coefficient_loader.c:185:                 return -1;
	movl	$-1, %eax	#, _56
	jmp	.L49	#
.L47:
# src/coefficient_loader.c:180:         for (int j = 0; j < 2; j++)
	addl	$1, -12(%rbp)	#, j
.L46:
# src/coefficient_loader.c:180:         for (int j = 0; j < 2; j++)
	cmpl	$1, -12(%rbp)	#, j
	jle	.L48	#,
# src/coefficient_loader.c:189:         fclose(input);
	movq	-24(%rbp), %rax	# input, tmp175
	movq	%rax, %rdi	# tmp175,
	call	fclose	#
# src/coefficient_loader.c:192:         biquads[i].num_sf = convert_to_fixed(num, num_fixed, 3);
	leaq	-50(%rbp), %rcx	#, tmp176
	leaq	-36(%rbp), %rax	#, tmp177
	movl	$3, %edx	#,
	movq	%rcx, %rsi	# tmp176,
	movq	%rax, %rdi	# tmp177,
	call	convert_to_fixed	#
	movl	%eax, %ecx	#, _13
# src/coefficient_loader.c:192:         biquads[i].num_sf = convert_to_fixed(num, num_fixed, 3);
	movl	-4(%rbp), %eax	# i, tmp178
	movslq	%eax, %rdx	# tmp178, _14
	movq	%rdx, %rax	# _14, _15
	addq	%rax, %rax	# _15
	addq	%rdx, %rax	# _14, _15
	salq	$2, %rax	#, tmp180
	movq	%rax, %rdx	# _15, _15
	movq	-128(%rbp), %rax	# biquads, tmp181
	addq	%rdx, %rax	# _15, _16
# src/coefficient_loader.c:192:         biquads[i].num_sf = convert_to_fixed(num, num_fixed, 3);
	movl	%ecx, %edx	# _13, _17
# src/coefficient_loader.c:192:         biquads[i].num_sf = convert_to_fixed(num, num_fixed, 3);
	movb	%dl, 10(%rax)	# _17, _16->num_sf
# src/coefficient_loader.c:193:         biquads[i].den_sf = convert_to_fixed(den, den_fixed, 2);
	leaq	-54(%rbp), %rcx	#, tmp182
	leaq	-44(%rbp), %rax	#, tmp183
	movl	$2, %edx	#,
	movq	%rcx, %rsi	# tmp182,
	movq	%rax, %rdi	# tmp183,
	call	convert_to_fixed	#
	movl	%eax, %ecx	#, _18
# src/coefficient_loader.c:193:         biquads[i].den_sf = convert_to_fixed(den, den_fixed, 2);
	movl	-4(%rbp), %eax	# i, tmp184
	movslq	%eax, %rdx	# tmp184, _19
	movq	%rdx, %rax	# _19, _20
	addq	%rax, %rax	# _20
	addq	%rdx, %rax	# _19, _20
	salq	$2, %rax	#, tmp186
	movq	%rax, %rdx	# _20, _20
	movq	-128(%rbp), %rax	# biquads, tmp187
	addq	%rdx, %rax	# _20, _21
# src/coefficient_loader.c:193:         biquads[i].den_sf = convert_to_fixed(den, den_fixed, 2);
	movl	%ecx, %edx	# _18, _22
# src/coefficient_loader.c:193:         biquads[i].den_sf = convert_to_fixed(den, den_fixed, 2);
	movb	%dl, 11(%rax)	# _22, _21->den_sf
# src/coefficient_loader.c:196:                biquads[i].den_sf);
	movl	-4(%rbp), %eax	# i, tmp188
	movslq	%eax, %rdx	# tmp188, _23
	movq	%rdx, %rax	# _23, _24
	addq	%rax, %rax	# _24
	addq	%rdx, %rax	# _23, _24
	salq	$2, %rax	#, tmp190
	movq	%rax, %rdx	# _24, _24
	movq	-128(%rbp), %rax	# biquads, tmp191
	addq	%rdx, %rax	# _24, _25
# src/coefficient_loader.c:196:                biquads[i].den_sf);
	movzbl	11(%rax), %eax	# _25->den_sf, _26
# src/coefficient_loader.c:195:         printf("here: num sf %d, den_sf %d\n", biquads[i].num_sf,
	movzbl	%al, %ecx	# _26, _27
# src/coefficient_loader.c:195:         printf("here: num sf %d, den_sf %d\n", biquads[i].num_sf,
	movl	-4(%rbp), %eax	# i, tmp192
	movslq	%eax, %rdx	# tmp192, _28
	movq	%rdx, %rax	# _28, _29
	addq	%rax, %rax	# _29
	addq	%rdx, %rax	# _28, _29
	salq	$2, %rax	#, tmp194
	movq	%rax, %rdx	# _29, _29
	movq	-128(%rbp), %rax	# biquads, tmp195
	addq	%rdx, %rax	# _29, _30
# src/coefficient_loader.c:195:         printf("here: num sf %d, den_sf %d\n", biquads[i].num_sf,
	movzbl	10(%rax), %eax	# _30->num_sf, _31
# src/coefficient_loader.c:195:         printf("here: num sf %d, den_sf %d\n", biquads[i].num_sf,
	movzbl	%al, %eax	# _31, _32
	movl	%ecx, %edx	# _27,
	movl	%eax, %esi	# _32,
	movl	$.LC7, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/coefficient_loader.c:197:         biquads[i].b0 = num_fixed[0];
	movl	-4(%rbp), %eax	# i, tmp196
	movslq	%eax, %rdx	# tmp196, _33
	movq	%rdx, %rax	# _33, _34
	addq	%rax, %rax	# _34
	addq	%rdx, %rax	# _33, _34
	salq	$2, %rax	#, tmp198
	movq	%rax, %rdx	# _34, _34
	movq	-128(%rbp), %rax	# biquads, tmp199
	addq	%rax, %rdx	# tmp199, _35
# src/coefficient_loader.c:197:         biquads[i].b0 = num_fixed[0];
	movzwl	-50(%rbp), %eax	# num_fixed[0], _36
# src/coefficient_loader.c:197:         biquads[i].b0 = num_fixed[0];
	movw	%ax, (%rdx)	# _36, _35->b0
# src/coefficient_loader.c:198:         biquads[i].b1 = num_fixed[1];
	movl	-4(%rbp), %eax	# i, tmp200
	movslq	%eax, %rdx	# tmp200, _37
	movq	%rdx, %rax	# _37, _38
	addq	%rax, %rax	# _38
	addq	%rdx, %rax	# _37, _38
	salq	$2, %rax	#, tmp202
	movq	%rax, %rdx	# _38, _38
	movq	-128(%rbp), %rax	# biquads, tmp203
	addq	%rax, %rdx	# tmp203, _39
# src/coefficient_loader.c:198:         biquads[i].b1 = num_fixed[1];
	movzwl	-48(%rbp), %eax	# num_fixed[1], _40
# src/coefficient_loader.c:198:         biquads[i].b1 = num_fixed[1];
	movw	%ax, 2(%rdx)	# _40, _39->b1
# src/coefficient_loader.c:199:         biquads[i].b2 = num_fixed[2];
	movl	-4(%rbp), %eax	# i, tmp204
	movslq	%eax, %rdx	# tmp204, _41
	movq	%rdx, %rax	# _41, _42
	addq	%rax, %rax	# _42
	addq	%rdx, %rax	# _41, _42
	salq	$2, %rax	#, tmp206
	movq	%rax, %rdx	# _42, _42
	movq	-128(%rbp), %rax	# biquads, tmp207
	addq	%rax, %rdx	# tmp207, _43
# src/coefficient_loader.c:199:         biquads[i].b2 = num_fixed[2];
	movzwl	-46(%rbp), %eax	# num_fixed[2], _44
# src/coefficient_loader.c:199:         biquads[i].b2 = num_fixed[2];
	movw	%ax, 4(%rdx)	# _44, _43->b2
# src/coefficient_loader.c:201:         biquads[i].a1 = den_fixed[0];
	movl	-4(%rbp), %eax	# i, tmp208
	movslq	%eax, %rdx	# tmp208, _45
	movq	%rdx, %rax	# _45, _46
	addq	%rax, %rax	# _46
	addq	%rdx, %rax	# _45, _46
	salq	$2, %rax	#, tmp210
	movq	%rax, %rdx	# _46, _46
	movq	-128(%rbp), %rax	# biquads, tmp211
	addq	%rax, %rdx	# tmp211, _47
# src/coefficient_loader.c:201:         biquads[i].a1 = den_fixed[0];
	movzwl	-54(%rbp), %eax	# den_fixed[0], _48
# src/coefficient_loader.c:201:         biquads[i].a1 = den_fixed[0];
	movw	%ax, 6(%rdx)	# _48, _47->a1
# src/coefficient_loader.c:202:         biquads[i].a2 = den_fixed[1];
	movl	-4(%rbp), %eax	# i, tmp212
	movslq	%eax, %rdx	# tmp212, _49
	movq	%rdx, %rax	# _49, _50
	addq	%rax, %rax	# _50
	addq	%rdx, %rax	# _49, _50
	salq	$2, %rax	#, tmp214
	movq	%rax, %rdx	# _50, _50
	movq	-128(%rbp), %rax	# biquads, tmp215
	addq	%rax, %rdx	# tmp215, _51
# src/coefficient_loader.c:202:         biquads[i].a2 = den_fixed[1];
	movzwl	-52(%rbp), %eax	# den_fixed[1], _52
# src/coefficient_loader.c:202:         biquads[i].a2 = den_fixed[1];
	movw	%ax, 8(%rdx)	# _52, _51->a2
# src/coefficient_loader.c:139:     for (int i = 0; i < num_biquads; i++)
	addl	$1, -4(%rbp)	#, i
.L36:
# src/coefficient_loader.c:139:     for (int i = 0; i < num_biquads; i++)
	movl	-4(%rbp), %eax	# i, tmp216
	cmpl	-132(%rbp), %eax	# num_biquads, tmp216
	jl	.L50	#,
# src/coefficient_loader.c:205:     return num_biquads;
	movl	-132(%rbp), %eax	# num_biquads, _56
.L49:
# src/coefficient_loader.c:206: }
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE2:
	.size	load_biquad_fixed, .-load_biquad_fixed
	.ident	"GCC: (GNU) 16.1.1 20260515 (Red Hat 16.1.1-2)"
	.section	.note.GNU-stack,"",@progbits
