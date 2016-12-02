.data

.string_36:
	.asciz "----------------------\n"
	.align 8
.string_5:
	.asciz "15"
	.align 8
.string_6:
	.asciz "Ah non, quand meme, un nombre positif ou nul, s'il-vous-plait...\n"
	.align 8
.string_4:
	.asciz "Valeur de j=%d (normalement 7), valeur de i=%d.\n"
	.align 8
.string_27:
	.asciz "fact  %s\n"
	.align 8
.string_30:
	.asciz "fact  th=%d, value=%d\n"
	.align 8
.string_34:
	.asciz "failed"
	.align 8
.string_32:
	.asciz "id_1  %s\n"
	.align 8
.string_35:
	.asciz "id_1  th=%d, value=%d\n"
	.align 8
.string_33:
	.asciz "pass"
	.align 8
.string_3:
	.asciz "r"
	.align 8
.string_12:
	.asciz "tab[%d][%d]  %s\n"
	.align 8
.string_15:
	.asciz "tab[%d][%d]  th=%d, value=%d\n"
	.align 8
.string_1:
	.asciz "unitest.c"
	.align 8
.string_2:
	.asciz "unitest2.c"
	.align 8




.text

.globl fact
 fact:
	pushq %rbx	# saving callee-saved registers
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	pushq %rbp	# base pointer
	movq %rsp, %rbp
	pushq %rdi	# saving argument number 1 on the stack
	subq $8, %rsp
	movq $1, %rax
	movq %rax, -16(%rbp)
.fact_loopWhile_39:
	movq $0, %rax
	pushq %rax
	movq -8(%rbp), %rax
	popq %rcx
	cmpq %rcx, %rax
	je .fact_successCmp_40
	xorq %rax, %rax
	jmp .fact_continueCmp_41
.fact_successCmp_40:
	movq $1, %rax
.fact_continueCmp_41:
	cmpq $0, %rax
	je .fact_failureIf_43
	movq $0, %rax
	jmp .fact_endIf_42
.fact_failureIf_43:
	movq $1, %rax
.fact_endIf_42:
	cmpq $0, %rax
	je .fact_endWhile_38
	movq -8(%rbp), %rax
	pushq %rax
	movq -16(%rbp), %rax
	popq %rcx
	imulq %rcx, %rax
	movq %rax, -16(%rbp)
	movq -8(%rbp), %rax
	pushq %rax	# the value of expr is stored in for later
	dec %rax
	movq %rax, -8(%rbp)
	popq %rax
	jmp .fact_loopWhile_39
.fact_endWhile_38:
	movq -16(%rbp), %rax
	jmp .fact_endFunction_37 	# return reached : end function
	addq $8, %rsp
.fact_endFunction_37:
	movq %rbp, %rsp
	popq %rbp
	popq %r15	# restoring callee-saved registers
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	retq
.globl test_cat
 test_cat:
	pushq %rbx	# saving callee-saved registers
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	pushq %rbp	# base pointer
	movq %rsp, %rbp
	subq $24, %rsp
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq $8, %rax
	pushq %rax
	movq $2, %rax
	popq %rcx
	imulq %rcx, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	xorq %rax, %rax
	callq malloc
	popq %r10	# retrieve caller-saved registers
	popq %r11
	movq %rax, -24(%rbp)
	movq $.string_1, %rax
	pushq %rax
	movq $0, %rax
	popq %rcx
	movq -24(%rbp), %rdx
	movq %rcx, (%rdx, %rax, 8)
	movq %rcx, %rax
	movq $.string_2, %rax
	pushq %rax
	movq $1, %rax
	popq %rcx
	movq -24(%rbp), %rdx
	movq %rcx, (%rdx, %rax, 8)
	movq %rcx, %rax
	movq $0, %rax
	movq %rax, -8(%rbp)
.test_cat_loopWhile_46:
	movq $2, %rax
	pushq %rax
	movq -8(%rbp), %rax
	popq %rcx
	cmpq %rcx, %rax
	jl .test_cat_successCmp_47
	xorq %rax, %rax
	jmp .test_cat_continueCmp_48
.test_cat_successCmp_47:
	movq $1, %rax
