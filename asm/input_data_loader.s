	.file	"input_data_loader.c"
# GNU C23 (GCC) version 16.1.1 20260515 (Red Hat 16.1.1-2) (x86_64-redhat-linux)
#	compiled by GNU C version 16.1.1 20260515 (Red Hat 16.1.1-2), GMP version 6.3.0, MPFR version 4.2.2, MPC version 1.4.1, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mtune=generic -march=x86-64 -mtls-dialect=gnu2
	.text
	.section	.rodata
.LC0:
	.string	"r"
.LC1:
	.string	"failed to load input"
.LC3:
	.string	"%f"
	.text
	.globl	load_accelerometer_data_fixed
	.type	load_accelerometer_data_fixed, @function
load_accelerometer_data_fixed:
.LFB0:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$1200064, %rsp	#,
	movq	%rdi, -1200040(%rbp)	# input_file, input_file
	movq	%rsi, -1200048(%rbp)	# input_data, input_data
	movl	%edx, -1200052(%rbp)	# buffer_size, buffer_size
# src/input_data_loader.c:14:     FILE *input = fopen(input_file, "r");
	movq	-1200040(%rbp), %rax	# input_file, tmp106
	movl	$.LC0, %esi	#,
	movq	%rax, %rdi	# tmp106,
	call	fopen	#
	movq	%rax, -16(%rbp)	# tmp107, input
# src/input_data_loader.c:15:     float temp[MAX_SAMPLES] = {};
	leaq	-1200016(%rbp), %rax	#, tmp108
	movl	$1200000, %edx	#, tmp109
	movl	$0, %esi	#,
	movq	%rax, %rdi	# tmp108,
	call	memset	#
# src/input_data_loader.c:16:     if (!input)
	cmpq	$0, -16(%rbp)	#, input
	jne	.L2	#,
# src/input_data_loader.c:18:         printf("failed to load input");
	movl	$.LC1, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/input_data_loader.c:19:         return -1;  // invalid file path
	movl	$-1, %eax	#, _8
	jmp	.L7	#
.L2:
# src/input_data_loader.c:22:     int i = 0;
	movl	$0, -4(%rbp)	#, i
# src/input_data_loader.c:23:     float sample = 0.f;
	pxor	%xmm0, %xmm0	# tmp112
	movss	%xmm0, -1200020(%rbp)	# tmp112, sample
# src/input_data_loader.c:24:     while (fscanf(input, "%f", &sample) == 1)
	jmp	.L4	#
.L6:
# src/input_data_loader.c:26:         if (i >= (int)buffer_size)
	movl	-1200052(%rbp), %eax	# buffer_size, buffer_size.0_1
# src/input_data_loader.c:26:         if (i >= (int)buffer_size)
	cmpl	%eax, -4(%rbp)	# buffer_size.0_1, i
	jl	.L5	#,
# src/input_data_loader.c:28:             return -1;  // indicate buffer overflow error status
	movl	$-1, %eax	#, _8
	jmp	.L7	#
.L5:
# src/input_data_loader.c:30:         temp[i] = sample;
	movss	-1200020(%rbp), %xmm0	# sample, sample.1_2
	movl	-4(%rbp), %eax	# i, tmp114
	cltq
	movss	%xmm0, -1200016(%rbp,%rax,4)	# sample.1_2, temp[i_7]
# src/input_data_loader.c:31:         i++;
	addl	$1, -4(%rbp)	#, i
.L4:
# src/input_data_loader.c:24:     while (fscanf(input, "%f", &sample) == 1)
	leaq	-1200020(%rbp), %rdx	#, tmp115
	movq	-16(%rbp), %rax	# input, tmp116
	movl	$.LC3, %esi	#,
	movq	%rax, %rdi	# tmp116,
	movl	$0, %eax	#,
	call	__isoc23_fscanf	#
# src/input_data_loader.c:24:     while (fscanf(input, "%f", &sample) == 1)
	cmpl	$1, %eax	#, _3
	je	.L6	#,
# src/input_data_loader.c:34:         convert_to_fixed(temp, input_data->input_data_buffer, i, pow(2, 15));
	movl	-4(%rbp), %edx	# i, i.2_4
# src/input_data_loader.c:34:         convert_to_fixed(temp, input_data->input_data_buffer, i, pow(2, 15));
	movq	-1200048(%rbp), %rsi	# input_data, _5
# src/input_data_loader.c:34:         convert_to_fixed(temp, input_data->input_data_buffer, i, pow(2, 15));
	leaq	-1200016(%rbp), %rax	#, tmp117
	movl	$32768, %ecx	#,
	movq	%rax, %rdi	# tmp117,
	call	convert_to_fixed	#
