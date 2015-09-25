;=====================
; program to compute and display
; / and % of two h/c 8 digit nos
; w/o setting edx to 0
; 32 bit
;=====================

section .data
msg1 db "Quotient: ",10
len1 equ $-msg1

msg2 db "Remainder: ",10
len2 equ $-msg2

newLine db 10
dividend dd 23
divisor dd 5
counter db 0

section .bss
quot resb 8
remainder resb 8
   global _start
section .text
_start:

mov eax, [dividend]
mov ebx, [divisor]
div ebx
mov esi, quot
mov byte[counter],8

l: rol eax,4
mov ebx, eax
and ebx, 0Fh
cmp ebx, 09h
jbe l1
add ebx, 07h

l1: add ebx,30h
mov [esi],ebx
inc esi
dec byte[counter]
jnz l

mov esi, remainder
mov byte[counter],8

l2: rol edx,4
mov ebx, edx
and ebx, 0Fh
cmp ebx, 09h
jbe l3
add ebx, 07h

l3: add ebx,30h
mov [esi],ebx
inc esi
dec byte[counter]
jnz l2

mov eax,4
mov ebx,1
mov ecx, msg1
mov edx,len1
int 80h


mov eax,4
mov ebx,1
mov ecx, quot
mov edx,8
int 80h

mov eax, 4
mov ebx, 1
mov ecx, newLine
mov edx, 1
int 80h

mov eax,4
mov ebx,1
mov ecx, msg2
mov edx,len2
int 80h

mov eax,4
mov ebx,1
mov ecx, remainder
mov edx,8
int 80h

mov eax, 4
mov ebx, 1
mov ecx, newLine
mov edx, 1
int 80h

mov eax,1
mov ebx,0
int 80h

