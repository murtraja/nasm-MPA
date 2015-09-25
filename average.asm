;=====================
; program to print the sum and average
; of 'n' 8 digit nos. in an array
; 32 bit
;=====================

section .data
summation dq 0
quotient dq 0
remainder dq 0
dividend dd 0
array dd 5,8,24,4,0
size db 5
newLine db 10
msg1 db "The summation is:",10
len1 equ $-msg1
msg2 db "The average is",10,"Quotient:"
len2 equ $-msg2
msg3 db "Remainder:"
len3 equ $-msg3
global _start
section .text

converter:
mov cl, 8
	
	rotate:
	rol eax, 4
	mov bl, al
	and bl, 0fh
	cmp bl, 09h
	jbe add30
	add bl, 07h
	
	add30:
	add bl, 30h
	mov [esi], bl	
	inc esi
	dec cl
	jnz rotate
ret

%macro newLineDisplay 0
mov eax, 4
mov ebx, 1
mov ecx, newLine
mov edx, 1
int 80h
%endmacro

_start:
nop

mov esi, array
mov eax, 0
mov cl, byte [size]
do:
add eax, [esi]
add esi, 4
dec cl
jnz do

mov dword [dividend], eax
mov esi, summation
call converter

mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, len1
int 80h

mov eax, 4
mov ebx, 1
mov ecx, summation
mov edx, 8
int 80h

newLineDisplay

mov ebx, 0
mov bl, byte[size]
mov eax, dword [dividend]
mov edx, 0
div ebx
mov dword[remainder], edx
mov esi, quotient
call converter

mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, len2
int 80h

mov eax, 4
mov ebx, 1
mov ecx, quotient
mov edx, 8
int 80h
newLineDisplay

mov eax, 4
mov ebx, 1
mov ecx, msg3
mov edx, len3
int 80h

mov eax, dword[remainder]
mov esi, remainder
call converter
mov eax, 4
mov ebx, 1
mov ecx, remainder
mov edx, 8
int 80h
newLineDisplay


mov eax, 1
mov ebx, 0
int 80h
