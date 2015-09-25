;=====================
; program to compute and display
; the length of the entered string
; (max 15 char)
; 32 bit
;=====================

section .data

msg1 db "Enter the string whose length is to be calculated: ",10
len1 equ $-msg1

msg2 db "The length of the string is: ",10
len2 equ $-msg2

newLine db 10

textLength db 0



section .bss
textInput: resb 30
global _start

section .text

%macro newLineDisplay 0
	mov eax, 4
	mov ebx, 1
	mov ecx, newLine
	mov edx, 1
	int 80h
%endmacro

_start:


mov esi, textInput

mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, len1
int 80h

mov eax, 3
mov ebx, 1
mov ecx, textInput
mov edx, 30
int 80h

newLineDisplay

mov eax, 4
mov ebx,1
mov ecx, msg2
mov edx, len2
int 80h

;this code calculates the length
mov esi, textInput
jmp calculate
incrementer: 
	add esi,1
	add byte [textLength], 1

calculate:
	cmp byte [esi], 10
	jne incrementer

;this code converts textLength into ascii
cmp byte [textLength], 09h
jbe add30
add byte [textLength],07h
add30:
add byte [textLength], 30h

; print the value of textLength
mov eax, 4
mov ebx, 1
mov ecx, textLength
mov edx, 1
int 80h

newLineDisplay

;this is exit call
mov eax, 1
mov ebx, 0
int 80h


