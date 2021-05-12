	.file	"jastime.c"
	.text
	.p2align 4
	.globl	after_continuation_func
	.type	after_continuation_func, @function
after_continuation_func:
.LFB56:
	.cfi_startproc
	endbr64
	movq	8(%rsi), %r8
	movq	(%rsi), %rax
	movq	%r8, %rsi
	jmp	*%rax
	.cfi_endproc
.LFE56:
	.size	after_continuation_func, .-after_continuation_func
	.p2align 4
	.globl	every_continuation_func
	.type	every_continuation_func, @function
every_continuation_func:
.LFB58:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movl	%edx, %r12d
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rsi, %rbx
	subq	$40, %rsp
	.cfi_def_cfa_offset 64
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	andl	$1, %edx
	jne	.L12
.L4:
	movq	8(%rbx), %rsi
	movl	%r12d, %edx
	call	*(%rbx)
.L3:
	movq	24(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L13
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L12:
	.cfi_restore_state
	leaq	16(%rsp), %rsi
	movl	$8, %edx
	movl	%edi, 12(%rsp)
	call	read@PLT
	movl	12(%rsp), %edi
	cmpl	$8, %eax
	je	.L4
	movq	8(%rbx), %rsi
	movl	$8, %edx
	call	*(%rbx)
	jmp	.L3
.L13:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE58:
	.size	every_continuation_func, .-every_continuation_func
	.p2align 4
	.globl	jastime_after
	.type	jastime_after, @function
jastime_after:
.LFB57:
	.cfi_startproc
	endbr64
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pxor	%xmm0, %xmm0
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movq	%rcx, %r13
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	movq	%rdx, %r12
	movabsq	$4835703278458516699, %rdx
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movq	%rdi, %rbp
	movl	$1, %edi
	subq	$56, %rsp
	.cfi_def_cfa_offset 96
	movq	%fs:40, %rax
	movq	%rax, 40(%rsp)
	xorl	%eax, %eax
	movq	%rsi, %rax
	movaps	%xmm0, (%rsp)
	imulq	%rdx
	movq	%rsi, %rax
	sarq	$63, %rax
	sarq	$18, %rdx
	subq	%rax, %rdx
	imulq	$1000000, %rdx, %rax
	movq	%rdx, 16(%rsp)
	subq	%rax, %rsi
	movq	%rsi, 24(%rsp)
	movl	$2048, %esi
	call	timerfd_create@PLT
	xorl	%ecx, %ecx
	xorl	%esi, %esi
	movq	%rsp, %rdx
	movl	%eax, %edi
	movl	%eax, %r14d
	call	timerfd_settime@PLT
	movl	$8, %edi
	call	malloc@PLT
	movl	$1, %edx
	movl	%r14d, %esi
	movq	%rbp, %rdi
	movq	%r12, (%rax)
	movq	%rax, %r8
	leaq	after_continuation_func(%rip), %rcx
	movq	%r13, 8(%rax)
	call	jasio_add@PLT
	movq	40(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L17
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
.L17:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE57:
	.size	jastime_after, .-jastime_after
	.p2align 4
	.globl	jastime_every_after
	.type	jastime_every_after, @function
jastime_every_after:
.LFB59:
	.cfi_startproc
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movq	%r8, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rdi, %rbp
	movq	%rdx, %rdi
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rcx, %rbx
	movabsq	$4835703278458516699, %rcx
	subq	$56, %rsp
	.cfi_def_cfa_offset 96
	movq	%fs:40, %rax
	movq	%rax, 40(%rsp)
	xorl	%eax, %eax
	movq	%rsi, %rax
	imulq	%rcx
	movq	%rsi, %rax
	sarq	$63, %rax
	sarq	$18, %rdx
	subq	%rax, %rdx
	imulq	$1000000, %rdx, %rax
	movq	%rdx, 16(%rsp)
	subq	%rax, %rsi
	movq	%rdi, %rax
	imulq	%rcx
	movq	%rdi, %rax
	movq	%rsi, 24(%rsp)
	movl	$2048, %esi
	sarq	$63, %rax
	sarq	$18, %rdx
	subq	%rax, %rdx
	imulq	$1000000, %rdx, %rax
	movq	%rdx, (%rsp)
	subq	%rax, %rdi
	movq	%rdi, 8(%rsp)
	movl	$1, %edi
	call	timerfd_create@PLT
	xorl	%ecx, %ecx
	xorl	%esi, %esi
	movq	%rsp, %rdx
	movl	%eax, %edi
	movl	%eax, %r13d
	call	timerfd_settime@PLT
	movl	$8, %edi
	call	malloc@PLT
	movl	$1, %edx
	movl	%r13d, %esi
	movq	%rbp, %rdi
	movq	%rbx, (%rax)
	movq	%rax, %r8
	leaq	every_continuation_func(%rip), %rcx
	movq	%r12, 8(%rax)
	call	jasio_add@PLT
	movq	40(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L21
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
.L21:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE59:
	.size	jastime_every_after, .-jastime_every_after
	.p2align 4
	.globl	jastime_every
	.type	jastime_every, @function
jastime_every:
.LFB60:
	.cfi_startproc
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movq	%rdx, %r12
	movabsq	$4835703278458516699, %rdx
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rdi, %rbp
	movl	$1, %edi
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rcx, %rbx
	subq	$56, %rsp
	.cfi_def_cfa_offset 96
	movdqa	.LC0(%rip), %xmm0
	movq	%fs:40, %rax
	movq	%rax, 40(%rsp)
	xorl	%eax, %eax
	movq	%rsi, %rax
	imulq	%rdx
	movq	%rsi, %rax
	movaps	%xmm0, 16(%rsp)
	sarq	$63, %rax
	sarq	$18, %rdx
	subq	%rax, %rdx
	imulq	$1000000, %rdx, %rax
	movq	%rdx, (%rsp)
	subq	%rax, %rsi
	movq	%rsi, 8(%rsp)
	movl	$2048, %esi
	call	timerfd_create@PLT
	xorl	%ecx, %ecx
	xorl	%esi, %esi
	movq	%rsp, %rdx
	movl	%eax, %edi
	movl	%eax, %r13d
	call	timerfd_settime@PLT
	movl	$8, %edi
	call	malloc@PLT
	movl	$1, %edx
	movl	%r13d, %esi
	movq	%rbp, %rdi
	movq	%r12, (%rax)
	movq	%rax, %r8
	leaq	every_continuation_func(%rip), %rcx
	movq	%rbx, 8(%rax)
	call	jasio_add@PLT
	movq	40(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L25
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
.L25:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE60:
	.size	jastime_every, .-jastime_every
	.p2align 4
	.globl	jastime_remove
	.type	jastime_remove, @function
jastime_remove:
.LFB61:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rdi, %r12
	movl	%esi, %edi
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movl	%esi, %ebp
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	call	close@PLT
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	movl	%ebp, %esi
	movq	%r12, %rdi
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	jasio_remove@PLT
	.cfi_endproc
.LFE61:
	.size	jastime_remove, .-jastime_remove
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC0:
	.quad	0
	.quad	1
	.ident	"GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
