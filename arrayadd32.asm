;=====================
; program to add 'n' 8 digit nos
; which are stored in an array (w/o carry)
; 32 bit
;=====================

section .data
msg dd "The array addition = "
len equ $-msg
array: dd 00000001h, 00000002h, 00000003h, 00000004h, 00000005h
count db 04h		;to be initialized to 1 less
global _start

section .bss
res resb 8

section .text
_start:

mov eax,4		;print message
mov ebx,1
mov ecx,msg
mov edx,len
int 80h

mov esi,array		;used as pointer to array

     mov eax,[esi]	;addition
next:add esi,04

add eax,[esi]
dec byte[count]
jnz next

mov [res],eax
mov esi,res		;hex-to-ascii convert
mov eax,dword[res]
mov cl,8
up:rol eax,4
   mov bl,al
   and bl,0Fh
   cmp bl,09h
   jbe down
add bl,07h
down:add bl,30h
     mov [esi],bl
     inc esi
     dec cl
     jnz up

mov eax,4		;printing
mov ebx,1
mov ecx,res
mov edx,8
int 80h

mov eax,1
mov ebx,0
int 80h