.test_cat_continueCmp_48:
	cmpq $0, %rax
	je .test_cat_endWhile_45
	subq $8, %rsp
	subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq $.string_3, %rax
	pushq %rax	# putting argument number 2 on the stack
	movq -8(%rbp), %rax
	pushq %rax
	movq -24(%rbp), %rax
	popq %rcx
	movq -8(%rbp), %rax
	movq %rax, %rcx
	movq -24(%rbp), %rdx
	movq (%rdx, %rcx, 8), %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	popq %rsi	# putting argument number 2 in register
	xorq %rax, %rax
	callq fopen
	cltq
	popq %r10	# retrieve caller-saved registers
	popq %r11
	addq $8, %rsp	# to restore the stack alignment
	movq %rax, -32(%rbp)
.test_cat_loopWhile_50:
	movq $1, %rax
	neg %rax
	pushq %rax
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq -32(%rbp), %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	xorq %rax, %rax
	callq fgetc
	cltq
	popq %r10	# retrieve caller-saved registers
	popq %r11
	movq %rax, -16(%rbp)
	popq %rcx
	cmpq %rcx, %rax
	je .test_cat_successCmp_51
	xorq %rax, %rax
	jmp .test_cat_continueCmp_52
.test_cat_successCmp_51:
	movq $1, %rax
.test_cat_continueCmp_52:
	cmpq $0, %rax
	je .test_cat_failureIf_54
	movq $0, %rax
	jmp .test_cat_endIf_53
.test_cat_failureIf_54:
	movq $1, %rax
.test_cat_endIf_53:
	cmpq $0, %rax
	je .test_cat_endWhile_49
	subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq stdout, %rax
	pushq %rax	# putting argument number 2 on the stack
	movq -16(%rbp), %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	popq %rsi	# putting argument number 2 in register
	xorq %rax, %rax
	callq fputc
	cltq
	popq %r10	# retrieve caller-saved registers
	popq %r11
	addq $8, %rsp	# to restore the stack alignment
	jmp .test_cat_loopWhile_50
.test_cat_endWhile_49:
	subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq -32(%rbp), %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	xorq %rax, %rax
	callq fclose
	cltq
	popq %r10	# retrieve caller-saved registers
	popq %r11
	addq $8, %rsp	# to restore the stack alignment
	addq $8, %rsp
	movq -8(%rbp), %rax
	pushq %rax	# the value of expr is stored in for later
	inc %rax
	movq %rax, -8(%rbp)
	popq %rax
	jmp .test_cat_loopWhile_46
.test_cat_endWhile_45:
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq stdout, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	xorq %rax, %rax
	callq fflush
	cltq
	popq %r10	# retrieve caller-saved registers
	popq %r11
	addq $24, %rsp
.test_cat_endFunction_44:
	movq %rbp, %rsp
	popq %rbp
	popq %r15	# restoring callee-saved registers
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	retq
.globl test_ordre
 test_ordre:
	pushq %rbx	# saving callee-saved registers
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	pushq %rbp	# base pointer
	movq %rsp, %rbp
	subq $16, %rsp
	movq $4, %rax
	movq %rax, -8(%rbp)
	pushq %rax
	movq $3, %rax
	movq %rax, -8(%rbp)
	popq %rcx
	addq %rcx, %rax
	movq %rax, -16(%rbp)
	subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq -8(%rbp), %rax
	pushq %rax	# putting argument number 3 on the stack
	movq -16(%rbp), %rax
	pushq %rax	# putting argument number 2 on the stack
	movq $.string_4, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	popq %rsi	# putting argument number 2 in register
	popq %rdx	# putting argument number 3 in register
	xorq %rax, %rax
	callq printf
	cltq
	popq %r10	# retrieve caller-saved registers
	popq %r11
	addq $8, %rsp	# to restore the stack alignment
	subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq stdout, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	xorq %rax, %rax
	callq fflush
	cltq
	popq %r10	# retrieve caller-saved registers
	popq %r11
	addq $8, %rsp	# to restore the stack alignment
	addq $16, %rsp
