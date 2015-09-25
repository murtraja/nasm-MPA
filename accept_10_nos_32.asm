;=====================
; program to simply take ten <=8 digit nos
; and display them
; 32 bit
;=====================

section .data
msg1 db "enter ten numbers:",10
len1 equ $-msg1
msg2 db "The entered nos are:",10
len2 equ $-msg2
counter db 10
 
section .bss
num resd 10

global _start
section .text
_start:
mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, len1
int 80h

mov esi, num
read:
	
	mov eax, 3
	mov ebx, 1
	mov ecx, esi
	add esi, 9
	int 80h
	dec byte [counter]
	jnz read
beforeDisp:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, len2
	int 80h
	mov esi, num
	mov byte [counter], 10

display:
	mov eax, 4
	mov ebx, 1
	mov ecx, esi
	mov edx, 9
	int 80h
	add esi, 9
	dec byte [counter]
	jnz display

exit:
mov eax, 1
mov ebx, 0
int 80h


