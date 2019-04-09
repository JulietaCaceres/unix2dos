	.file	"main_dos2unix.c"
	.section	.rodata
.LC0:
	.string	"rb"
	.text
	.globl	open_infile
	.type	open_infile, @function
open_infile:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movl	$.LC0, %esi
	movq	%rax, %rdi
	call	fopen
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	open_infile, .-open_infile
	.section	.rodata
.LC1:
	.string	"wt"
	.text
	.globl	open_outfile
	.type	open_outfile, @function
open_outfile:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movl	$.LC1, %esi
	movq	%rax, %rdi
	call	fopen
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	open_outfile, .-open_outfile
	.section	.rodata
.LC2:
	.string	""
.LC3:
	.string	"-"
	.align 8
.LC4:
	.string	"Input and output ought to be different\n"
.LC5:
	.string	"Can not open input file '%s'\n"
	.align 8
.LC6:
	.string	"Can not open output file '%s'\n"
.LC7:
	.string	"Unknown option '%c'\n"
.LC8:
	.string	"i:o:a:"
	.text
	.globl	main
	.type	main, @function
main:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$496, %rsp
	movl	%edi, -484(%rbp)
	movq	%rsi, -496(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	$0, -464(%rbp)
	movq	$0, -456(%rbp)
	movq	$.LC2, -448(%rbp)
	movq	$.LC2, -440(%rbp)
	movl	$0, -472(%rbp)
	jmp	.L6
.L15:
	movl	-468(%rbp), %eax
	cmpl	$105, %eax
	je	.L8
	cmpl	$111, %eax
	je	.L9
	jmp	.L20
.L8:
	movq	optarg(%rip), %rax
	movl	$.LC3, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	je	.L6
	movq	optarg(%rip), %rax
	movq	-440(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L11
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$39, %edx
	movl	$1, %esi
	movl	$.LC4, %edi
	call	fwrite
	movl	$1, %eax
	jmp	.L18
.L11:
	movq	optarg(%rip), %rax
	movq	%rax, -448(%rbp)
	movq	-448(%rbp), %rax
	movl	$.LC0, %esi
	movq	%rax, %rdi
	call	fopen
	movq	%rax, -464(%rbp)
	cmpq	$0, -464(%rbp)
	jne	.L6
	movq	optarg(%rip), %rdx
	movq	stderr(%rip), %rax
	movl	$.LC5, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	movl	$1, %eax
	jmp	.L18
.L9:
	movq	optarg(%rip), %rax
	movl	$.LC3, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	je	.L6
	movq	optarg(%rip), %rax
	movq	-448(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L14
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$39, %edx
	movl	$1, %esi
	movl	$.LC4, %edi
	call	fwrite
	movl	$1, %eax
	jmp	.L18
.L14:
	movq	optarg(%rip), %rax
	movq	%rax, -440(%rbp)
	movq	-440(%rbp), %rax
	movl	$.LC1, %esi
	movq	%rax, %rdi
	call	fopen
	movq	%rax, -456(%rbp)
	cmpq	$0, -456(%rbp)
	jne	.L6
	movq	optarg(%rip), %rdx
	movq	stderr(%rip), %rax
	movl	$.LC6, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	movl	$1, %eax
	jmp	.L18
.L20:
	movq	stderr(%rip), %rax
	movl	-468(%rbp), %edx
	movl	$.LC7, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	movl	$1, %eax
	jmp	.L18
.L6:
	leaq	-472(%rbp), %rdx
	movq	-496(%rbp), %rsi
	movl	-484(%rbp), %eax
	movq	%rdx, %r8
	movl	$long_options.3635, %ecx
	movl	$.LC8, %edx
	movl	%eax, %edi
	call	getopt_long
	movl	%eax, -468(%rbp)
	cmpl	$-1, -468(%rbp)
	jne	.L15
	movq	-456(%rbp), %rdx
	movq	-464(%rbp), %rcx
	leaq	-432(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	Dos2unix_create
	leaq	-432(%rbp), %rax
	movq	%rax, %rdi
	call	Dos2unix_start
	cmpq	$0, -464(%rbp)
	je	.L16
	movq	-464(%rbp), %rax
	movq	%rax, %rdi
	call	fclose
.L16:
	cmpq	$0, -456(%rbp)
	je	.L17
	movq	-456(%rbp), %rax
	movq	%rax, %rdi
	call	fclose
.L17:
	movl	$0, %eax
.L18:
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L19
	call	__stack_chk_fail
.L19:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	main, .-main
	.section	.rodata
.LC9:
	.string	"input"
.LC10:
	.string	"output"
	.data
	.align 32
	.type	long_options.3635, @object
	.size	long_options.3635, 96
long_options.3635:
	.quad	.LC9
	.long	2
	.zero	4
	.quad	0
	.long	105
	.zero	4
	.quad	.LC10
	.long	2
	.zero	4
	.quad	0
	.long	111
	.zero	4
	.quad	0
	.long	0
	.zero	4
	.quad	0
	.long	0
	.zero	4
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
