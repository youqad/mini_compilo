.data

.string_7:
	.asciz "\n"
	.align 8
.string_9:
	.asciz " "
	.align 8
.string_8:
	.asciz "  "
	.align 8
.string_3:
	.asciz "%d est trop gros, je n'ai pas assez de place memoire...\n"
	.align 8
.string_6:
	.asciz "%s%8d"
	.align 8
.string_2:
	.asciz "Ah non, quand meme, un nombre >=2, s'il-vous-plait...\n"
	.align 8
.string_4:
	.asciz "Les nombres premiers inferieurs a %d sont:\n"
	.align 8
.string_1:
	.asciz "Usage: ./sieve <n>\ncalcule et affiche les nombres premiers inferieurs a <n>.\n"
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
	 movslq %eax, %rax
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
	 movslq %eax, %rax
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
	 movslq %eax, %rax
	popq %r10	# retrieve caller registers
	 popq %r11
	 addq $8, %rsp	# to restore the stack alignment
	 movq %rax, -24(%rbp)
	 movq  $2, %rax
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
	 movslq %eax, %rax
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
	 movslq %eax, %rax
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
	 pushq %rax
	 movq  $8, %rax
	 popq %rcx
	 imulq %rcx, %rax
	 pushq %rax	# putting argument number 1 on the stack
	 popq %rdi	 # putting argument number 1 in register
	 xorq %rax, %rax
	 callq malloc
	popq %r10	# retrieve caller registers
	 popq %r11
	 addq $8, %rsp	# to restore the stack alignment
	 movq %rax, -32(%rbp)
	 movq  $0, %rax
	 pushq %rax
	 movq  -32(%rbp), %rax
	 popq %rcx
	 cmpq %rcx, %rax
	 je .main_successCmp_20
	 xorq %rax, %rax
	 jmp .main_continueCmp_21
.main_successCmp_20:
	 movq $1, %rax
.main_continueCmp_21:
	 cmpq $0, %rax
	 je .main_failureIf_23
	 subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller registers
	 pushq %r11
	 movq  $.string_3, %rax
	 pushq %rax	# putting argument number 2 on the stack
	 movq  stderr, %rax
	 pushq %rax	# putting argument number 1 on the stack
	 popq %rdi	 # putting argument number 1 in register
	 popq %rsi	 # putting argument number 2 in register
	 xorq %rax, %rax
	 callq fprintf
	 movslq %eax, %rax
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
	 movslq %eax, %rax
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
	 jmp .main_endIf_22
.main_failureIf_23:
.main_endIf_22:
	 subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller registers
	 pushq %r11
	 movq  -24(%rbp), %rax
	 pushq %rax	# putting argument number 2 on the stack
	 movq  -32(%rbp), %rax
	 pushq %rax	# putting argument number 1 on the stack
	 popq %rdi	 # putting argument number 1 in register
	 popq %rsi	 # putting argument number 2 in register
	 xorq %rax, %rax
	 callq zero_sieve
	popq %r10	# retrieve caller registers
	 popq %r11
	 addq $8, %rsp	# to restore the stack alignment
	 movq  $1, %rax
	 pushq %rax
	 movq  $1, %rax
	 popq %rcx
	 movq -32(%rbp), %rdx
	 movq %rcx, (%rdx, %rax, 8)
	 movq %rcx, %rax
	 pushq %rax
	 movq  $0, %rax
	 popq %rcx
	 movq -32(%rbp), %rdx
	 movq %rcx, (%rdx, %rax, 8)
	 movq %rcx, %rax
	 subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller registers
	 pushq %r11
	 movq  -24(%rbp), %rax
	 pushq %rax	# putting argument number 2 on the stack
	 movq  -32(%rbp), %rax
	 pushq %rax	# putting argument number 1 on the stack
	 popq %rdi	 # putting argument number 1 in register
	 popq %rsi	 # putting argument number 2 in register
	 xorq %rax, %rax
	 callq fill_sieve
	popq %r10	# retrieve caller registers
	 popq %r11
	 addq $8, %rsp	# to restore the stack alignment
	 subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller registers
	 pushq %r11
	 movq  -24(%rbp), %rax
	 pushq %rax	# putting argument number 2 on the stack
	 movq  -32(%rbp), %rax
	 pushq %rax	# putting argument number 1 on the stack
	 popq %rdi	 # putting argument number 1 in register
	 popq %rsi	 # putting argument number 2 in register
	 xorq %rax, %rax
	 callq print_sieve
	popq %r10	# retrieve caller registers
	 popq %r11
	 addq $8, %rsp	# to restore the stack alignment
	 subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller registers
	 pushq %r11
	 movq  -32(%rbp), %rax
	 pushq %rax	# putting argument number 1 on the stack
	 popq %rdi	 # putting argument number 1 in register
	 xorq %rax, %rax
	 callq free
	 movslq %eax, %rax
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
.globl zero_sieve
 zero_sieve:
	pushq %rbx	 # saving callee registers
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	pushq %rbp	# base pointer
	movq %rsp, %rbp
	pushq %rdi	 # saving argument number 1 on the stack
	pushq %rsi	 # saving argument number 2 on the stack
	 subq $8, %rsp
	 movq  $0, %rax
	 movq %rax, -24(%rbp)
