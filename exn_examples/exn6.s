.data

.exception_1:
	.asciz "Z"
	.align 8


.comm .exception_not_caught_2,8,8


.text

	movq $0, .exception_not_caught_2
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
	jmp .maintryBegin_5
.mainfinally_6:
	movq -8(%rbp), %rax
	pushq %rax	# the value of expr is stored in for later
	inc %rax
	movq %rax, -8(%rbp)
	popq %rax
	jmp .maintryContinue_4 	# end of finally reached 
.maintryBegin_5:
	movq $1, .exception_not_caught_2
	movq $2, %rax
	movq $.exception_1, %rcx
	jmp .mainfinally_6 	# exception thrown 
	jmp .mainfinally_6
.maintryContinue_4:
	movq -8(%rbp), %rax
	jmp .main_endFunction_3 	# return reached : end function
	addq $8, %rsp
.main_endFunction_3:
	movq %rbp, %rsp
	popq %rbp
	popq %r15	# restoring callee-saved registers
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	retq