.test_ordre_endFunction_55:
	movq %rbp, %rsp
	popq %rbp
	popq %r15	# restoring callee-saved registers
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	retq
.globl test_fact
 test_fact:
	pushq %rbx	# saving callee-saved registers
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	pushq %rbp	# base pointer
	movq %rsp, %rbp
	subq $24, %rsp
	movq $.string_5, %rax
	movq %rax, -24(%rbp)
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq -24(%rbp), %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	xorq %rax, %rax
	callq atoi
	cltq
	popq %r10	# retrieve caller-saved registers
	popq %r11
	movq %rax, -8(%rbp)
	movq $0, %rax
	pushq %rax
	movq -8(%rbp), %rax
	popq %rcx
	cmpq %rcx, %rax
	jl .test_fact_successCmp_57
	xorq %rax, %rax
	jmp .test_fact_continueCmp_58
.test_fact_successCmp_57:
	movq $1, %rax
.test_fact_continueCmp_58:
	cmpq $0, %rax
	je .test_fact_failureIf_60
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq $.string_6, %rax
	pushq %rax	# putting argument number 2 on the stack
	movq stderr, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	popq %rsi	# putting argument number 2 in register
	xorq %rax, %rax
	callq fprintf
	cltq
	popq %r10	# retrieve caller-saved registers
	popq %r11
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq stderr, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	xorq %rax, %rax
	callq fflush
	cltq
	popq %r10	# retrieve caller-saved registers
	popq %r11
	movq $10, %rax
	jmp .test_fact_endFunction_56 	# return reached : end function
	jmp .test_fact_endIf_59
.test_fact_failureIf_60:
.test_fact_endIf_59:
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq -8(%rbp), %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	xorq %rax, %rax
	callq fact
	popq %r10	# retrieve caller-saved registers
	popq %r11
	movq %rax, -16(%rbp)
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq $1307674368000, %rax
	pushq %rax
	movq -16(%rbp), %rax
	popq %rcx
	cmpq %rcx, %rax
	je .test_fact_successCmp_61
	xorq %rax, %rax
	jmp .test_fact_continueCmp_62
.test_fact_successCmp_61:
	movq $1, %rax
.test_fact_continueCmp_62:
	cmpq $0, %rax
	je .test_fact_failureIf_64
	movq $.string_33, %rax
	jmp .test_fact_endIf_63
.test_fact_failureIf_64:
	movq $.string_34, %rax
.test_fact_endIf_63:
	pushq %rax	# putting argument number 2 on the stack
	movq $.string_27, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	popq %rsi	# putting argument number 2 in register
	xorq %rax, %rax
	callq printf
	cltq
	popq %r10	# retrieve caller-saved registers
	popq %r11
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq -16(%rbp), %rax
	pushq %rax	# putting argument number 3 on the stack
	movq $1307674368000, %rax
	pushq %rax	# putting argument number 2 on the stack
	movq $.string_30, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	popq %rsi	# putting argument number 2 in register
	popq %rdx	# putting argument number 3 in register
	xorq %rax, %rax
	callq printf
	cltq
	popq %r10	# retrieve caller-saved registers
	popq %r11
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq $.string_36, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	xorq %rax, %rax
	callq printf
	cltq
	popq %r10	# retrieve caller-saved registers
	popq %r11
	addq $24, %rsp
.test_fact_endFunction_56:
	movq %rbp, %rsp
	popq %rbp
	popq %r15	# restoring callee-saved registers
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	retq
.globl test_n_dim
 test_n_dim:
	pushq %rbx	# saving callee-saved registers
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	pushq %rbp	# base pointer
	movq %rsp, %rbp
	subq $32, %rsp
	subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq $100, %rax
	pushq %rax
	movq $8, %rax
	popq %rcx
	imulq %rcx, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	xorq %rax, %rax
	callq malloc
	popq %r10	# retrieve caller-saved registers
	popq %r11
	addq $8, %rsp	# to restore the stack alignment
	movq %rax, -8(%rbp)
	movq $0, %rax
	movq %rax, -24(%rbp)
.test_n_dim_loopWhile_67:
	movq $100, %rax
	pushq %rax
	movq -24(%rbp), %rax
	popq %rcx
	cmpq %rcx, %rax
	jl .test_n_dim_successCmp_68
	xorq %rax, %rax
	jmp .test_n_dim_continueCmp_69
.test_n_dim_successCmp_68:
	movq $1, %rax
