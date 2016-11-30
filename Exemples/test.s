.data

.string_3:
	.asciz "%d"
	.align 8
.string_1:
	.asciz "2"
	.align 8
.string_2:
	.asciz "3"
	.align 8




.text

.globl main
 main:
	pushq %rbx	# saving callee-saved registers
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	pushq %rbp	# base pointer
	movq %rsp, %rbp
	subq $32, %rsp
	subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq $8, %rax
	pushq %rax
	movq $3, %rax
	popq %rcx
	imulq %rcx, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	xorq %rax, %rax
	callq malloc
	popq %r10	# retrieve caller-saved registers
	popq %r11
	addq $8, %rsp	# to restore the stack alignment
	movq %rax, -8(%rbp)
	movq $1, %rax
	pushq %rax
	movq $0, %rax
	popq %rcx
	movq -8(%rbp), %rdx
	movq %rcx, (%rdx, %rax, 8)
	movq %rcx, %rax
	movq $2, %rax
	pushq %rax
	movq $1, %rax
	popq %rcx
	movq -8(%rbp), %rdx
	movq %rcx, (%rdx, %rax, 8)
	movq %rcx, %rax
	movq $3, %rax
	pushq %rax
	movq $2, %rax
	popq %rcx
	movq -8(%rbp), %rdx
	movq %rcx, (%rdx, %rax, 8)
	movq %rcx, %rax
	subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq $.string_2, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	xorq %rax, %rax
	callq printf
	cltq
	popq %r10	# retrieve caller-saved registers
	popq %r11
	addq $8, %rsp	# to restore the stack alignment
	movq $0, %rax
	pushq %rax
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq $.string_1, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	xorq %rax, %rax
	callq printf
	cltq
	popq %r10	# retrieve caller-saved registers
	popq %r11
	movq $0, %rax
	popq %rcx
	movq -8(%rbp), %rdx
	movq %rcx, (%rdx, %rax, 8)
	movq %rcx, %rax
	movq $0, %rax
	pushq %rax
	movq -8(%rbp), %rax
	popq %rcx
	movq $0, %rax
	movq %rax, %rcx
	movq -8(%rbp), %rdx
	movq (%rdx, %rcx, 8), %rax
	pushq %rax	# the value of expr is stored in for later
	inc %rax
	pushq %rax
	movq $0, %rax
	popq %rcx
	movq -8(%rbp), %rdx
	movq %rcx, (%rdx, %rax, 8)
	movq %rcx, %rax
	popq %rax
	pushq %rax
	movq -8(%rbp), %rax
	popq %rcx
	movq $0, %rax
	pushq %rax
	movq -8(%rbp), %rax
	popq %rcx
	movq $0, %rax
	movq %rax, %rcx
	movq -8(%rbp), %rdx
	movq (%rdx, %rcx, 8), %rax
	pushq %rax	# the value of expr is stored in for later
	inc %rax
	pushq %rax
	movq $0, %rax
	popq %rcx
	movq -8(%rbp), %rdx
	movq %rcx, (%rdx, %rax, 8)
	movq %rcx, %rax
	popq %rax
	movq %rax, %rcx
	movq -8(%rbp), %rdx
	movq (%rdx, %rcx, 8), %rax
	pushq %rax	# the value of expr is stored in for later
	inc %rax
	pushq %rax
	movq $0, %rax
	pushq %rax
	movq -8(%rbp), %rax
	popq %rcx
	movq $0, %rax
	movq %rax, %rcx
	movq -8(%rbp), %rdx
	movq (%rdx, %rcx, 8), %rax
	pushq %rax	# the value of expr is stored in for later
	inc %rax
	pushq %rax
	movq $0, %rax
	popq %rcx
	movq -8(%rbp), %rdx
	movq %rcx, (%rdx, %rax, 8)
	movq %rcx, %rax
	popq %rax
	popq %rcx
	movq -8(%rbp), %rdx
	movq %rcx, (%rdx, %rax, 8)
	movq %rcx, %rax
	popq %rax
	subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq $3, %rax
	movq %rax, -32(%rbp)
	movq %rax, -24(%rbp)
	pushq %rax	# putting argument number 2 on the stack
	movq $.string_3, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	popq %rsi	# putting argument number 2 in register
	xorq %rax, %rax
	callq printf
	cltq
	popq %r10	# retrieve caller-saved registers
	popq %r11
	addq $8, %rsp	# to restore the stack alignment
	movq $0, %rax
	jmp .main_endFunction_4 	# return reached : end function
	addq $32, %rsp
.main_endFunction_4:
	movq %rbp, %rsp
	popq %rbp
	popq %r15	# restoring callee-saved registers
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	retq
