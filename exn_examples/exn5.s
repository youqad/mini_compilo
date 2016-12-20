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
	movq $0, %rax
	jmp .main_endFunction_1 	# return reached : end function
	jmp .maintryContinue_2 	# end of finally reached 
.maintryBegin_3:
	movq $2, %rax
	movq .mainfinally_4, %rcx
	jmp .mainfinally_4 	# exception thrown 
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