.zero_sieve_loopWhile_25:
	 movq  -16(%rbp), %rax
	 pushq %rax
	 movq  -24(%rbp), %rax
	 popq %rcx
	 cmpq %rcx, %rax
	 jl .zero_sieve_successCmp_26
	 xorq %rax, %rax
	 jmp .zero_sieve_continueCmp_27
.zero_sieve_successCmp_26:
	 movq $1, %rax
.zero_sieve_continueCmp_27:
	 cmpq $0, %rax
	 je .zero_sieve_endWhile_24
	 movq  $0, %rax
	 pushq %rax
	 movq  -24(%rbp), %rax
	 popq %rcx
	 movq -8(%rbp), %rdx
	 movq %rcx, (%rdx, %rax, 8)
	 movq %rcx, %rax
	 movq  -24(%rbp), %rax
	 pushq %rax	 # the value of expr is stored in for later
	 inc %rax
	 movq %rax, -24(%rbp)
	 popq %rax
	 jmp .zero_sieve_loopWhile_25
.zero_sieve_endWhile_24:
	 movq  $0, %rax
	movq %rbp, %rsp
	popq %rbp
	popq %r15	# restoring callee registers
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	retq
.globl fill_sieve
 fill_sieve:
	pushq %rbx	 # saving callee registers
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	pushq %rbp	# base pointer
	movq %rsp, %rbp
	pushq %rdi	 # saving argument number 1 on the stack
	pushq %rsi	 # saving argument number 2 on the stack
	 subq $8, %rsp
	 movq  $2, %rax
	 movq %rax, -24(%rbp)
.fill_sieve_loopWhile_29:
	 movq  -16(%rbp), %rax
	 pushq %rax
	 movq  -24(%rbp), %rax
	 popq %rcx
	 cmpq %rcx, %rax
	 jl .fill_sieve_successCmp_30
	 xorq %rax, %rax
	 jmp .fill_sieve_continueCmp_31
.fill_sieve_successCmp_30:
	 movq $1, %rax
.fill_sieve_continueCmp_31:
	 cmpq $0, %rax
	 je .fill_sieve_endWhile_28
	pushq %r10	# save caller registers
	 pushq %r11
	 movq  -24(%rbp), %rax
	 pushq %rax	# putting argument number 3 on the stack
	 movq  -16(%rbp), %rax
	 pushq %rax	# putting argument number 2 on the stack
	 movq  -8(%rbp), %rax
	 pushq %rax	# putting argument number 1 on the stack
	 popq %rdi	 # putting argument number 1 in register
	 popq %rsi	 # putting argument number 2 in register
	 popq %rdx	 # putting argument number 3 in register
	 xorq %rax, %rax
	 callq cross_out_prime
	popq %r10	# retrieve caller registers
	 popq %r11
