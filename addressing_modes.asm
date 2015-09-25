;=====================
; program to show various
; addressing modes
; 32 bit
;=====================

section .data
; printing the same value everytime
; but with different addressing modes
number db 50h, 51h, 52h, 53h, 54h
print dw 0
newLine db 10
msg1 db "Immediate Addressing:", 10
len1 equ $-msg1
msg2 db "Register Addressing:", 10
len2 equ $-msg2
msg3 db "Register Indirect Addressing:", 10
len3 equ $-msg3
msg4 db "Register Relative Addressing:", 10
len4 equ $-msg4
msg5 db "Base plus Index", 10
len5 equ $-msg5
msg6 db "Scaled Index", 10
len6 equ $-msg6
msg7 db "Base relative plus index", 10
len7 equ $-msg7
global _start
section .text

convertTwo:
; store the value to be printed
; (<256) in al
; then initialize pointer esi
; to a proper word length size memory
; before calling it.
mov cl, 2
mov esi, print
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

%macro printPrint 0
mov eax, 4
mov ebx, 1
mov ecx, print
mov edx, 2
int 80h
printNewLine
%endmacro

_start:

mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, len1
int 80h

mov al, 53h		; immediate addressing
call convertTwo
printPrint

mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, len2
int 80h

mov bl, byte[number]
mov al, bl		; register addressing
call convertTwo
printPrint


mov eax, 4
mov ebx, 1
mov ecx, msg3
mov edx, len3
int 80h

mov esi, number		; direct addressing
mov al, byte[esi]	; register indirect addressing
call convertTwo
printPrint

mov eax, 4
mov ebx, 1
mov ecx, msg4
mov edx, len4
int 80h

mov esi, number
mov al, byte[esi+1]	; register relative addressing
call convertTwo
printPrint

mov eax, 4
mov ebx, 1
mov ecx, msg5
mov edx, len5
int 80h

mov esi, number
mov ebx, esi
mov esi, 3
mov al, [ebx+esi]	;base plus index addressing
call convertTwo
printPrint

mov eax, 4
mov ebx, 1
mov ecx, msg6
mov edx, len6
int 80h

mov esi, number
mov ebx, esi
mov esi, 1
mov al, byte [ebx+(4*esi)]	;scaled index addressing
call convertTwo
printPrint


mov eax, 4
mov ebx, 1
mov ecx, msg7
mov edx, len7
int 80h

mov ebx, number
mov esi, 1
mov al, [ ebx + esi + 1]		;base-relative plus index addressing
call convertTwo
printPrint

mov eax, 1
mov ebx, 0
int 80h
