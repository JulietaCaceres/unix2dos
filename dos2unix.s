	.file	"dos2unix.c"
	.text
	.globl	Dos2unix_create
	.type	Dos2unix_create, @function
Dos2unix_create:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	cmpq	$0, -16(%rbp)
	je	.L2
	movq	-8(%rbp), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, (%rax)
	jmp	.L3
.L2:
	movq	stdin(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, (%rax)
.L3:
	cmpq	$0, -24(%rbp)
	je	.L4
	movq	-8(%rbp), %rax
	movq	-24(%rbp), %rdx
	movq	%rdx, 8(%rax)
	jmp	.L5
.L4:
	movq	stdout(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, 8(%rax)
.L5:
	movl	$0, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	Dos2unix_create, .-Dos2unix_create
	.globl	Dos2unix_start
	.type	Dos2unix_start, @function
Dos2unix_start:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	$0, -4(%rbp)
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	fgetc
	movl	%eax, -8(%rbp)
	jmp	.L8
.L15:
	cmpl	$1, -4(%rbp)
	jne	.L9
	cmpl	$13, -8(%rbp)
	jne	.L10
	movl	$1, -4(%rbp)
	jmp	.L11
.L10:
	cmpl	$10, -8(%rbp)
	jne	.L12
	movl	$0, -4(%rbp)
	jmp	.L11
.L12:
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, %rsi
	movl	$13, %edi
	call	fputc
	movl	$0, -4(%rbp)
.L11:
	movq	-24(%rbp), %rax
	movq	8(%rax), %rdx
	movl	-8(%rbp), %eax
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	fputc
	jmp	.L13
.L9:
	cmpl	$13, -8(%rbp)
	jne	.L14
	movl	$1, -4(%rbp)
	jmp	.L13
.L14:
	movq	-24(%rbp), %rax
	movq	8(%rax), %rdx
	movl	-8(%rbp), %eax
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	fputc
.L13:
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	fgetc
	movl	%eax, -8(%rbp)
.L8:
	cmpl	$-1, -8(%rbp)
	jne	.L15
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	Dos2unix_start, .-Dos2unix_start
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
