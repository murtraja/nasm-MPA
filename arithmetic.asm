;=====================
; program to compute and display
; *,/,+ and - of 2 h/c 8 digit nos
; 32 bit
;=====================

section .data
newLine db 10

n1 dd 00123450h
n2 dd 00000010h
temp dd 0
result dq 0
msg1 db "The multiplication : ", 10
len1 equ $-msg1

msg2 db "The division : ", 10
len2 equ $-msg2

msg3 db "Quotient: "
len3 equ $-msg3

msg4 db "Remainder: "
len4 equ $-msg4

msg5 db "Addition: ",10
len5 equ $-msg5

msg6 db "Subtraction: ",10
len6 equ $-msg6

global _start

section .text

convert:
mov esi, result
mov cl, 8
	
	rotate:
	rol eax, 4
	mov bl, al
	and bl, 0fh
	cmp bl, 09h
	jbe add30
	add bl, 07h
	
	add30:
	add bl, 30h
	mov [esi], bl	
	inc esi
	dec cl
	jnz rotate
ret

%macro printResult 0
mov eax, 4
mov ebx, 1
mov ecx, result
mov edx, 8
int 80h

mov eax, 4
mov ebx, 1
mov ecx, newLine
mov edx, 1
int 80h

mov eax, 4
mov ebx, 1
mov ecx, newLine
mov edx, 1
int 80h
%endmacro

_start:
nop
mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, len1
int 80h

multiply:
mov eax, [n1]
mul dword [n2]

mov [temp], eax		; saving the lower word to temp

mov eax, edx
call convert		; converting higher word

mov eax, 4
mov ebx, 1
mov ecx, result
mov edx, 8
int 80h 		; printing it

mov eax, [temp]		; retrieving lower word from temp

call convert		; converting lower word
printResult		; printing it



mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, len2
int 80h

mov eax, 4
mov ebx, 1
mov ecx, msg3
mov edx, len3
int 80h

mov edx, 0			; in order for div instruction to work properly, edx must be set to 0
mov eax, dword [n1]
mov ebx, dword [n2]
div ebx

; now quotient is in eax
; and remainder is in edx
mov [temp], edx			; saving the remainder in temp
call convert			; converting the quotient
printResult			; printing it



mov eax, 4
mov ebx, 1
mov ecx, msg4
mov edx, len4
int 80h


mov eax, [temp]			; retrieving remainder from temp
call convert			; converting the remainder
printResult			; printing it

mov eax, 4
mov ebx, 1
mov ecx, msg5
mov edx, len5
int 80h

mov eax, [n1]
mov ebx, [n2]
add eax, ebx
call convert
printResult

mov eax, 4
mov ebx, 1
mov ecx, msg6
mov edx, len6
int 80h

mov eax, [n1]
mov ebx, [n2]
sub eax, ebx
call convert
printResult

exit:
mov eax, 1
mov ebx, 0
int 80h


