global start

section .data
db 0

section .text
start:
	db	0xb8, 0x04, 0x00, 0x00, 0x02		; mov	rax, 0x02000004
	db	0xbf, 0x01, 0x00, 0x00, 0x00		; mov rdi, 1
	db	0x48, 0x8d, 0x35, 0xe2, 0xff, 0xff, 0xff	;	lea rsi, -30
	db	0xba, 0x0d, 0x00, 0x00, 0x00		; mov rdx, 13
	db	0x0f, 0x05							; syscall
	db	0xb8, 0x01, 0x00, 0x00, 0x02		; mov	rax, 0x02000001
	db	0x0f, 0x05							; syscall