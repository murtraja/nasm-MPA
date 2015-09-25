;=====================
; program to print a 
; 2 digit no.
; 32 bit
;=====================

section .data
no db 180
printno dw 0
newLine db 10
global _start
section .text

convertTwo:
; store the value to be printed
; (<256) in al
; then initialize pointer esi
; to a proper word length size memory
; before calling it.
mov cl, 2
rotate:
rol al, 4
mov bl, al
and bl, 0fh
cmp bl, 9
jbe add30
add bl, 7
add30:
add bl, 30h
mov [esi], bl
inc esi
dec cl
jnz rotate
ret

_start:

mov al, [no]
mov esi, printno
call convertTwo

mov eax, 4
mov ebx, 1
mov ecx, printno
mov edx, 2
int 80h

mov eax, 4
mov ebx, 1
mov ecx, newLine
mov edx, 1
int 80h

mov eax, 1
mov ebx, 0
int 80h