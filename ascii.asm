;=====================
; program to print a h/c 8 digit no
; by converting it to ascii
; 32 bit
;=====================

section .data
msg db "The no. after ascii conversion is: "
len equ $-msg
msgexit db "The program will now exit"
lenexit equ $-msgexit

newline db 10
num dd 100000d0h
global _start

section .text
_start:
mov esi, num
mov eax, dword[num]
mov cl, 08h
up:
	rol eax, 4
	mov bl, al
	and bl, 0fh
	cmp bl, 09h
	jbe next
add bl, 07h
next:
	add bl, 30h
	mov [esi], bl
	inc esi
	dec cl
	jnz up
display:
	
	
	mov eax, 4
	mov ebx, 1
	mov ecx, msg
	mov edx, len
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, 1
	int 80h	

	mov eax, 4
	mov ebx, 1
	mov ecx, num
	mov edx, 8
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, 1
	int 80h	

	mov eax, 4
	mov ebx, 1
	mov ecx, msgexit
	mov edx, lenexit
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, newline
	mov edx, 1
	int 80h	
exit:
	mov eax, 1
	mov ebx, 0
	int 80h
