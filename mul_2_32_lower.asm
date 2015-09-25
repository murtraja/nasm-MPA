;=====================
; program to compute * and
; display only the lower bits
; 32 bit
;=====================

section .data
newLine db 10

n1 dd 00000010h
n2 dd 00111111h
result dd 0
msg1 db "The multiplication : ", 10
len1 equ $-msg1
global _start

section .text

_start:

mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, len1
int 80h

mov eax, [n1]
mov ebx, [n2]
mul ebx
mov [result], eax
mov esi, result	
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

mov eax, 4
mov ebx, 1
mov ecx, result
mov edx, 8
int 80h

mov eax, 4
mov ebx, 1
mov ecx, newLine
mov edx, 1
int 80h

mov eax, 1
mov ebx, 0
int 80h
