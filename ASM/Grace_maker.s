%define gs global start
%define code_str "start: db 0xe8, 0x79, 0, 0, 0"
%deftok code_tok code_str

gs
; code_tok

start: call start2 ; pushes address of fake data section to stack and jumps past it

; fake data section

child:	db "Grace_kid.s", 0
prefix:	db "%define gs global start", 10, "%define code_str ", 34
suffix:	db 34, 10, "%deftok code_tok code_str", 10, 10, 103, 115, 10, "code_tok", 10
code:	db code_str

; end fake data section (jump to here)
start2:

pop		esi				; save the return address (data address) in esi

push	dword 514		; open file
lea		ebx, [esi]		; filename @ offset 0
push	dword ebx
mov		eax, 5
push	eax
int		0x80
add		esp, 12			; clean stack

push	dword 42		; write prefix
lea		ebx, [esi + 12]	; prefix string @ offset 12
push	dword ebx
push	dword eax
sub		esp, 4
mov		eax, 4
int		0x80			; don't clean stack yet -- we'll be reusing it for more write calls

mov		dword [esp + 12], 12		; write code string
lea		ebx, [esi + 95]				; code string @ offset 95
mov		dword [esp + 8], ebx		; using esp to modify the stack avoids having to pop and push the first two args every time
mov		eax, 4
int		0x80

mov		dword [esp + 12], 41		; write suffix
lea		ebx, [esi + 54]				; suffix string @ offset 54
mov		dword [esp + 8], ebx
mov		eax, 4
int		0x80

add		esp, 16			; clean stack

push	dword 0			; sys exit
mov		eax, 1
push	eax
int		0x80
