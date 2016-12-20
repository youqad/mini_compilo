.data



.comm .exception_not_caught_1,8,8


.text

	movq $0, .exception_not_caught_1
.globl f
 f:
	pushq %rbx	# saving callee-saved registers
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	pushq %rbp	# base pointer
	movq %rsp, %rbp
	pushq %rdi	# saving argument number 1 on the stack
	jmp .ftryBegin_4
.ffinally_5:
	movq $0, %rax
	movq -8(%rbp), %rdx
	movq (%rdx, %rax, 8), %rcx
	pushq %rcx	# the value of expr is stored in for later
	inc %rcx
	movq %rcx, (%rdx, %rax, 8)
	movq %rcx, %rax
	popq %rax
	jmp .ftryContinue_3 	# end of finally reached 
.ftryBegin_4:
	movq $0, %rax
	movq -8(%rbp), %rdx
	movq (%rdx, %rax, 8), %rcx
	pushq %rcx	# the value of expr is stored in for later
	inc %rcx
	movq %rcx, (%rdx, %rax, 8)
	movq %rcx, %rax
	popq %rax
	movq -8(%rbp), %rax
	jmp .ffinally_5
	jmp .f_endFunction_2 	# return reached : end function
	jmp .ffinally_5
.ftryContinue_3:
.f_endFunction_2:
	movq %rbp, %rsp
	popq %rbp
	popq %r15	# restoring callee-saved registers
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	retq
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
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq $8, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	xorq %rax, %rax
	callq malloc
	popq %r10	# retrieve caller-saved registers
	popq %r11
	cmpq $0, .exception_not_caught_1
	je .main_endExceptionCaught_7
.main_endExceptionCaught_7:
	movq %rax, -8(%rbp)
	movq $0, %rax
	pushq %rax
	movq $0, %rax
	popq %rcx
	movq -8(%rbp), %rdx
	movq %rcx, (%rdx, %rax, 8)
	movq %rcx, %rax
	movq $0, %rax
	pushq %rax
	subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq -8(%rbp), %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	xorq %rax, %rax
	callq f
	popq %r10	# retrieve caller-saved registers
	popq %r11
	addq $8, %rsp	# to restore the stack alignment
	cmpq $0, .exception_not_caught_1
	je .main_endExceptionCaught_8
.main_endExceptionCaught_8:
	popq %rcx
	jmp .main_endFunction_6 	# return reached : end function
	addq $8, %rsp
.main_endFunction_6:
	movq %rbp, %rsp
	popq %rbp
	popq %r15	# restoring callee-saved registers
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	retq
