.data





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
	jmp .maintryBegin_3
.mainfinally_4:
	jmp .maintryContinue_2 	# end of finally reached 
.main_A_exception_5:
	subq $8, %rsp
	movq %rax, -8(%rbp)
	movq $1, %rax
	pushq %rax
	movq -8(%rbp), %rax
	popq %rcx
	addq %rcx, %rax
	jmp .mainfinally_4
	jmp .mainfinally_4
.maintryBegin_3:
	movq $2, %rax
	movq .main_A_exception_5, %rcx
	jmp .main_A_exception_5 	# exception thrown 
	jmp .mainfinally_4
.maintryContinue_2:
.main_endFunction_1:
	movq %rbp, %rsp
	popq %rbp
	popq %r15	# restoring callee-saved registers
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	retq
