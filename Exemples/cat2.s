.data

.string_1:
	.asciz "r"
	.align 8


.text

.globl main
 main:
	pushq %rbx	 # saving callee registers
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	pushq %rbp	# base pointer
	movq %rsp, %rbp
	pushq %rdi	 # saving argument number 1 on the stack
	pushq %rsi	 # saving argument number 2 on the stack
	 subq $16, %rsp
	 movq  $1, %rax
	 movq %rax, -24(%rbp)
.main_loopWhile_3:
	 movq  -8(%rbp), %rax
	 pushq %rax
	 movq  -24(%rbp), %rax
	 popq %rcx
	 cmpq %rcx, %rax
	 jl .main_successCmp_4
	 xorq %rax, %rax
	 jmp .main_continueCmp_5
.main_successCmp_4:
	 movq $1, %rax
.main_continueCmp_5:
	 cmpq $0, %rax
	 je .main_endWhile_2
	 subq $8, %rsp
	pushq %r10	# save caller registers
	 pushq %r11
	 movq  $.string_1, %rax
	 pushq %rax	# putting argument number 2 on the stack
	 movq  -24(%rbp), %rax
	 pushq %rax
	 movq  -16(%rbp), %rax
	 popq %rcx
	 movq  -24(%rbp), %rax
	 movq %rax, %rcx
	 movq -16(%rbp), %rdx
	 movq (%rdx, %rcx, 8), %rax
	 pushq %rax	# putting argument number 1 on the stack
	 popq %rdi	 # putting argument number 1 in register
	 popq %rsi	 # putting argument number 2 in register
	 xorq %rax, %rax
	 callq fopen
	 cltq
	popq %r10	# retrieve caller registers
	 popq %r11
	 movq %rax, -40(%rbp)
.main_loopWhile_7:
	 movq  $1, %rax
	 neg %rax
	 pushq %rax
	 subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller registers
	 pushq %r11
	 movq  -40(%rbp), %rax
	 pushq %rax	# putting argument number 1 on the stack
	 popq %rdi	 # putting argument number 1 in register
	 xorq %rax, %rax
	 callq fgetc
	 cltq
	popq %r10	# retrieve caller registers
	 popq %r11
	 addq $8, %rsp	# to restore the stack alignment
	 movq %rax, -32(%rbp)
	 popq %rcx
	 cmpq %rcx, %rax
	 je .main_successCmp_8
	 xorq %rax, %rax
	 jmp .main_continueCmp_9
.main_successCmp_8:
	 movq $1, %rax
.main_continueCmp_9:
	 cmpq $0, %rax
	 je .main_failureIf_11
	 movq  $0, %rax
	 jmp .main_endIf_10
.main_failureIf_11:
	 movq  $1, %rax
.main_endIf_10:
	 cmpq $0, %rax
	 je .main_endWhile_6
	pushq %r10	# save caller registers
	 pushq %r11
	 movq  stdout, %rax
	 pushq %rax	# putting argument number 2 on the stack
	 movq  -32(%rbp), %rax
	 pushq %rax	# putting argument number 1 on the stack
	 popq %rdi	 # putting argument number 1 in register
	 popq %rsi	 # putting argument number 2 in register
	 xorq %rax, %rax
	 callq fputc
	 cltq
	popq %r10	# retrieve caller registers
	 popq %r11
	 jmp .main_loopWhile_7
.main_endWhile_6:
	pushq %r10	# save caller registers
	 pushq %r11
	 movq  -40(%rbp), %rax
	 pushq %rax	# putting argument number 1 on the stack
	 popq %rdi	 # putting argument number 1 in register
	 xorq %rax, %rax
	 callq fclose
	 cltq
	popq %r10	# retrieve caller registers
	 popq %r11
	 addq $8, %rsp
	 movq  -24(%rbp), %rax
	 pushq %rax	 # the value of expr is stored in for later
	 inc %rax
	 movq %rax, -24(%rbp)
	 popq %rax
	 jmp .main_loopWhile_3
.main_endWhile_2:
	 subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller registers
	 pushq %r11
	 movq  stdout, %rax
	 pushq %rax	# putting argument number 1 on the stack
	 popq %rdi	 # putting argument number 1 in register
	 xorq %rax, %rax
	 callq fflush
	 cltq
	popq %r10	# retrieve caller registers
	 popq %r11
	 addq $8, %rsp	# to restore the stack alignment
	 subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller registers
	 pushq %r11
	 movq  $0, %rax
	 pushq %rax	# putting argument number 1 on the stack
	 popq %rdi	 # putting argument number 1 in register
	 xorq %rax, %rax
	 callq exit
	popq %r10	# retrieve caller registers
	 popq %r11
	 addq $8, %rsp	# to restore the stack alignment
	 addq $16, %rsp
	movq %rbp, %rsp
	popq %rbp
	popq %r15	# restoring callee registers
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	retq
