;=====================
; program to add 2 hardcoded
; 8 digit nos and display
; the result (no carry)
; 32 bit
;=====================


section .data


newLine db 10

n1 dd 90100000h
n2 dd 02f00000h
msg1 db "The addition : ", 10
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
add eax, ebx
mov [n1], eax
mov esi, n1
mov eax, dword[n1]	
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
mov ecx, n1
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
