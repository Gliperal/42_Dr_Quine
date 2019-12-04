global start

section .text
i equ 5
argv_1: db "/bin/zsh", 0
argv_2: db "-c", 0

section .data
argv_3: db "chmod 644 Sully_X.s && /nfs/2017/n/nwhitlow/.brew/Cellar/nasm/2.14.02/bin/nasm -f macho64 Sully_X.s && ld Sully_X.o -o Sully_X && ./Sully_X", 0
file: db "Sully_X.s", 0
source_code: db "global startNNsection .textNi equ 5Nargv_1: db Q/bin/zshQ, 0Nargv_2: db Q-cQ, 0NNsection .dataNargv_3: db Qchmod 644 Sully_X.s && /nfs/2017/n/nwhitlow/.brew/Cellar/nasm/2.14.02/bin/nasm -f macho64 Sully_X.s && ld Sully_X.o -o Sully_X && ./Sully_XQ, 0Nfile: db QSully_X.sQ, 0Nsource_code: db QNsource_code_len equ $ - source_codeNNsection .bssNargv: resb 32Nsource_code_replace: resb 2009NNsection .textNstart:N	mov		al, iN	cmp		al, 0		; check for exitN	jle		exitNN	; Replace Sully_X with Sully_(i-1)N	mov		al, iN	add		al, 47N	lea		rdi, [rel file]N	mov		byte [rdi + 6], alN	lea		rdi, [rel argv_3]N	mov		byte [rdi + 16], alN	mov		byte [rdi + 96], alN	mov		byte [rdi + 112], alN	mov		byte [rdi + 125], alN	mov		byte [rdi + 138], alNN	; replace source code special charactersN	lea		rdi, [rel source_code_replace]N	lea		rsi, [rel source_code]N	mov		rcx, source_code_lenN	loop:N		movsbN		cmp		byte [rsi-1], 78		; replace capital n becomes newlineN			jne		fooN			mov		byte [rdi-1], 10N		foo:N		cmp		byte [rsi-1], 81		; replace capital q becomes quoteN			jne		barN			mov		byte [rdi-1], 34N		bar:N		dec		rcxN		cmp		rcx, 0N		jg		loopNN	; decriment i in source code to be writtenN	lea		rdi, [rel source_code_replace]N	mov		byte [rdi + 34], alNN	; open fileN	lea		rdi, [rel file]N	mov		rsi, 514N	mov		rax, 0x02000005N	syscallNN	; write source codeN	mov		rdi, raxNN	lea		rsi, [rel source_code_replace]N	mov		rdx, 292N	mov		rax, 0x02000004N	syscallN	lea		rsi, [rel source_code]N	mov		rdx, source_code_lenN	mov		rax, 0x02000004N	syscallN	lea		rsi, [rel source_code_replace]N	add		rsi, 291N	mov		rdx, 1795N	mov		rax, 0x02000004N	syscallNN	; close fileN	mov		rax, 0x02000006N	syscallNN	; build argv (null terminated array of c strings)N	lea		rdi, [rel argv]N	lea		rsi, [rel argv_1]N	mov		[rdi], rsiN	lea		rsi, [rel argv_2]N	mov		[rdi + 8], rsiN	lea		rsi, [rel argv_3]N	mov		[rdi + 16], rsiN	mov		byte [rdi + 24], 0NN	; call execve to run /bin/bash to compileN	lea		rdi, [rel argv_1]N	lea		rsi, [rel argv]N	mov		rdx, 0N	mov		rax, 0x0200003bN	syscallNN	exit:N	mov		rax, 0x02000001N	xor		rdi, rdiN	syscallN"
source_code_len equ $ - source_code

section .bss
argv: resb 32
source_code_replace: resb 2009

section .text
start:
	mov		al, i
	cmp		al, 0		; check for exit
	jle		exit

	; Replace Sully_X with Sully_(i-1)
	mov		al, i
	add		al, 47
	lea		rdi, [rel file]
	mov		byte [rdi + 6], al
	lea		rdi, [rel argv_3]
	mov		byte [rdi + 16], al
	mov		byte [rdi + 96], al
	mov		byte [rdi + 112], al
	mov		byte [rdi + 125], al
	mov		byte [rdi + 138], al

	; replace source code special characters
	lea		rdi, [rel source_code_replace]
	lea		rsi, [rel source_code]
	mov		rcx, source_code_len
	loop:
		movsb
		cmp		byte [rsi-1], 78		; replace capital n becomes newline
			jne		foo
			mov		byte [rdi-1], 10
		foo:
		cmp		byte [rsi-1], 81		; replace capital q becomes quote
			jne		bar
			mov		byte [rdi-1], 34
		bar:
		dec		rcx
		cmp		rcx, 0
		jg		loop

	; decriment i in source code to be written
	lea		rdi, [rel source_code_replace]
	mov		byte [rdi + 34], al

	; open file
	lea		rdi, [rel file]
	mov		rsi, 514
	mov		rax, 0x02000005
	syscall

	; write source code
	mov		rdi, rax

	lea		rsi, [rel source_code_replace]
	mov		rdx, 292
	mov		rax, 0x02000004
	syscall
	lea		rsi, [rel source_code]
	mov		rdx, source_code_len
	mov		rax, 0x02000004
	syscall
	lea		rsi, [rel source_code_replace]
	add		rsi, 291
	mov		rdx, 1795
	mov		rax, 0x02000004
	syscall

	; close file
	mov		rax, 0x02000006
	syscall

	; build argv (null terminated array of c strings)
	lea		rdi, [rel argv]
	lea		rsi, [rel argv_1]
	mov		[rdi], rsi
	lea		rsi, [rel argv_2]
	mov		[rdi + 8], rsi
	lea		rsi, [rel argv_3]
	mov		[rdi + 16], rsi
	mov		byte [rdi + 24], 0

	; call execve to run /bin/bash to compile
	lea		rdi, [rel argv_1]
	lea		rsi, [rel argv]
	mov		rdx, 0
	mov		rax, 0x0200003b
	syscall

	exit:
	mov		rax, 0x02000001
	xor		rdi, rdi
	syscall
