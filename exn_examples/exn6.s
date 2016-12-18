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
	subq $8, %rsp
	movq $0, %rax
	movq %rax, -8(%rbp)
	jmp .maintryBegin_3
.mainfinally_4:
	movq -8(%rbp), %rax
	pushq %rax	# the value of expr is stored in for later
	inc %rax
	movq %rax, -8(%rbp)
	popq %rax
	jmp .maintryContinue_2 	# end of finally reached 
.maintryBegin_3:
	movq $2, %rax
	movq .mainfinally_4, %rcx
	jmp .mainfinally_4 	# exception thrown 
	jmp .mainfinally_4
.maintryContinue_2:
	movq -8(%rbp), %rax
	jmp .main_endFunction_1 	# return reached : end function
	addq $8, %rsp
.main_endFunction_1:
	movq %rbp, %rsp
	popq %rbp
	popq %r15	# restoring callee-saved registers
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	retq
