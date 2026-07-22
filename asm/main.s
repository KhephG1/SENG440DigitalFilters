	.file	"main.c"
# GNU C23 (GCC) version 16.1.1 20260515 (Red Hat 16.1.1-2) (x86_64-redhat-linux)
#	compiled by GNU C version 16.1.1 20260515 (Red Hat 16.1.1-2), GMP version 6.3.0, MPFR version 4.2.2, MPC version 1.4.1, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mtune=generic -march=x86-64 -mtls-dialect=gnu2
	.text
	.globl	IIR_filter
	.bss
	.align 32
	.type	IIR_filter, @object
	.size	IIR_filter, 406
IIR_filter:
	.zero	406
	.globl	input
	.align 32
	.type	input, @object
	.size	input, 600002
input:
	.zero	600002
	.globl	input_data
	.align 32
	.type	input_data, @object
	.size	input_data, 1200000
input_data:
	.zero	1200000
	.globl	filter_y
	.align 32
	.type	filter_y, @object
	.size	filter_y, 400
filter_y:
	.zero	400
	.globl	filter_x
	.align 32
	.type	filter_x, @object
	.size	filter_x, 400
filter_x:
	.zero	400
	.globl	x_coeffs
	.align 4
	.type	x_coeffs, @object
	.size	x_coeffs, 4
x_coeffs:
	.zero	4
	.globl	y_coeffs
	.align 4
	.type	y_coeffs, @object
	.size	y_coeffs, 4
y_coeffs:
	.zero	4
	.section	.rodata
.LC0:
	.string	"test_output/filter_output.txt"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
# src/main.c:17:     test_iir_filter_float("test_output/filter_output.txt", input_data, filter_x,
	movl	$y_coeffs, %r9d	#,
	movl	$x_coeffs, %r8d	#,
	movl	$filter_y, %ecx	#,
	movl	$filter_x, %edx	#,
	movl	$input_data, %esi	#,
	movl	$.LC0, %edi	#,
	call	test_iir_filter_float	#
# src/main.c:19:     test_iir_filter_fixed("test_output/filter_output.txt", &input, &IIR_filter);
	movl	$IIR_filter, %edx	#,
	movl	$input, %esi	#,
	movl	$.LC0, %edi	#,
	call	test_iir_filter_fixed	#
# src/main.c:20:     test_iir_biquad_fixed("test_output/filter_output.txt", &input);
	movl	$input, %esi	#,
	movl	$.LC0, %edi	#,
	call	test_iir_biquad_fixed	#
# src/main.c:21:     return 0;
	movl	$0, %eax	#, _5
# src/main.c:22: }
	popq	%rbp	#
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (GNU) 16.1.1 20260515 (Red Hat 16.1.1-2)"
	.section	.note.GNU-stack,"",@progbits
