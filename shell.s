	.file	"AnarchyFoxyShell.c"
	.text
	.section	.rodata
	.align 8
.LC0:
	.string	"    __    _  _    __    ____   ___  _   _  _  _    ____  _____  _  _  _  _ "
	.align 8
.LC1:
	.string	"   /__\\  ( \\( )  /__\\  (  _ \\ / __)( )_( )( \\/ )  ( ___)(  _  )( \\/ )( \\/ )"
	.align 8
.LC2:
	.string	"  /(__)\\  )  (  /(__)\\  )   /( (__  ) _ (  \\  /    )__)  )(_)(  )  (  \\  / "
	.align 8
.LC3:
	.string	" (__)(__)(_)\\_)(__)(__)(_)\\_) \\___)(_) (_) (__)   (__)  (_____)(_/\\_) (__)  "
	.align 8
.LC4:
	.string	"   ___  _   _  ____  __    __   "
	.align 8
.LC5:
	.string	" / __)( )_( )( ___)(  )  (  )  "
	.align 8
.LC6:
	.string	" \\__ \\ ) _ (  )__)  )(__  )(__ "
	.align 8
.LC7:
	.string	" (___/(_) (_)(____)(____)(____)"
	.text
	.globl	displayLogo
	.type	displayLogo, @function
displayLogo:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$.LC0, %edi
	call	puts
	movl	$.LC1, %edi
	call	puts
	movl	$.LC2, %edi
	call	puts
	movl	$.LC3, %edi
	call	puts
	movl	$.LC4, %edi
	call	puts
	movl	$.LC5, %edi
	call	puts
	movl	$.LC6, %edi
	call	puts
	movl	$.LC7, %edi
	call	puts
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	displayLogo, .-displayLogo
	.section	.rodata
.LC8:
	.string	" \t\n\r\f\013"
	.text
	.globl	parseCommand
	.type	parseCommand, @function
parseCommand:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$152, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -136(%rbp)
	movq	%rsi, -144(%rbp)
	movq	%rdx, -152(%rbp)
	movq	-136(%rbp), %rdx
	leaq	-128(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcpy
	movl	$0, -28(%rbp)
	leaq	-128(%rbp), %rax
	movl	$.LC8, %esi
	movq	%rax, %rdi
	call	strtok
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rdx
	movq	-144(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcpy
	jmp	.L3
.L4:
	movl	$.LC8, %esi
	movl	$0, %edi
	call	strtok
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	je	.L3
	movl	-28(%rbp), %eax
	leal	1(%rax), %edx
	movl	%edx, -28(%rbp)
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-152(%rbp), %rax
	leaq	(%rdx,%rax), %rbx
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	strdup
	movq	%rax, (%rbx)
.L3:
	cmpq	$0, -24(%rbp)
	jne	.L4
	movl	-28(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-152(%rbp), %rax
	addq	%rdx, %rax
	movq	$0, (%rax)
	nop
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	parseCommand, .-parseCommand
	.section	.rodata
.LC9:
	.string	"exit"
.LC10:
	.string	"Anarchy Foxy Says Goodbye!"
.LC11:
	.string	"Fork error"
.LC12:
	.string	"Command execution error"
	.text
	.globl	executeCommand
	.type	executeCommand, @function
executeCommand:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	-24(%rbp), %rax
	movl	$.LC9, %esi
	movq	%rax, %rdi
	call	strcmp
	testl	%eax, %eax
	jne	.L6
	movl	$.LC10, %edi
	call	puts
	movl	$0, %edi
	call	exit
.L6:
	call	fork
	movl	%eax, -4(%rbp)
	cmpl	$0, -4(%rbp)
	jns	.L7
	movl	$.LC11, %edi
	call	perror
	jmp	.L10
.L7:
	cmpl	$0, -4(%rbp)
	jne	.L9
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	execvp
	movl	$.LC12, %edi
	call	perror
	movl	$1, %edi
	call	exit
.L9:
	movl	-4(%rbp), %eax
	movl	$0, %edx
	movl	$0, %esi
	movl	%eax, %edi
	call	waitpid
.L10:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	executeCommand, .-executeCommand
	.section	.rodata
.LC13:
	.string	"\nAnarchy Foxy Shell :> "
.LC14:
	.string	"\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB9:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$304, %rsp
	movl	$0, %eax
	call	displayLogo
.L14:
	movl	$.LC13, %edi
	movl	$0, %eax
	call	printf
	movq	stdin(%rip), %rdx
	leaq	-112(%rbp), %rax
	movl	$100, %esi
	movq	%rax, %rdi
	call	fgets
	leaq	-112(%rbp), %rax
	movl	$.LC14, %esi
	movq	%rax, %rdi
	call	strcspn
	movb	$0, -112(%rbp,%rax)
	leaq	-304(%rbp), %rdx
	leaq	-224(%rbp), %rcx
	leaq	-112(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	parseCommand
	leaq	-304(%rbp), %rdx
	leaq	-224(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	executeCommand
	movl	$0, -4(%rbp)
	jmp	.L12
.L13:
	movl	-4(%rbp), %eax
	cltq
	movq	-304(%rbp,%rax,8), %rax
	movq	%rax, %rdi
	call	free
	movl	-4(%rbp), %eax
	cltq
	movq	$0, -304(%rbp,%rax,8)
	addl	$1, -4(%rbp)
.L12:
	movl	-4(%rbp), %eax
	cltq
	movq	-304(%rbp,%rax,8), %rax
	testq	%rax, %rax
	jne	.L13
	jmp	.L14
	.cfi_endproc
.LFE9:
	.size	main, .-main
	.ident	"GCC: (SUSE Linux) 13.1.1 20230720 [revision 9aac37ab8a7b919a89c6d64bc7107a8436996e93]"
	.section	.note.GNU-stack,"",@progbits
