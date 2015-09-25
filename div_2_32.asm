;=====================
; program to compute and display
; / and % of two h/c 8 digit nos.
; 32 bit
;=====================

section .data

msg1 db "The division : ", 10
len1 equ $-msg1
newLine db 10

divisor dd 0x10
dividend dd 0xffffffff
section .bss
quotient resb 8
remainder resb 8
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

_start:

mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, len1
int 80h

mov edx, 0			; in order for div instruction to work properly, edx must be set to 0
mov eax, dword [dividend]
mov ebx, dword [divisor]
div ebx

; now quotient is in eax
; and remainder is in edx
mov esi, quotient
call converter

mov esi, remainder
mov eax, edx
call converter

mov eax, 4
mov ebx, 1
mov ecx, quotient
mov edx, 8
int 80h

mov eax, 4
mov ebx, 1
mov ecx, newLine
mov edx, 1
int 80h

mov eax, 4
mov ebx, 1
mov ecx, remainder
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


