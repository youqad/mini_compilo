.data

.string_1:
	.asciz ""
	.align 8
.string_3:
	.asciz "%d"
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
	jmp .maintryBegin_6
.main_A_exception_7:
	subq $8, %rsp
	movq %rax, -8(%rbp)
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq $1, %rax
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
	jmp .maintryContinue_5
.main_B_exception_8:
	subq $8, %rsp
	movq %rax, -8(%rbp)
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq $2, %rax
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
	jmp .maintryContinue_5
.maintryBegin_6:
	movq $.string_1, %rax
	movq .main_B_exception_8, %rcx
	jmp .main_B_exception_8 	# exception thrown 
.maintryContinue_5:
	jmp .main_endFunction_4 	# return reached : end function
.main_endFunction_4:
	movq %rbp, %rsp
	popq %rbp
	popq %r15	# restoring callee-saved registers
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	retq
