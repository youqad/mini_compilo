.data

.exception_2:
	.asciz "A"
	.align 8


.comm .exception_not_caught_3,8,8


.text

	movq $0, .exception_not_caught_3
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
.mainfinally_7:
	movq $0, .exception_not_caught_3
	movq $2, %rax
	jmp .main_endFunction_4 	# return reached : end function
	jmp .maintryContinue_5 	# end of finally reached 
.main_A_exception_8:
	movq $0, .exception_not_caught_3
	subq $8, %rsp
	movq %rax, -8(%rbp)
	movq $1, %rax
	jmp .mainfinally_7
	jmp .main_endFunction_4 	# return reached : end function
	jmp .mainfinally_7
.maintryBegin_6:
	movq $0, .exception_not_caught_3
	movq $1, %rax
	movq $.exception_2, %rcx
	jmp .main_A_exception_8 	# exception thrown 
	jmp .mainfinally_7
.maintryContinue_5:
.main_endFunction_4:
	movq %rbp, %rsp
	popq %rbp
	popq %r15	# restoring callee-saved registers
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	retq