.test_n_dim_continueCmp_69:
	cmpq $0, %rax
	je .test_n_dim_endWhile_66
	subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq $10, %rax
	pushq %rax
	movq $8, %rax
	popq %rcx
	imulq %rcx, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	xorq %rax, %rax
	callq malloc
	popq %r10	# retrieve caller-saved registers
	popq %r11
	addq $8, %rsp	# to restore the stack alignment
	pushq %rax
	movq -24(%rbp), %rax
	popq %rcx
	movq -8(%rbp), %rdx
	movq %rcx, (%rdx, %rax, 8)
	movq %rcx, %rax
	movq $0, %rax
	movq %rax, -32(%rbp)
.test_n_dim_loopWhile_71:
	movq $10, %rax
	pushq %rax
	movq -32(%rbp), %rax
	popq %rcx
	cmpq %rcx, %rax
	jl .test_n_dim_successCmp_72
	xorq %rax, %rax
	jmp .test_n_dim_continueCmp_73
.test_n_dim_successCmp_72:
	movq $1, %rax
.test_n_dim_continueCmp_73:
	cmpq $0, %rax
	je .test_n_dim_endWhile_70
	movq -24(%rbp), %rax
	pushq %rax
	movq -8(%rbp), %rax
	popq %rcx
	movq -24(%rbp), %rax
	movq %rax, %rcx
	movq -8(%rbp), %rdx
	movq (%rdx, %rcx, 8), %rax
	movq %rax, -16(%rbp)
	movq -24(%rbp), %rax
	pushq %rax
	movq $2, %rax
	pushq %rax
	movq -32(%rbp), %rax
	popq %rcx
	imulq %rcx, %rax
	popq %rcx
	addq %rcx, %rax
	pushq %rax
	movq -32(%rbp), %rax
	popq %rcx
	movq -16(%rbp), %rdx
	movq %rcx, (%rdx, %rax, 8)
	movq %rcx, %rax
	movq -32(%rbp), %rax
	pushq %rax	# the value of expr is stored in for later
	inc %rax
	movq %rax, -32(%rbp)
	popq %rax
	jmp .test_n_dim_loopWhile_71
.test_n_dim_endWhile_70:
	movq -24(%rbp), %rax
	pushq %rax	# the value of expr is stored in for later
	inc %rax
	movq %rax, -24(%rbp)
	popq %rax
	jmp .test_n_dim_loopWhile_67
.test_n_dim_endWhile_66:
	movq $0, %rax
	movq %rax, -24(%rbp)
.test_n_dim_loopWhile_75:
	movq $100, %rax
	pushq %rax
	movq -24(%rbp), %rax
	popq %rcx
	cmpq %rcx, %rax
	jl .test_n_dim_successCmp_76
	xorq %rax, %rax
	jmp .test_n_dim_continueCmp_77
.test_n_dim_successCmp_76:
	movq $1, %rax
.test_n_dim_continueCmp_77:
	cmpq $0, %rax
	je .test_n_dim_endWhile_74
	movq $0, %rax
	movq %rax, -32(%rbp)
.test_n_dim_loopWhile_79:
	movq $10, %rax
	pushq %rax
	movq -32(%rbp), %rax
	popq %rcx
	cmpq %rcx, %rax
	jl .test_n_dim_successCmp_80
	xorq %rax, %rax
	jmp .test_n_dim_continueCmp_81
.test_n_dim_successCmp_80:
	movq $1, %rax
.test_n_dim_continueCmp_81:
	cmpq $0, %rax
	je .test_n_dim_endWhile_78
	subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq -32(%rbp), %rax
	pushq %rax
	movq -24(%rbp), %rax
	pushq %rax
	movq -8(%rbp), %rax
	popq %rcx
	movq -24(%rbp), %rax
	movq %rax, %rcx
	movq -8(%rbp), %rdx
	movq (%rdx, %rcx, 8), %rax
	popq %rcx
	movq -32(%rbp), %rax
	pushq %rax
	movq -24(%rbp), %rax
	pushq %rax
	movq -8(%rbp), %rax
	popq %rcx
	movq -24(%rbp), %rax
	movq %rax, %rcx
	movq -8(%rbp), %rdx
	movq (%rdx, %rcx, 8), %rax
	popq %rcx
	movq %rax, %rdx
	movq (%rdx, %rcx, 8), %rax
	pushq %rax
	movq -24(%rbp), %rax
	pushq %rax
	movq -32(%rbp), %rax
	pushq %rax
	movq $2, %rax
	popq %rcx
	imulq %rcx, %rax
	popq %rcx
	addq %rcx, %rax
	popq %rcx
	cmpq %rcx, %rax
	je .test_n_dim_successCmp_82
	xorq %rax, %rax
	jmp .test_n_dim_continueCmp_83
