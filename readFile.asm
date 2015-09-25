;=====================
; program to display 
; file info
; 32 bit
;=====================

section .data

msg1 db "Opening File |file.txt|", 10
len1 equ $-msg1

msg2 db "File descriptor: "
len2 equ $-msg2

msg3 db "The contents of the file are displayed:",10
len3 equ $-msg3

msg4 db "Error opening file",10
len4 equ $-msg4

msg5 db "Successfully opened the file",10
len5 equ $-msg5

msg6 db "No. of bytes read from the file are: ",10
len6 equ $-msg6

fileName db "file.txt",0

newLine db 10
fd db 0
bytesRead dd 0

section .bss
buffer resb 25
temp resb 8
global _start

section .text

convert8:
mov cl, 8
rotate1:
	rol eax, 4
	mov bl, al
	and bl, 0fh
	cmp bl, 9
	jbe add301
	add bl, 7
add301:
	add bl, 30h
	mov [esi], bl
	inc esi
	dec cl
	jnz rotate1
ret

convert2:
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

%macro print 2
mov eax, 4
mov ebx, 1
mov ecx, %1
mov edx, %2
int 80h
%endmacro

%macro bufferSize 0
1000
%endmacro

_start:

print msg1, len1
;first we need to open the file
mov eax, 5			; 5 stands for sys_open() sytem call
mov ebx, fileName		; putting filename in ebx
mov ecx, 0			; file access mode
mov edx, 0x777			; file permissions
int 80h

mov [fd], eax			; storing file descriptor
mov esi, temp			; storing the file descriptor in temp
call convert8
print msg2, len2		
print temp,8			; displaying the file descriptor
print newLine, 1

mov eax, [fd]			; loading file descriptor
cmp eax, 0			; checking fd<0 then error
jbe error
jmp success			; if fd>0 success

error:				; print error message and exit
print msg4, len4
jmp exit


success:

print msg5, len5
; then we need to display the contents of the file
print msg6, len6
mov eax, 3			; read system call
mov ebx, [fd]			; file descriptor
mov ecx, buffer			; storing data of file to buffer
mov edx, 1000			; read 1000 bytes
int 80h
; now eax has the no. of bytes read
mov dword [bytesRead], eax
mov esi, temp			
call convert8			; converting it and printing it
print temp,8
print newLine, 1

print msg3, len3
print buffer, dword [bytesRead]

;closing the file
mov eax, 6			; 6 stands for closing file
mov ebx, [fd]			; ebx has file descriptor		
int 80h

exit:
mov eax, 1
mov ebx, 0
int 80h