.fill_sieve_loopWhile_33:
	 movq  -16(%rbp), %rax
	 pushq %rax
	 movq  -24(%rbp), %rax
	 inc %rax
	 movq %rax, -24(%rbp)
	 popq %rcx
	 cmpq %rcx, %rax
	 jl .fill_sieve_successCmp_34
	 xorq %rax, %rax
	 jmp .fill_sieve_continueCmp_35
.fill_sieve_successCmp_34:
	 movq $1, %rax
.fill_sieve_continueCmp_35:
	 cmpq $0, %rax
	 je .fill_sieve_failureIf_37
	 movq  -24(%rbp), %rax
	 pushq %rax
	 movq  -8(%rbp), %rax
	 popq %rcx
	 movq  -24(%rbp), %rax
	 movq %rax, %rcx
	 movq -8(%rbp), %rdx
	 movq (%rdx, %rcx, 8), %rax
	 jmp .fill_sieve_endIf_36
.fill_sieve_failureIf_37:
	 movq  $0, %rax
.fill_sieve_endIf_36:
	 cmpq $0, %rax
	 je .fill_sieve_endWhile_32
	 jmp .fill_sieve_loopWhile_33
.fill_sieve_endWhile_32:
	 jmp .fill_sieve_loopWhile_29
.fill_sieve_endWhile_28:
	 movq  $0, %rax
	movq %rbp, %rsp
	popq %rbp
	popq %r15	# restoring callee registers
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	retq
.globl cross_out_prime
 cross_out_prime:
	pushq %rbx	 # saving callee registers
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	pushq %rbp	# base pointer
	movq %rsp, %rbp
	pushq %rdi	 # saving argument number 1 on the stack
	pushq %rsi	 # saving argument number 2 on the stack
	pushq %rdx	 # saving argument number 3 on the stack
	 subq $8, %rsp
	 movq  -24(%rbp), %rax
	 movq %rax, -32(%rbp)
.cross_out_prime_loopWhile_39:
	 movq  -16(%rbp), %rax
	 pushq %rax
	 movq  -32(%rbp), %rax
	 pushq %rax
	 movq  -24(%rbp), %rax
	 popq %rcx
	 addq %rcx, %rax
	 movq %rax, -24(%rbp)
	 popq %rcx
	 cmpq %rcx, %rax
	 jl .cross_out_prime_successCmp_40
	 xorq %rax, %rax
	 jmp .cross_out_prime_continueCmp_41
.cross_out_prime_successCmp_40:
	 movq $1, %rax
.cross_out_prime_continueCmp_41:
	 cmpq $0, %rax
	 je .cross_out_prime_endWhile_38
	 movq  $1, %rax
	 pushq %rax
	 movq  -24(%rbp), %rax
	 popq %rcx
	 movq -8(%rbp), %rdx
	 movq %rcx, (%rdx, %rax, 8)
	 movq %rcx, %rax
	 jmp .cross_out_prime_loopWhile_39
.cross_out_prime_endWhile_38:
	 movq  $0, %rax
	movq %rbp, %rsp
	popq %rbp
	popq %r15	# restoring callee registers
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	retq
.globl print_sieve
 print_sieve:
	pushq %rbx	 # saving callee registers
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	pushq %rbp	# base pointer
	movq %rsp, %rbp
	pushq %rdi	 # saving argument number 1 on the stack
	pushq %rsi	 # saving argument number 2 on the stack
	 subq $32, %rsp
	 subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller registers
	 pushq %r11
	 movq  -16(%rbp), %rax
	 pushq %rax	# putting argument number 2 on the stack
	 movq  $.string_4, %rax
	 pushq %rax	# putting argument number 1 on the stack
	 popq %rdi	 # putting argument number 1 in register
	 popq %rsi	 # putting argument number 2 in register
	 xorq %rax, %rax
	 callq printf
	 movslq %eax, %rax
	popq %r10	# retrieve caller registers
	 popq %r11
	 addq $8, %rsp	# to restore the stack alignment
	 movq  $.string_8, %rax
	 movq %rax, -24(%rbp)
	 movq  $0, %rax
	 movq %rax, -40(%rbp)
	 movq  $0, %rax
	 movq %rax, -32(%rbp)