.test_n_dim_successCmp_82:
	movq $1, %rax
.test_n_dim_continueCmp_83:
	cmpq $0, %rax
	je .test_n_dim_failureIf_85
	movq $.string_33, %rax
	jmp .test_n_dim_endIf_84
.test_n_dim_failureIf_85:
	movq $.string_34, %rax
.test_n_dim_endIf_84:
	pushq %rax	# putting argument number 4 on the stack
	movq -32(%rbp), %rax
	pushq %rax	# putting argument number 3 on the stack
	movq -24(%rbp), %rax
	pushq %rax	# putting argument number 2 on the stack
	movq $.string_12, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	popq %rsi	# putting argument number 2 in register
	popq %rdx	# putting argument number 3 in register
	popq %rcx	# putting argument number 4 in register
	xorq %rax, %rax
	callq printf
	cltq
	popq %r10	# retrieve caller-saved registers
	popq %r11
	addq $8, %rsp	# to restore the stack alignment
	subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq -32(%rbp), %rax
	pushq %rax
	movq -24(%rbp), %rax
	pushq %rax
	movq -8(%rbp), %rax
	popq %rcx
	movq -24(%rbp), %rax
	movq %rax, %rcx
	movq -8(%rbp), %rdx
	movq (%rdx, %rcx, 8), %rax
	popq %rcx
	movq -32(%rbp), %rax
	pushq %rax
	movq -24(%rbp), %rax
	pushq %rax
	movq -8(%rbp), %rax
	popq %rcx
	movq -24(%rbp), %rax
	movq %rax, %rcx
	movq -8(%rbp), %rdx
	movq (%rdx, %rcx, 8), %rax
	popq %rcx
	movq %rax, %rdx
	movq (%rdx, %rcx, 8), %rax
	pushq %rax	# putting argument number 5 on the stack
	movq -24(%rbp), %rax
	pushq %rax
	movq -32(%rbp), %rax
	pushq %rax
	movq $2, %rax
	popq %rcx
	imulq %rcx, %rax
	popq %rcx
	addq %rcx, %rax
	pushq %rax	# putting argument number 4 on the stack
	movq -32(%rbp), %rax
	pushq %rax	# putting argument number 3 on the stack
	movq -24(%rbp), %rax
	pushq %rax	# putting argument number 2 on the stack
	movq $.string_15, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	popq %rsi	# putting argument number 2 in register
	popq %rdx	# putting argument number 3 in register
	popq %rcx	# putting argument number 4 in register
	popq %r8	# putting argument number 5 in register
	xorq %rax, %rax
	callq printf
	cltq
	popq %r10	# retrieve caller-saved registers
	popq %r11
	addq $8, %rsp	# to restore the stack alignment
	subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq $.string_36, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	xorq %rax, %rax
	callq printf
	cltq
	popq %r10	# retrieve caller-saved registers
	popq %r11
	addq $8, %rsp	# to restore the stack alignment
	movq -32(%rbp), %rax
	pushq %rax	# the value of expr is stored in for later
	inc %rax
	movq %rax, -32(%rbp)
	popq %rax
	jmp .test_n_dim_loopWhile_79
.test_n_dim_endWhile_78:
	movq -24(%rbp), %rax
	pushq %rax	# the value of expr is stored in for later
	inc %rax
	movq %rax, -24(%rbp)
	popq %rax
	jmp .test_n_dim_loopWhile_75
.test_n_dim_endWhile_74:
	movq $0, %rax
	movq %rax, -24(%rbp)
.test_n_dim_loopWhile_87:
	movq $100, %rax
	pushq %rax
	movq -24(%rbp), %rax
	popq %rcx
	cmpq %rcx, %rax
	jl .test_n_dim_successCmp_88
	xorq %rax, %rax
	jmp .test_n_dim_continueCmp_89
.test_n_dim_successCmp_88:
	movq $1, %rax
