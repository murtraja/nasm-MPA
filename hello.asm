;=====================
; program to print
; Hello World
; 32 bit
;=====================

section .data
msg dd "Hello World"
len equ $-msg
global _start
section .text
_start:
mov eax, 4
mov ebx, 1
mov ecx, msg
mov edx, len
int 80h
mov eax, 1
mov ebx, 0
int 80h

