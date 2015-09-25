;=====================
; program to simulate
; user login with password
; 32 bit
;=====================

;Name: Murtaza Raja		Title: Password implementation
;Batch: H1
;Roll No. 2177
;Assg No. C24

ICANON      equ 1<<1
    ECHO        equ 1<<3

    sys_exit    equ 1
    sys_read    equ 3
    sys_write   equ 4
    stdin       equ 0
    stdout      equ 1
  
   global _start
    
    section     .data
    szAsterisk  db  "*"
     beep       db 07
	beeplen db 01
msg db 10,"Enter password",10
msglen equ $-msg

msg1 db 10,"Re-enter password",10
msglen1 equ $-msg1

notequal db 10,"Acess is not granted",10
notequallength equ $-notequal
    
equal db 10,"ACCESS IS GRANTED",10
equallength equ $-equal


section     .bss
    lpBufIn     resb    2
    PassIn    resb    24
    Passtest    resb    24
    termios     resb    36 
    lengthin     resd    24
    lengthtest   resd   24

%macro print 2
	mov     edx,  %2                 
        mov     ecx, %1              
        mov     eax, sys_write   
        mov     ebx, stdout             
        int     80H    
%endmacro 

    section .text
    _start:
   print msg,msglen    
        call    echo_off
        call    canonical_off 

   
  xor     esi, esi
    GetCode:    
        cmp     esi, 24
        je      PassTooBig
        
        call    GetKeyCode
        mov     al, byte[lpBufIn]
        cmp al,'Q'
	je Done
	cmp     al, 10
        je      Continue

        mov     byte [PassIn + esi], al
        call    PrintAsterisk
        inc     esi
        jmp     GetCode
    
   Continue:
        mov     byte [PassIn + esi], 10    ; change 10 to 0 to null terminate

	mov dword [lengthin],esi
     

;############## Reenter password#######################

print msg1, msglen1                
       
        xor     esi, esi
     GetCode1:
        cmp     esi, 24
        je      PassTooBig
        
        call    GetKeyCode
        mov     al, byte[lpBufIn]
        cmp     al, 10
        je      Continue1

        mov     byte [Passtest + esi], al
        call    PrintAsterisk
        inc     esi
        jmp     GetCode1
    
   Continue1:
        mov     byte [Passtest + esi], 10    ; change 10 to 0 to null terminate

	mov dword [lengthtest],esi
   ;####################Compare password length ########################     
  


   	 mov ebx,[lengthin]
	cmp ebx, [lengthtest]
	je Compare
	print notequal, notequallength
	jmp Done

;###################Compare password:#################;
Compare:
	mov esi, PassIn
	mov edi,Passtest
	mov ecx,[lengthtest]

	cld
	repe cmpsb
	jz equal1
	print notequal, notequallength
	jmp Done

equal1:
	print equal,equallength
	;print beep,beeplen


 PassTooBig:
        
    Done:
        call    echo_on
        call    canonical_on

        mov     eax, sys_exit
        xor     ebx, ebx
        int     80H
        
    ;~ #########################################
    GetKeyCode: 
        mov     eax, sys_read
        mov     ebx, stdin
        mov     ecx, lpBufIn
        mov     edx, 1
        int     80h
        ret
    
    ;~ ######################################### 
    PrintAsterisk:	
        mov     edx, 1
        mov     ecx, szAsterisk
        mov     eax, sys_write
        mov     ebx, stdout
        int     80H     
        ret		        
        
    ;~ #########################################
    canonical_off:
            call read_stdin_termios

            ; clear canonical bit in local mode flags
            mov eax, ICANON
            not eax
            and [termios+12], eax

            call write_stdin_termios
            ret
            
    ;~ #########################################
    echo_off:
            call read_stdin_termios

            ; clear echo bit in local mode flags
            mov eax, ECHO
            not eax
            and [termios+12], eax

            call write_stdin_termios
            ret

    ;~ #########################################
    canonical_on:
            call read_stdin_termios

            ; set canonical bit in local mode flags
            or dword [termios+12], ICANON

            call write_stdin_termios
            ret

    ;~ #########################################
    echo_on:
            call read_stdin_termios

            ; set echo bit in local mode flags
            or dword [termios+12], ECHO

            call write_stdin_termios
            ret

    ;~ #########################################
    read_stdin_termios:
            mov eax, 36h
            mov ebx, stdin
            mov ecx, 5401h
            mov edx, termios
            int 80h
            ret

    ;~ #########################################
    write_stdin_termios:
            mov eax, 36h
            mov ebx, stdin
            mov ecx, 5402h
            mov edx, termios
            int 80h
            ret


