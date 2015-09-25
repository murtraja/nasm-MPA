;=====================
; program to compute and display
; & and | of two h/c 8 digit nos
; 32 bit
;=====================

section .data
number1 dd 0x12345678
number2 dd 0x65573752
resultAND dq 0
resultOR dq 0
msg1 db "number1 AND number2: ",10
len1 equ $-msg1
msg2 db "number1 OR number2: ",10
len2 equ $-msg2
newLine db 10
global _start
section .text

convert:
mov cl, 8
rotate:
rol eax, 4
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

%macro newLineDisplay 0
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

mov eax, dword[number1]
and eax, dword[number2]
mov esi, resultAND
call convert
mov eax, 4
mov ebx, 1
mov ecx, resultAND
mov edx, 8
int 80h
newLineDisplay

mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, len2
int 80h

mov eax, dword[number1]
or eax, dword[number2]
mov esi, resultOR
call convert
mov eax, 4
mov ebx, 1
mov ecx, resultOR
mov edx, 8
int 80h
newLineDisplay

mov eax, 1
mov ebx, 0
int 80h