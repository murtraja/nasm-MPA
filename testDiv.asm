section .data
dividend dd 23
divisor dd 7
global _start
section .text
_start:
nop
mov eax, [dividend]
mov ebx, [divisor]
div ebx
;works perfectly
mov eax, 1
mov ebx, 0
int 80h
