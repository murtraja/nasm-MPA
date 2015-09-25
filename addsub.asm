;=====================
; program to compute and display
; addition and subtraction of two
; 8 digit hardcoded nos (w/o carry)
; 32 bit
;=====================

section .data

newLine db 10

n1 dd 90000000h
n2 dd 20000000h
result dq 0
msg1 db "The addition : ", 10
len1 equ $-msg1

msg2 db "The subtraction : ", 10
len2 equ $-msg2

global _start
section .text

convert:
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
ret

%macro printResult 0
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
%endmacro

_start:

mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, len1
int 80h

mov eax, [n1]
mov ebx, [n2]
add eax, ebx
call convert
printResult

mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, len2
int 80h

mov eax, [n1]
mov ebx, [n2]
sub eax, ebx
call convert
printResult

mov eax, 1
mov ebx, 0
int 80h