.test_n_dim_continueCmp_89:
	cmpq $0, %rax
	je .test_n_dim_endWhile_86
	subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq -24(%rbp), %rax
	pushq %rax
	movq -8(%rbp), %rax
	popq %rcx
	movq -24(%rbp), %rax
	movq %rax, %rcx
	movq -8(%rbp), %rdx
	movq (%rdx, %rcx, 8), %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	xorq %rax, %rax
	callq free
	cltq
	popq %r10	# retrieve caller-saved registers
	popq %r11
	addq $8, %rsp	# to restore the stack alignment
	movq -24(%rbp), %rax
	pushq %rax	# the value of expr is stored in for later
	inc %rax
	movq %rax, -24(%rbp)
	popq %rax
	jmp .test_n_dim_loopWhile_87
.test_n_dim_endWhile_86:
	subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq -8(%rbp), %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	xorq %rax, %rax
	callq free
	cltq
	popq %r10	# retrieve caller-saved registers
	popq %r11
	addq $8, %rsp	# to restore the stack alignment
	addq $32, %rsp
.test_n_dim_endFunction_65:
	movq %rbp, %rsp
	popq %rbp
	popq %r15	# restoring callee-saved registers
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	retq
.globl test_ret
 test_ret:
	pushq %rbx	# saving callee-saved registers
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	pushq %rbp	# base pointer
	movq %rsp, %rbp
	pushq %rdi	# saving argument number 1 on the stack
	movq -8(%rbp), %rax
	pushq %rax
	movq $10, %rax
	popq %rcx
	cmpq %rcx, %rax
	jl .test_ret_successCmp_91
	xorq %rax, %rax
	jmp .test_ret_continueCmp_92
.test_ret_successCmp_91:
	movq $1, %rax
.test_ret_continueCmp_92:
	cmpq $0, %rax
	je .test_ret_failureIf_94
	movq $21, %rax
	pushq %rax
	movq -8(%rbp), %rax
	popq %rcx
	cmpq %rcx, %rax
	jl .test_ret_successCmp_95
	xorq %rax, %rax
	jmp .test_ret_continueCmp_96
.test_ret_successCmp_95:
	movq $1, %rax
.test_ret_continueCmp_96:
	jmp .test_ret_endIf_93
.test_ret_failureIf_94:
	movq $0, %rax
.test_ret_endIf_93:
	cmpq $0, %rax
	je .test_ret_failureIf_98
	movq $151, %rax
	jmp .test_ret_endFunction_90 	# return reached : end function
	jmp .test_ret_endIf_97
.test_ret_failureIf_98:
.test_ret_endIf_97:
	movq -8(%rbp), %rax
	pushq %rax
	movq $20, %rax
	popq %rcx
	cmpq %rcx, %rax
	jl .test_ret_successCmp_99
	xorq %rax, %rax
	jmp .test_ret_continueCmp_100
.test_ret_successCmp_99:
	movq $1, %rax
.test_ret_continueCmp_100:
	cmpq $0, %rax
	je .test_ret_failureIf_102
	movq $51, %rax
	jmp .test_ret_endFunction_90 	# return reached : end function
	jmp .test_ret_endIf_101
.test_ret_failureIf_102:
.test_ret_endIf_101:
	movq $42, %rax
	jmp .test_ret_endFunction_90 	# return reached : end function
.test_ret_endFunction_90:
	movq %rbp, %rsp
	popq %rbp
	popq %r15	# restoring callee-saved registers
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	retq
.globl id_1
 id_1:
	pushq %rbx	# saving callee-saved registers
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	pushq %rbp	# base pointer
	movq %rsp, %rbp
	pushq %rdi	# saving argument number 1 on the stack
	movq $1, %rax
	pushq %rax
	movq -8(%rbp), %rax
	popq %rcx
	addq %rcx, %rax
	jmp .id_1_endFunction_103 	# return reached : end function
