	.file	"unix2dos.c"
	.text
	.globl	Unix2dos_create
	.type	Unix2dos_create, @function
Unix2dos_create:
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
	.size	Unix2dos_create, .-Unix2dos_create
	.globl	Unix2dos_start
	.type	Unix2dos_start, @function
Unix2dos_start:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	fgetc
	movl	%eax, -4(%rbp)
	jmp	.L8
.L11:
	cmpl	$10, -4(%rbp)
	jne	.L9
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, %rsi
	movl	$13, %edi
	call	fputc
	movq	-24(%rbp), %rax
	movq	8(%rax), %rdx
	movl	-4(%rbp), %eax
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	fputc
	jmp	.L10
.L9:
	movq	-24(%rbp), %rax
	movq	8(%rax), %rdx
	movl	-4(%rbp), %eax
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	fputc
.L10:
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	fgetc
	movl	%eax, -4(%rbp)
.L8:
	cmpl	$-1, -4(%rbp)
	jne	.L11
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	Unix2dos_start, .-Unix2dos_start
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
