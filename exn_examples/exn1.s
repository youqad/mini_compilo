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
	movq $13, %rax
	movq .main_endFunction_1, %rcx
	jmp .main_endFunction_1 	# exception thrown 
.main_endFunction_1:
	movq %rbp, %rsp
	popq %rbp
	popq %r15	# restoring callee-saved registers
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	retq
