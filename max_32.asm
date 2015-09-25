;=====================
; program to print the max of given nos
; 32 bit
;=====================

section .data
max dq 0
array dd 5,16,10,2,0
msg1 db "The max no is:",10
len1 equ $-msg1
newLine db 10
global _start
section .text

_start:
mov esi, array		;using esi to hold array's address
mov eax, [esi]		;assuming first element is max
mov cl, 4		;looping for 4 more elements

check:
add esi, 4		;moving to the next element
cmp [esi], eax		
jbe noswap		;if [esi]<=max, then no swap
mov eax, [esi]		;if [esi]>max, then swap

noswap:			
dec cl
jnz check

mov dword[max], eax

convert:
mov esi, max
mov eax, [max]
mov cl,8

rotate:
	rol eax, 4
	mov bl, al
	and bl, 0Fh
	cmp bl, 9
	jbe add30
	add bl, 7
	add30:
	add bl, 30h
	mov [esi], bl
	inc esi
	dec cl
	jnz rotate

printing:
mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, len1
int 80h

mov eax, 4
mov ebx, 1
mov ecx, max
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