# src/input_data_loader.c:33:     input_data->scale_factor_exp =
	movq	-1200048(%rbp), %rdx	# input_data, tmp118
	movb	%al, 600000(%rdx)	# _6, input_data_19(D)->scale_factor_exp
# src/input_data_loader.c:35:     fclose(input);
	movq	-16(%rbp), %rax	# input, tmp119
	movq	%rax, %rdi	# tmp119,
	call	fclose	#
# src/input_data_loader.c:36:     return i;
	movl	-4(%rbp), %eax	# i, _8
.L7:
# src/input_data_loader.c:37: }
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE0:
	.size	load_accelerometer_data_fixed, .-load_accelerometer_data_fixed
	.globl	load_accelerometer_data_float
	.type	load_accelerometer_data_float, @function
load_accelerometer_data_float:
.LFB1:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$64, %rsp	#,
	movq	%rdi, -40(%rbp)	# input_file, input_file
	movq	%rsi, -48(%rbp)	# input_data, input_data
	movl	%edx, -52(%rbp)	# buffer_size, buffer_size
# src/input_data_loader.c:43:     FILE *input = fopen(input_file, "r");
	movq	-40(%rbp), %rax	# input_file, tmp106
	movl	$.LC0, %esi	#,
	movq	%rax, %rdi	# tmp106,
	call	fopen	#
	movq	%rax, -16(%rbp)	# tmp107, input
# src/input_data_loader.c:44:     if (!input)
	cmpq	$0, -16(%rbp)	#, input
	jne	.L9	#,
# src/input_data_loader.c:46:         printf("failed to load input");
	movl	$.LC1, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
# src/input_data_loader.c:47:         return -1;  // invalid file path
	movl	$-1, %eax	#, _8
	jmp	.L14	#
.L9:
# src/input_data_loader.c:50:     int i = 0;
	movl	$0, -4(%rbp)	#, i
# src/input_data_loader.c:51:     float sample = 0.f;
	pxor	%xmm0, %xmm0	# tmp108
	movss	%xmm0, -20(%rbp)	# tmp108, sample
# src/input_data_loader.c:52:     while (fscanf(input, "%f", &sample) == 1)
	jmp	.L11	#
.L13:
# src/input_data_loader.c:54:         if (i >= (int)buffer_size)
	movl	-52(%rbp), %eax	# buffer_size, buffer_size.3_1
# src/input_data_loader.c:54:         if (i >= (int)buffer_size)
	cmpl	%eax, -4(%rbp)	# buffer_size.3_1, i
	jl	.L12	#,
# src/input_data_loader.c:56:             return -1;  // indicate buffer overflow error status
	movl	$-1, %eax	#, _8
	jmp	.L14	#
.L12:
# src/input_data_loader.c:58:         input_data[i] = sample;
	movl	-4(%rbp), %eax	# i, tmp109
	cltq
	leaq	0(,%rax,4), %rdx	#, _3
	movq	-48(%rbp), %rax	# input_data, tmp110
	addq	%rdx, %rax	# _3, _4
# src/input_data_loader.c:58:         input_data[i] = sample;
	movss	-20(%rbp), %xmm0	# sample, sample.4_5
	movss	%xmm0, (%rax)	# sample.4_5, *_4
# src/input_data_loader.c:59:         i++;
	addl	$1, -4(%rbp)	#, i
.L11:
# src/input_data_loader.c:52:     while (fscanf(input, "%f", &sample) == 1)
	leaq	-20(%rbp), %rdx	#, tmp111
	movq	-16(%rbp), %rax	# input, tmp112
	movl	$.LC3, %esi	#,
	movq	%rax, %rdi	# tmp112,
	movl	$0, %eax	#,
	call	__isoc23_fscanf	#
# src/input_data_loader.c:52:     while (fscanf(input, "%f", &sample) == 1)
	cmpl	$1, %eax	#, _6
	je	.L13	#,
# src/input_data_loader.c:61:     fclose(input);
	movq	-16(%rbp), %rax	# input, tmp113
	movq	%rax, %rdi	# tmp113,
	call	fclose	#
# src/input_data_loader.c:62:     return i;
	movl	-4(%rbp), %eax	# i, _8
.L14:
# src/input_data_loader.c:63: }
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE1:
	.size	load_accelerometer_data_float, .-load_accelerometer_data_float
	.ident	"GCC: (GNU) 16.1.1 20260515 (Red Hat 16.1.1-2)"
	.section	.note.GNU-stack,"",@progbits
