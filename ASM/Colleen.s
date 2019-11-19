global start
; outside comment

section .bss
	prefix:	resb 5
	buff:	resb 1024

section .text
start:
	; inside comment
	lea		rdi, [rel prefix]	; copy tab db space quote to prefix
	lea		rsi, [rel db_quot]
	mov		rcx, 5
	cld
	repne movsb

	push	rbx					; align stack and call function
	call	_write_source_block
	pop		rbx

	mov		rax, 0x02000001		; exit 0
	xor		rdi, rdi
	syscall

_write_source_block:
	lea		r8, [rel source_code]	; r8 will keep track of our location in the source code

	write_line:
		lea		rdi, [rel buff]			; copy source code line to buffer
		mov		rsi, r8
		mov		rdx, 11					; (track strlen + 11 in rdx)
		loop:
			movsb
			inc		rdx
			cmp		byte [rsi], 10
			jne		loop
		mov		r8, rsi

		lea		rsi, [rel quot_endl]	; copy quote comma space ten
		mov		rcx, 6
		cld
		repne movsb

		mov		rax, 0x02000004			; write
		mov		rdi, 1
		lea		rsi, [rel prefix]
		syscall

		inc		r8						; advance to next line
		cmp		byte [r8], 0
		jne		write_line
	ret

section .data
	db_quot: db 9, 100, 98, 32, 34
	quot_endl: db 34, 44, 32, 49, 48, 10
	source_code:
	db "global start", 10
	db "...", 10
	db "section .data", 10
	db 0
