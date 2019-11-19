;
;; Colleen
;
global start
 
section .bss
	prefix:	resb 5
	buff:	resb 1024
 
section .text
start:
	; inside comment
	mov		rax, 0x02000004		; write first part of source code
	mov		rdi, 1
	lea		rsi, [rel source_code]
	mov		rdx, 1342
	syscall
	
	lea		rdi, [rel prefix]	; copy tab db space quote to prefix
	lea		rsi, [rel db_quot]
	mov		rcx, 5
	cld
	repne movsb
	
	push	rbx					; align stack and call function
	call	_write_source_block
	pop		rbx
	
	mov		rax, 0x02000004		; write last line of source code
	mov		rdi, 1
	lea		rsi, [rel db_zero]
	mov		rdx, 6
	syscall
	
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
	db_zero: db 9, 100, 98, 32, 48, 10
	source_code:
	db ";", 10
	db ";; Colleen", 10
	db ";", 10
	db "global start", 10
	db " ", 10
	db "section .bss", 10
	db "	prefix:	resb 5", 10
	db "	buff:	resb 1024", 10
	db " ", 10
	db "section .text", 10
	db "start:", 10
	db "	; inside comment", 10
	db "	mov		rax, 0x02000004		; write first part of source code", 10
	db "	mov		rdi, 1", 10
	db "	lea		rsi, [rel source_code]", 10
	db "	mov		rdx, 1342", 10
	db "	syscall", 10
	db "	", 10
	db "	lea		rdi, [rel prefix]	; copy tab db space quote to prefix", 10
	db "	lea		rsi, [rel db_quot]", 10
	db "	mov		rcx, 5", 10
	db "	cld", 10
	db "	repne movsb", 10
	db "	", 10
	db "	push	rbx					; align stack and call function", 10
	db "	call	_write_source_block", 10
	db "	pop		rbx", 10
	db "	", 10
	db "	mov		rax, 0x02000004		; write last line of source code", 10
	db "	mov		rdi, 1", 10
	db "	lea		rsi, [rel db_zero]", 10
	db "	mov		rdx, 6", 10
	db "	syscall", 10
	db "	", 10
	db "	mov		rax, 0x02000001		; exit 0", 10
	db "	xor		rdi, rdi", 10
	db "	syscall", 10
	db " ", 10
	db "_write_source_block:", 10
	db "	lea		r8, [rel source_code]	; r8 will keep track of our location in the source code", 10
	db "	", 10
	db "	write_line:", 10
	db "		lea		rdi, [rel buff]			; copy source code line to buffer", 10
	db "		mov		rsi, r8", 10
	db "		mov		rdx, 11					; (track strlen + 11 in rdx)", 10
	db "		loop:", 10
	db "			movsb", 10
	db "			inc		rdx", 10
	db "			cmp		byte [rsi], 10", 10
	db "			jne		loop", 10
	db "		mov		r8, rsi", 10
	db "		", 10
	db "		lea		rsi, [rel quot_endl]	; copy quote comma space ten", 10
	db "		mov		rcx, 6", 10
	db "		cld", 10
	db "		repne movsb", 10
	db "		", 10
	db "		mov		rax, 0x02000004			; write", 10
	db "		mov		rdi, 1", 10
	db "		lea		rsi, [rel prefix]", 10
	db "		syscall", 10
	db "		", 10
	db "		inc		r8						; advance to next line", 10
	db "		cmp		byte [r8], 0", 10
	db "		jne		write_line", 10
	db "	ret", 10
	db " ", 10
	db "section .data", 10
	db "	db_quot: db 9, 100, 98, 32, 34", 10
	db "	quot_endl: db 34, 44, 32, 49, 48, 10", 10
	db "	db_zero: db 9, 100, 98, 32, 48, 10", 10
	db "	source_code:", 10
	db 0
