;=====================
; program to simulate
; the signum function
; 32 bit
;=====================

section .data
no dd 7
msg1 db "The no. is "
len1 equ $-msg1
msg2 db "Negative",10
len2 equ $-msg2
msg3 db "Positive",10
len3 equ $-msg3
msg4 db "Zero",10
len4 equ $-msg4
global _start
section .text
_start:

mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, len1
int 80h
mov eax, [no]
cmp eax, 0
jl neg
cmp eax, 0
jg pos

zero:
mov eax, 4
mov ebx ,1
mov ecx, msg4
mov edx, len4
int 80h
jmp exit

neg:
mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, len2
int 80h
jmp exit

pos:
mov eax, 4
mov ebx, 1
mov ecx, msg3
mov edx, len3
int 80h

exit:
mov eax, 1
mov ebx, 0
int 80h
