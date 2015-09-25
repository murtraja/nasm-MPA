;=====================
; program to compute and display
; * of two h/c 8 digit nos
; 32 bit
;=====================

section .data
newLine db 10

n1 dd 2345678h
n2 dd 10h
resultL dq 0
resultH dq 0
msg1 db "The multiplication : ", 10
len1 equ $-msg1
global _start

section .text
firstProc:
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
_start:
nop
mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, len1
int 80h

multiply:
mov eax, [n1]
mul dword [n2]
;mov [resultL], eax
;mov [resultH], edx



mov esi, resultL	
call firstProc

mov esi, resultH
mov eax, edx
call firstProc

cmp edx, 0
je printResultL
printResultH:
mov eax, 4
mov ebx, 1
mov ecx, resultH
mov edx, 8
int 80h

printResultL:
mov eax, 4
mov ebx, 1
mov ecx, resultL
mov edx, 8
int 80h

mov eax, 4
mov ebx, 1
mov ecx, newLine
mov edx, 1
int 80h

exit:
mov eax, 1
mov ebx, 0
int 80h


