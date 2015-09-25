;=====================
; program to take console input
; and display the same (8 char)
; 64 bit
;=====================

section .data
global _start
section .bss
value resd 1
section .text
_start:
mov rax, 0
mov rdi, 1
mov rsi, value
mov rdx, 9
syscall

mov rax, 1
mov rdi, 1
mov rsi, value
mov rdx, 9
syscall


mov rax, 60
mov rdi, 0
syscall
