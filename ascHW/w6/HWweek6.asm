bits 32

global start        

extern exit
extern printf
extern scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data

    a dd 0
    b dd 0
    c dd 0
    messageA db "a = ", 0
    messageB db "b = ", 0
    formatS db "%s", 0 ; string
    formatD db "%d", 0 ; signed decimal
    formatU db "%u", 0 ; unsigned decimal
    formatX db "%x", 0 ; unsigned hexa

segment code use32 class=code
    start:
        ;print "a = "
        push dword messageA
        push dword formatS
        call [printf]
        add ESP, 4*2
        
        ;read A as HEXA
        push dword a
        push dword formatX
        call [scanf]
        add ESP, 4*2
        
        ;print "b = "
        push dword messageB
        push dword formatS
        call [printf]
        add ESP, 4*2
        
        ;read B as HEXA
        push dword b
        push dword formatX
        call [scanf]
        add ESP, 4*2
        
        ;make the addition
        mov EAX, 0
        add EAX, [a]
        add EAX, [b]
        mov [c], EAX
        
        ;printing the result as DECIMAL
        push dword [c]
        push dword formatD
        call [printf]
        add ESP, 4*2
        
        push dword 0
        call [exit]