.id_1_endFunction_103:
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
	pushq %rdi	# saving argument number 1 on the stack
	pushq %rsi	# saving argument number 2 on the stack
	subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller-saved registers
	pushq %r11
	xorq %rax, %rax
	callq test_ordre
	popq %r10	# retrieve caller-saved registers
	popq %r11
	addq $8, %rsp	# to restore the stack alignment
	subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller-saved registers
	pushq %r11
	xorq %rax, %rax
	callq test_fact
	popq %r10	# retrieve caller-saved registers
	popq %r11
	addq $8, %rsp	# to restore the stack alignment
	subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller-saved registers
	pushq %r11
	xorq %rax, %rax
	callq test_n_dim
	popq %r10	# retrieve caller-saved registers
	popq %r11
	addq $8, %rsp	# to restore the stack alignment
	subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq $151, %rax
	pushq %rax
	subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq $11, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	xorq %rax, %rax
	callq test_ret
	popq %r10	# retrieve caller-saved registers
	popq %r11
	addq $8, %rsp	# to restore the stack alignment
	popq %rcx
	cmpq %rcx, %rax
	je .main_successCmp_105
	xorq %rax, %rax
	jmp .main_continueCmp_106
.main_successCmp_105:
	movq $1, %rax
.main_continueCmp_106:
	cmpq $0, %rax
	je .main_failureIf_108
	movq $.string_33, %rax
	jmp .main_endIf_107
.main_failureIf_108:
	movq $.string_34, %rax
.main_endIf_107:
	pushq %rax	# putting argument number 2 on the stack
	movq $.string_27, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	popq %rsi	# putting argument number 2 in register
	xorq %rax, %rax
	callq printf
	cltq
	popq %r10	# retrieve caller-saved registers
	popq %r11
	addq $8, %rsp	# to restore the stack alignment
	subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller-saved registers
	pushq %r11
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq $11, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	xorq %rax, %rax
	callq test_ret
	popq %r10	# retrieve caller-saved registers
	popq %r11
	pushq %rax	# putting argument number 3 on the stack
	movq $151, %rax
	pushq %rax	# putting argument number 2 on the stack
	movq $.string_30, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	popq %rsi	# putting argument number 2 in register
	popq %rdx	# putting argument number 3 in register
	xorq %rax, %rax
	callq printf
	cltq
	popq %r10	# retrieve caller-saved registers
	popq %r11
	addq $8, %rsp	# to restore the stack alignment
	subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq $.string_36, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	xorq %rax, %rax
	callq printf
	cltq
	popq %r10	# retrieve caller-saved registers
	popq %r11
	addq $8, %rsp	# to restore the stack alignment
	subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq $51, %rax
	pushq %rax
	subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq $21, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	xorq %rax, %rax
	callq test_ret
	popq %r10	# retrieve caller-saved registers
	popq %r11
	addq $8, %rsp	# to restore the stack alignment
	popq %rcx
	cmpq %rcx, %rax
	je .main_successCmp_109
	xorq %rax, %rax
	jmp .main_continueCmp_110
.main_successCmp_109:
	movq $1, %rax
.main_continueCmp_110:
	cmpq $0, %rax
	je .main_failureIf_112
	movq $.string_33, %rax
	jmp .main_endIf_111
.main_failureIf_112:
	movq $.string_34, %rax
.main_endIf_111:
	pushq %rax	# putting argument number 2 on the stack
	movq $.string_27, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	popq %rsi	# putting argument number 2 in register
	xorq %rax, %rax
	callq printf
	cltq
	popq %r10	# retrieve caller-saved registers
	popq %r11
	addq $8, %rsp	# to restore the stack alignment
	subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller-saved registers
	pushq %r11
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq $21, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	xorq %rax, %rax
	callq test_ret
	popq %r10	# retrieve caller-saved registers
	popq %r11
	pushq %rax	# putting argument number 3 on the stack
	movq $51, %rax
	pushq %rax	# putting argument number 2 on the stack
	movq $.string_30, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	popq %rsi	# putting argument number 2 in register
	popq %rdx	# putting argument number 3 in register
	xorq %rax, %rax
	callq printf
	cltq
	popq %r10	# retrieve caller-saved registers
	popq %r11
	addq $8, %rsp	# to restore the stack alignment
	subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq $.string_36, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	xorq %rax, %rax
	callq printf
	cltq
	popq %r10	# retrieve caller-saved registers
	popq %r11
	addq $8, %rsp	# to restore the stack alignment
	subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq $42, %rax
	pushq %rax
	subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq $2, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	xorq %rax, %rax
	callq test_ret
	popq %r10	# retrieve caller-saved registers
	popq %r11
	addq $8, %rsp	# to restore the stack alignment
	popq %rcx
	cmpq %rcx, %rax
	je .main_successCmp_113
	xorq %rax, %rax
	jmp .main_continueCmp_114
