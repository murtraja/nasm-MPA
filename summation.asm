;=====================
; program to simply add
; the 8 digit nos and display
; 32 bit
;=====================

section .data
summation dq 0
array dd 5,8,24,3,0
size db 5
newLine db 10
msg1 db "The addition is:",10
len1 equ $-msg1
global _start
section .text
_start:
nop
mov eax, 1
mov esi, array
mov eax, 0
mov cl, byte [size]
do:
add eax, [esi]
add esi, 4
dec cl
jnz do

mov [summation], eax
mov esi, summation
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
mov ecx, msg1
mov edx, len1
int 80h

mov eax, 4
mov ebx, 1
mov ecx, summation
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
