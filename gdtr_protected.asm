section .data

msg1 db "The limit is",10
len1 equ $-msg1

msg2 db "The base address is", 10
len2 equ $-msg2

msg3 db "We are in protected mode",10
len3 equ $-msg3

newLine db 10

section .bss

gdtreg resb 6		; this is used to store the value of gdtr
limit resb 4		; the lower 2 bytes represent limit
base resb 8		; the higher 4 bytes represent the base address
; note that the reserved size is double, since we need to convert

global _start

section .text

convert8:
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

convert4:
mov cl, 4
up:
	rol ax, 4
	mov bl, al
	and bl, 0fh
	cmp bl, 9
	jbe next
	add bl, 7
next:
	add bl, 30h
	mov [esi], bl
	inc esi
	dec cl
	jnz up
ret

%macro print 2
mov eax, 4
mov ebx, 1
mov ecx, %1
mov edx, %2
int 80h
%endmacro

_start:
nop
smsw ax			; moving the contents of machine status word into eax
bt ax, 0		; checking the 0th bit, result is stored in carry
jc protected		; if carry is 1 go to protected

protected:
print msg3, len3

sgdt [gdtreg]
print msg1, len1
mov ax, word [gdtreg]	; move the limit to the ax register
mov esi, limit		; necessary to call convert
call convert4
print limit, 4		; print limit
print newLine, 1

print msg2, len2


mov esi, gdtreg
add esi, 2		; skip the limit go to base address (MSBs)
mov eax, dword [esi]	; copy base address to eax
mov esi, base		; required for conversion
call convert8
print base, 8
print newLine, 1

mov eax, 1
mov ebx, 0
int 80h