.main_successCmp_113:
	movq $1, %rax
.main_continueCmp_114:
	cmpq $0, %rax
	je .main_failureIf_116
	movq $.string_33, %rax
	jmp .main_endIf_115
.main_failureIf_116:
	movq $.string_34, %rax
.main_endIf_115:
	pushq %rax	# putting argument number 2 on the stack
	movq $.string_27, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	popq %rsi	# putting argument number 2 in register
	xorq %rax, %rax
	callq printf
	cltq
	popq %r10	# retrieve caller-saved registers
	popq %r11
	addq $8, %rsp	# to restore the stack alignment
	subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller-saved registers
	pushq %r11
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq $2, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	xorq %rax, %rax
	callq test_ret
	popq %r10	# retrieve caller-saved registers
	popq %r11
	pushq %rax	# putting argument number 3 on the stack
	movq $42, %rax
	pushq %rax	# putting argument number 2 on the stack
	movq $.string_30, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	popq %rsi	# putting argument number 2 in register
	popq %rdx	# putting argument number 3 in register
	xorq %rax, %rax
	callq printf
	cltq
	popq %r10	# retrieve caller-saved registers
	popq %r11
	addq $8, %rsp	# to restore the stack alignment
	subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq $.string_36, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	xorq %rax, %rax
	callq printf
	cltq
	popq %r10	# retrieve caller-saved registers
	popq %r11
	addq $8, %rsp	# to restore the stack alignment
	subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq $3, %rax
	pushq %rax
	subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller-saved registers
	pushq %r11
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq $1, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	xorq %rax, %rax
	callq id_1
	popq %r10	# retrieve caller-saved registers
	popq %r11
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	xorq %rax, %rax
	callq id_1
	popq %r10	# retrieve caller-saved registers
	popq %r11
	addq $8, %rsp	# to restore the stack alignment
	popq %rcx
	cmpq %rcx, %rax
	je .main_successCmp_117
	xorq %rax, %rax
	jmp .main_continueCmp_118
.main_successCmp_117:
	movq $1, %rax
.main_continueCmp_118:
	cmpq $0, %rax
	je .main_failureIf_120
	movq $.string_33, %rax
	jmp .main_endIf_119
.main_failureIf_120:
	movq $.string_34, %rax
.main_endIf_119:
	pushq %rax	# putting argument number 2 on the stack
	movq $.string_32, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	popq %rsi	# putting argument number 2 in register
	xorq %rax, %rax
	callq printf
	cltq
	popq %r10	# retrieve caller-saved registers
	popq %r11
	addq $8, %rsp	# to restore the stack alignment
	subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller-saved registers
	pushq %r11
	pushq %r10	# save caller-saved registers
	pushq %r11
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq $1, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	xorq %rax, %rax
	callq id_1
	popq %r10	# retrieve caller-saved registers
	popq %r11
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	xorq %rax, %rax
	callq id_1
	popq %r10	# retrieve caller-saved registers
	popq %r11
	pushq %rax	# putting argument number 3 on the stack
	movq $3, %rax
	pushq %rax	# putting argument number 2 on the stack
	movq $.string_35, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	popq %rsi	# putting argument number 2 in register
	popq %rdx	# putting argument number 3 in register
	xorq %rax, %rax
	callq printf
	cltq
	popq %r10	# retrieve caller-saved registers
	popq %r11
	addq $8, %rsp	# to restore the stack alignment
	subq $8, %rsp	# to align the stack on a 16B boundary
	pushq %r10	# save caller-saved registers
	pushq %r11
	movq $.string_36, %rax
	pushq %rax	# putting argument number 1 on the stack
	popq %rdi	# putting argument number 1 in register
	xorq %rax, %rax
	callq printf
	cltq
	popq %r10	# retrieve caller-saved registers
	popq %r11
	addq $8, %rsp	# to restore the stack alignment
	jmp .main_endFunction_104 	# return reached : end function
.main_endFunction_104:
	movq %rbp, %rsp
	popq %rbp
	popq %r15	# restoring callee-saved registers
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	retq
