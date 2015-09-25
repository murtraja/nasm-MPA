section .data
msg1: db "GDTR contents are:",10
len1: equ $-msg1
msg2: db "IDTR contents are:",10
len2: equ $-msg2
msg3: db "LDTR contents are:",10
len3: equ $-msg3
colon: db ":"
len  : equ $-colon
msgr: db "We are in Real mode....",10
lenr: equ $-msgr
msgp: db "We are in Protected  mode....",10
lenp:equ $-msgp
newline db 10

section .bss
GDTR :resw 3
IDTR :resw 3
LDTR: resw 1
count: resb 10
cr0_content:resw 1

%macro print 2       ;macro defination for write
mov eax,4
mov ebx,1
mov ecx,%1
mov edx,%2
int 80h
%endmacro          ;end of macro definition


section .text
global _start
_start:

;smsw eax   reading CR0
;bt eax,0   checking 0th bit
;jc Protected  if carry set.ie. in protected mode

;Real:    real mode
;print msgr, lenr
;jmp GDT

;Protected:  protected mode
;print msgp, lenp
;and eax,0    making 0th bit 0
;jnc Real     switching to real mode


GDT:
sgdt [GDTR]        ;storing contents of gdtr in GDTR variable

print msg1, len1   ;macro calling
mov ax,[GDTR+4]    
call rotate        ;procedure calling
print count, 4

mov ax,[GDTR+2]
call rotate
print count, 4
print colon, len

mov ax,[GDTR]
call rotate
print count, 4
print newline,1

IDT:
sidt [IDTR]       ;storing contents of idtr in IDTR variable
print msg2, len2

mov ax,[IDTR+4]
call rotate
print count, 4

mov ax,[IDTR+2]
call rotate
print count, 4
print colon, len

mov ax,[IDTR]
call rotate
print count, 4
print newline,1

LDT:
sldt [LDTR]       ;storing contents of ldtr in LDTR variable
print msg3, len3
mov ax,[LDTR]
call rotate
print count, 4
print newline,1

Exit:             ;exit code
mov eax,1
mov ebx,0
int 80h


;conversion
rotate:           ;procedure definition
mov ecx,04
mov esi,count
up:
rol ax,4
mov bl,al
and bl,0fh
cmp bl,09h
jbe next
add bl,07h
next:
add bl,30h
mov [esi],bl
inc esi
dec cl
jnz up
ret              ;returing from procedure

