	.file	"main_unix2dos.c"
	.section	.rodata
.LC0:
	.string	""
.LC1:
	.string	"-"
	.align 8
.LC2:
	.string	"Input and output ought to be different\n"
.LC3:
	.string	"rb"
.LC4:
	.string	"Can not open input file '%s'\n"
.LC5:
	.string	"wt"
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
.LFB2:
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
	movq	$.LC0, -448(%rbp)
	movq	$.LC0, -440(%rbp)
	movl	$0, -472(%rbp)
	jmp	.L2
.L11:
	movl	-468(%rbp), %eax
	cmpl	$105, %eax
	je	.L4
	cmpl	$111, %eax
	je	.L5
	jmp	.L16
.L4:
	movq	optarg(%rip), %rax
	movl	$.LC1, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	je	.L2
	movq	optarg(%rip), %rax
	movq	-440(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L7
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$39, %edx
	movl	$1, %esi
	movl	$.LC2, %edi
	call	fwrite
	movl	$1, %eax
	jmp	.L14
.L7:
	movq	optarg(%rip), %rax
	movq	%rax, -448(%rbp)
	movq	-448(%rbp), %rax
	movl	$.LC3, %esi
	movq	%rax, %rdi
	call	fopen
	movq	%rax, -464(%rbp)
	cmpq	$0, -464(%rbp)
	jne	.L2
	movq	optarg(%rip), %rdx
	movq	stderr(%rip), %rax
	movl	$.LC4, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	movl	$1, %eax
	jmp	.L14
.L5:
	movq	optarg(%rip), %rax
	movl	$.LC1, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	je	.L2
	movq	optarg(%rip), %rax
	movq	-448(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L10
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$39, %edx
	movl	$1, %esi
	movl	$.LC2, %edi
	call	fwrite
	movl	$1, %eax
	jmp	.L14
.L10:
	movq	optarg(%rip), %rax
	movq	%rax, -440(%rbp)
	movq	-440(%rbp), %rax
	movl	$.LC5, %esi
	movq	%rax, %rdi
	call	fopen
	movq	%rax, -456(%rbp)
	cmpq	$0, -456(%rbp)
	jne	.L2
	movq	optarg(%rip), %rdx
	movq	stderr(%rip), %rax
	movl	$.LC6, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	movl	$1, %eax
	jmp	.L14
.L16:
	movq	stderr(%rip), %rax
	movl	-468(%rbp), %edx
	movl	$.LC7, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	movl	$1, %eax
	jmp	.L14
.L2:
	leaq	-472(%rbp), %rdx
	movq	-496(%rbp), %rsi
	movl	-484(%rbp), %eax
	movq	%rdx, %r8
	movl	$long_options.3629, %ecx
	movl	$.LC8, %edx
	movl	%eax, %edi
	call	getopt_long
	movl	%eax, -468(%rbp)
	cmpl	$-1, -468(%rbp)
	jne	.L11
	movq	-456(%rbp), %rdx
	movq	-464(%rbp), %rcx
	leaq	-432(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	Unix2dos_create
	leaq	-432(%rbp), %rax
	movq	%rax, %rdi
	call	Unix2dos_start
	cmpq	$0, -464(%rbp)
	je	.L12
	movq	-464(%rbp), %rax
	movq	%rax, %rdi
	call	fclose
.L12:
	cmpq	$0, -456(%rbp)
	je	.L13
	movq	-456(%rbp), %rax
	movq	%rax, %rdi
	call	fclose
.L13:
	movl	$0, %eax
.L14:
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L15
	call	__stack_chk_fail
.L15:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	main, .-main
	.section	.rodata
.LC9:
	.string	"input"
.LC10:
	.string	"output"
	.data
	.align 32
	.type	long_options.3629, @object
	.size	long_options.3629, 96
long_options.3629:
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
