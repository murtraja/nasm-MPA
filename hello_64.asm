;=====================
; program to print
; Hello World
; 64 bit
;=====================

section .data
msg dd "Hello World"
len equ $-msg
global _start
section .text
_start:
mov rax, 1
mov rdi, 1
mov rsi, msg
mov rdx, len
syscall
mov rax, 60
mov rdi, 0
syscall