.print_sieve_loopWhile_43:
	 movq  -16(%rbp), %rax
	 pushq %rax
	 movq  -32(%rbp), %rax
	 popq %rcx
	 cmpq %rcx, %rax
	 jl .print_sieve_successCmp_44
	 xorq %rax, %rax
	 jmp .print_sieve_continueCmp_45
.print_sieve_successCmp_44:
	 movq $1, %rax
.print_sieve_continueCmp_45:
	 cmpq $0, %rax
	 je .print_sieve_endWhile_42
	 movq  $0, %rax
	 pushq %rax
	 movq  -32(%rbp), %rax
	 pushq %rax
	 movq  -8(%rbp), %rax
	 popq %rcx
	 movq  -32(%rbp), %rax
	 movq %rax, %rcx
	 movq -8(%rbp), %rdx
	 movq (%rdx, %rcx, 8), %rax
	 popq %rcx
	 cmpq %rcx, %rax
	 je .print_sieve_successCmp_46
	 xorq %rax, %rax
	 jmp .print_sieve_continueCmp_47
.print_sieve_successCmp_46:
	 movq $1, %rax
.print_sieve_continueCmp_47:
	 cmpq $0, %rax
	 je .print_sieve_failureIf_49
	 subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller registers
	 pushq %r11
	 movq  -32(%rbp), %rax
	 pushq %rax	# putting argument number 3 on the stack
	 movq  -24(%rbp), %rax
	 pushq %rax	# putting argument number 2 on the stack
	 movq  $.string_6, %rax
	 pushq %rax	# putting argument number 1 on the stack
	 popq %rdi	 # putting argument number 1 in register
	 popq %rsi	 # putting argument number 2 in register
	 popq %rdx	 # putting argument number 3 in register
	 xorq %rax, %rax
	 callq printf
	 movslq %eax, %rax
	popq %r10	# retrieve caller registers
	 popq %r11
	 addq $8, %rsp	# to restore the stack alignment
	 movq  -40(%rbp), %rax
	 inc %rax
	 movq %rax, -40(%rbp)
	 pushq %rax
	 movq  $4, %rax
	 popq %rcx
	 cmpq %rcx, %rax
	 jle .print_sieve_successCmp_50
	 xorq %rax, %rax
	 jmp .print_sieve_continueCmp_51
.print_sieve_successCmp_50:
	 movq $1, %rax
.print_sieve_continueCmp_51:
	 cmpq $0, %rax
	 je .print_sieve_failureIf_53
	 subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller registers
	 pushq %r11
	 movq  $.string_7, %rax
	 pushq %rax	# putting argument number 1 on the stack
	 popq %rdi	 # putting argument number 1 in register
	 xorq %rax, %rax
	 callq printf
	 movslq %eax, %rax
	popq %r10	# retrieve caller registers
	 popq %r11
	 addq $8, %rsp	# to restore the stack alignment
	 movq  $0, %rax
	 movq %rax, -40(%rbp)
	 movq  $.string_8, %rax
	 movq %rax, -24(%rbp)
	 jmp .print_sieve_endIf_52
.print_sieve_failureIf_53:
	 subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller registers
	 pushq %r11
	 movq  $.string_9, %rax
	 pushq %rax	# putting argument number 1 on the stack
	 popq %rdi	 # putting argument number 1 in register
	 xorq %rax, %rax
	 callq printf
	 movslq %eax, %rax
	popq %r10	# retrieve caller registers
	 popq %r11
	 addq $8, %rsp	# to restore the stack alignment
.print_sieve_endIf_52:
	 jmp .print_sieve_endIf_48
.print_sieve_failureIf_49:
.print_sieve_endIf_48:
	 movq  -32(%rbp), %rax
	 pushq %rax	 # the value of expr is stored in for later
	 inc %rax
	 movq %rax, -32(%rbp)
	 popq %rax
	 jmp .print_sieve_loopWhile_43
.print_sieve_endWhile_42:
	 subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller registers
	 pushq %r11
	 movq  stdout, %rax
	 pushq %rax	# putting argument number 1 on the stack
	 popq %rdi	 # putting argument number 1 in register
	 xorq %rax, %rax
	 callq fflush
	 movslq %eax, %rax
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
