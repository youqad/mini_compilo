.data

.string_2:
	.asciz "Ah non, quand meme, un nombre positif ou nul, s'il-vous-plait...\n"
	.align 8
.string_3:
	.asciz "La factorielle de %d vaut %d (en tout cas, modulo 2^32...).\n"
	.align 8
.string_1:
	.asciz "Usage: ./fact <n>\ncalcule et affiche la factorielle de <n>.\n"
	.align 8


.text

.globl fact
 fact:
	pushq %rbx	 # saving callee registers
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	pushq %rbp	# base pointer
	movq %rsp, %rbp
	pushq %rdi	 # saving argument number 1 on the stack
	 subq $8, %rsp
	 movq  $1, %rax
	 movq %rax, -16(%rbp)
.fact_loopWhile_5:
	 movq  $0, %rax
	 pushq %rax
	 movq  -8(%rbp), %rax
	 popq %rcx
	 cmpq %rcx, %rax
	 je .fact_successCmp_6
	 xorq %rax, %rax
	 jmp .fact_continueCmp_7
.fact_successCmp_6:
	 movq $1, %rax
.fact_continueCmp_7:
	 cmpq $0, %rax
	 je .fact_failureIf_9
	 movq  $0, %rax
	 jmp .fact_endIf_8
.fact_failureIf_9:
	 movq  $1, %rax
.fact_endIf_8:
	 cmpq $0, %rax
	 je .fact_endWhile_4
	 movq  -8(%rbp), %rax
	 pushq %rax
	 movq  -16(%rbp), %rax
	 popq %rcx
	 imulq %rcx, %rax
	 movq %rax, -16(%rbp)
	 movq  -8(%rbp), %rax
	 pushq %rax	 # the value of expr is stored in for later
	 dec %rax
	 movq %rax, -8(%rbp)
	 popq %rax
	 jmp .fact_loopWhile_5
.fact_endWhile_4:
	 movq  -16(%rbp), %rax
	movq %rbp, %rsp
	popq %rbp
	popq %r15	# restoring callee registers
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	retq
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
	 movq  $2, %rax
	 pushq %rax
	 movq  -8(%rbp), %rax
	 popq %rcx
	 cmpq %rcx, %rax
	 je .main_successCmp_10
	 xorq %rax, %rax
	 jmp .main_continueCmp_11
.main_successCmp_10:
	 movq $1, %rax
.main_continueCmp_11:
	 cmpq $0, %rax
	 je .main_failureIf_13
	 movq  $0, %rax
	 jmp .main_endIf_12
.main_failureIf_13:
	 movq  $1, %rax
.main_endIf_12:
	 cmpq $0, %rax
	 je .main_failureIf_15
	 subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller registers
	 pushq %r11
	 movq  $.string_1, %rax
	 pushq %rax	# putting argument number 2 on the stack
	 movq  stderr, %rax
	 pushq %rax	# putting argument number 1 on the stack
	 popq %rdi	 # putting argument number 1 in register
	 popq %rsi	 # putting argument number 2 in register
	 xorq %rax, %rax
	 callq fprintf
	popq %r10	# retrieve caller registers
	 popq %r11
	 addq $8, %rsp	# to restore the stack alignment
	 subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller registers
	 pushq %r11
	 movq  stderr, %rax
	 pushq %rax	# putting argument number 1 on the stack
	 popq %rdi	 # putting argument number 1 in register
	 xorq %rax, %rax
	 callq fflush
	popq %r10	# retrieve caller registers
	 popq %r11
	 addq $8, %rsp	# to restore the stack alignment
	 subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller registers
	 pushq %r11
	 movq  $10, %rax
	 pushq %rax	# putting argument number 1 on the stack
	 popq %rdi	 # putting argument number 1 in register
	 xorq %rax, %rax
	 callq exit
	popq %r10	# retrieve caller registers
	 popq %r11
	 addq $8, %rsp	# to restore the stack alignment
	 jmp .main_endIf_14
.main_failureIf_15:
.main_endIf_14:
	 subq $16, %rsp
	 subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller registers
	 pushq %r11
	 movq  $1, %rax
	 pushq %rax
	 movq  -16(%rbp), %rax
	 popq %rcx
	 movq  $1, %rax
	 movq %rax, %rcx
	 movq -16(%rbp), %rdx
	 movq (%rdx, %rcx, 8), %rax
	 pushq %rax	# putting argument number 1 on the stack
	 popq %rdi	 # putting argument number 1 in register
	 xorq %rax, %rax
	 callq atoi
	popq %r10	# retrieve caller registers
	 popq %r11
	 addq $8, %rsp	# to restore the stack alignment
	 movq %rax, -24(%rbp)
	 movq  $0, %rax
	 pushq %rax
	 movq  -24(%rbp), %rax
	 popq %rcx
	 cmpq %rcx, %rax
	 jl .main_successCmp_16
	 xorq %rax, %rax
	 jmp .main_continueCmp_17
.main_successCmp_16:
	 movq $1, %rax
.main_continueCmp_17:
	 cmpq $0, %rax
	 je .main_failureIf_19
	 subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller registers
	 pushq %r11
	 movq  $.string_2, %rax
	 pushq %rax	# putting argument number 2 on the stack
	 movq  stderr, %rax
	 pushq %rax	# putting argument number 1 on the stack
	 popq %rdi	 # putting argument number 1 in register
	 popq %rsi	 # putting argument number 2 in register
	 xorq %rax, %rax
	 callq fprintf
	popq %r10	# retrieve caller registers
	 popq %r11
	 addq $8, %rsp	# to restore the stack alignment
	 subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller registers
	 pushq %r11
	 movq  stderr, %rax
	 pushq %rax	# putting argument number 1 on the stack
	 popq %rdi	 # putting argument number 1 in register
	 xorq %rax, %rax
	 callq fflush
	popq %r10	# retrieve caller registers
	 popq %r11
	 addq $8, %rsp	# to restore the stack alignment
	 subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller registers
	 pushq %r11
	 movq  $10, %rax
	 pushq %rax	# putting argument number 1 on the stack
	 popq %rdi	 # putting argument number 1 in register
	 xorq %rax, %rax
	 callq exit
	popq %r10	# retrieve caller registers
	 popq %r11
	 addq $8, %rsp	# to restore the stack alignment
	 jmp .main_endIf_18
.main_failureIf_19:
.main_endIf_18:
	 subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller registers
	 pushq %r11
	 movq  -24(%rbp), %rax
	 pushq %rax	# putting argument number 1 on the stack
	 popq %rdi	 # putting argument number 1 in register
	 xorq %rax, %rax
	 callq fact
	popq %r10	# retrieve caller registers
	 popq %r11
	 addq $8, %rsp	# to restore the stack alignment
	 movq %rax, -32(%rbp)
	 subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller registers
	 pushq %r11
	 movq  -32(%rbp), %rax
	 pushq %rax	# putting argument number 3 on the stack
	 movq  -24(%rbp), %rax
	 pushq %rax	# putting argument number 2 on the stack
	 movq  $.string_3, %rax
	 pushq %rax	# putting argument number 1 on the stack
	 popq %rdi	 # putting argument number 1 in register
	 popq %rsi	 # putting argument number 2 in register
	 popq %rdx	 # putting argument number 3 in register
	 xorq %rax, %rax
	 callq printf
	popq %r10	# retrieve caller registers
	 popq %r11
	 addq $8, %rsp	# to restore the stack alignment
	 movq  $0, %rax
	movq %rbp, %rsp
	popq %rbp
	popq %r15	# restoring callee registers
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	retq
