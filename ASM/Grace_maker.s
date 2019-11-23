%define gs global start
%define code_str "start: db 0xe8, 0x00, 0x00, 0x00, 0x00, 0x5e, 0x68, 0x02, 0x02, 0x00, 0x00, 0x8d, 0x5e, 0x65, 0x53, 0xb8, 0x05, 0x00, 0x00, 0x00, 0x50, 0xcd, 0x80, 0x83, 0xc4, 0x0c, 0x6a, 0x2a, 0x8d, 0x5e, 0x71, 0x53, 0x50, 0x83, 0xec, 0x04, 0xb8, 0x04, 0x00, 0x00, 0x00, 0xcd, 0x80, 0xc7, 0x44, 0x24, 0x0c, 0xc8, 0x04, 0x00, 0x00, 0x8d, 0x9e, 0xc4, 0x00, 0x00, 0x00, 0x89, 0x5c, 0x24, 0x08, 0xb8, 0x04, 0x00, 0x00, 0x00, 0xcd, 0x80, 0xc7, 0x44, 0x24, 0x0c, 0x29, 0x00, 0x00, 0x00, 0x8d, 0x9e, 0x9b, 0x00, 0x00, 0x00, 0x89, 0x5c, 0x24, 0x08, 0xb8, 0x04, 0x00, 0x00, 0x00, 0xcd, 0x80, 0x83, 0xc4, 0x10, 0x6a, 0x00, 0xb8, 0x01, 0x00, 0x00, 0x00, 0x50, 0xcd, 0x80, 0x47, 0x72, 0x61, 0x63, 0x65, 0x5f, 0x6b, 0x69, 0x64, 0x2e, 0x73, 0x00, 0x25, 0x64, 0x65, 0x66, 0x69, 0x6e, 0x65, 0x20, 0x67, 0x73, 0x20, 0x67, 0x6c, 0x6f, 0x62, 0x61, 0x6c, 0x20, 0x73, 0x74, 0x61, 0x72, 0x74, 0x0a, 0x25, 0x64, 0x65, 0x66, 0x69, 0x6e, 0x65, 0x20, 0x63, 0x6f, 0x64, 0x65, 0x5f, 0x73, 0x74, 0x72, 0x20, 0x22, 0x22, 0x0a, 0x25, 0x64, 0x65, 0x66, 0x74, 0x6f, 0x6b, 0x20, 0x63, 0x6f, 0x64, 0x65, 0x5f, 0x74, 0x6f, 0x6b, 0x20, 0x63, 0x6f, 0x64, 0x65, 0x5f, 0x73, 0x74, 0x72, 0x0a, 0x0a, 0x67, 0x73, 0x0a, 0x63, 0x6f, 0x64, 0x65, 0x5f, 0x74, 0x6f, 0x6b, 0x0a, code_str"
%deftok code_tok code_str

gs
; code_tok

start: call start2 ; push address of process counter to return address
start2:

pop		esi			; save the return address in esi

push	dword 514			; open file
lea		ebx, [esi + 101]	; filename @ offset 101
push	dword ebx
mov		eax, 5
push	eax
int		0x80
add		esp, 12				; clean stack

push	dword 42			; write prefix
lea		ebx, [esi + 113]	; prefix string @ offset 101 + 12
push	dword ebx
push	dword eax
sub		esp, 4
mov		eax, 4
int		0x80				; don't clean stack yet -- we'll be reusing it for more write calls

mov		dword [esp + 12], 1224		; write code string
lea		ebx, [esi + 196]			; code string @ offset 101 + 95
mov		dword [esp + 8], ebx		; using esp to modify the stack avoids having to pop and push the first two args every time
mov		eax, 4
int		0x80

mov		dword [esp + 12], 41		; write suffix
lea		ebx, [esi + 155]			; suffix string @ offset 101 + 54
mov		dword [esp + 8], ebx
mov		eax, 4
int		0x80

add		esp, 16			; clean stack

push	dword 0			; sys exit
mov		eax, 1
push	eax
int		0x80

; fake data section

child:	db "Grace_kid.s", 0
prefix:	db "%define gs global start", 10, "%define code_str ", 34
suffix:	db 34, 10, "%deftok code_tok code_str", 10, 10, 103, 115, 10, "code_tok", 10
code:	db code_str

; otool -t Grace_maker.o | cut -c 10-56 | sed -E "s/(^| )/, 0x/g"
