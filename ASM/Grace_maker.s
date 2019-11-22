%define code2_str "start: db 0x68, 0x02, 0x02, 0, 0"
%deftok code2_tok code2_str

%macro code 0
code2_tok
;start:
;	push	514				; open Grace_kid.s
;	db 0x68, 0x02, 0x02, 0, 0
	push	dword child
	mov		eax, 5
	push	eax
	int		0x80
	add		esp, 12

	push	dword plen		; write prefix
	push	dword prefix
	push	dword eax
	sub		esp, 4
	mov		eax, 4
	int		0x80

	mov		dword [esp + 12], 12		; write code string
	mov		dword [esp + 8], code3
	mov		eax, 4
	int		0x80

	mov		dword [esp + 12], slen		; write suffix
	mov		dword [esp + 8], suffix
	mov		eax, 4
	int		0x80

	add		esp, 16			; clean stack

	push	dword 42		; sys exit
	mov		eax, 1
	push	eax
	int		0x80

	; fake data section
	child: db "Grace_kid.s", 0
	prefix: db "%define gs global start", 10, "%define code_str ", 34
	plen equ $ - prefix
	suffix: db 34, 10, "%deftok code_tok code_str", 10, 10, 103, 115, 10, "code2", 10
	slen equ $ - suffix
	code3: db "start: db 42"
%endmacro

%define gs global start
%define code_str "abcdef"
%deftok code_tok code_str

;0x68 02 02 00 00 68 62 00 00 00 b8 05 00 00 00 50
;0xcd 80 83 c4 0c 6a 2a 68 6e 00 00 00 50 83 ec 04
;0xb8 04 00 00 00 cd 80 c7 44 24 0c 0c 00 00 00 c7
;0x44 24 08 c5 00 00 00 b8 04 00 00 00 cd 80 c7 44
;0x24 0c 2d 00 00 00 c7 44 24 08 98 00 00 00 b8 04
;0x00 00 00 cd 80 83 c4 10 6a 2a b8 01 00 00 00 50
;0xcd 80 47 72 61 63 65 5f 6b 69 64 2e 73 00 25 64
;0x65 66 69 6e 65 20 67 73 20 67 6c 6f 62 61 6c 20
;0x73 74 61 72 74 0a 25 64 65 66 69 6e 65 20 63 6f
;0x64 65 5f 73 74 72 20 22 22 0a 25 64 65 66 74 6f
;0x6b 20 63 6f 64 65 5f 74 6f 6b 20 63 6f 64 65 5f
;0x73 74 72 0a 0a 67 73 0a 73 74 61 72 74 3a 20 64
;0x62 20 34 32 0a 73 74 61 72 74 3a 20 64 62 20 34
;0x32


gs
code
