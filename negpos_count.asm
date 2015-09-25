;=====================
; program to count and display
; +ve's, -ve's and 0's
; 32 bit
;=====================

section .data
array dd 7, 3, -1, 0, 4, -6, -10, 0, 12, -32
size db 10
pcount dw 0
ncount dw 0
zcount dw 0
msg1 db "The count of nos. is ",10
len1 equ $-msg1
msg2 db "Negative",10
len2 equ $-msg2
msg3 db "Positive",10
len3 equ $-msg3
msg4 db "Zero",10
len4 equ $-msg4
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

%macro printNewLine 0
mov eax, 4
mov ebx, 1
mov ecx, newLine
mov edx, 1
int 80h
%endmacro

_start:

mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, len1
int 80h

mov esi, array
mov cl, byte[size]

compare:
mov eax, [esi]
cmp eax, 0
jl neg
cmp eax, 0
jg pos

zero:
add byte [zcount], 1
jmp update

neg:
add byte [ncount], 1
jmp update

pos:
add byte [pcount], 1

update:
add esi, 4
dec cl
jnz compare

mov esi, ncount
mov al, [ncount]
call convertTwo

mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, len2
int 80h

mov eax, 4
mov ebx, 1
mov ecx, ncount
mov edx, 2
int 80h

printNewLine


mov esi, zcount
mov al, [zcount]
call convertTwo

mov eax, 4
mov ebx, 1
mov ecx, msg4
mov edx, len4
int 80h

mov eax, 4
mov ebx, 1
mov ecx, zcount
mov edx, 2
int 80h

printNewLine


mov esi, pcount
mov al, [pcount]
call convertTwo

mov eax, 4
mov ebx, 1
mov ecx, msg3
mov edx, len3
int 80h

mov eax, 4
mov ebx, 1
mov ecx, pcount
mov edx, 2
int 80h

printNewLine

exit:
mov eax, 1
mov ebx, 0
int 80h
