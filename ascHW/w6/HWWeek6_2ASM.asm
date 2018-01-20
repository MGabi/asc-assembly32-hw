bits 32

global start        

extern exit, scanf, printf
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    a db 0
    aa dd 0
    b db 0
    bb dd 0, 0, 0
    messageA db "a = ", 0
    messageB db "b = ", 0
    messageN db 10, 13, 0
    messageH db "h", 0
    messageD db " decimal", 0
    formatD db "%d", 0 ; signed decimal
    formatX db "%x", 0 ; unsigned hexa
    formatS db "%s", 0 ; string
    
segment code use32 class=code
    start:
    ;A part
        ;print "a = "
        push dword messageA
        push dword formatS
        call [printf]
        add ESP, 4*2
        
        ;read A as SIGNED DECIMAL
        push dword a
        push dword formatD
        call [scanf]
        add ESP, 4*2
        
        mov AL, [a]
        cbw
        cwde
        mov [aa], EAX
        
        ;print "a = "
        push dword messageA
        push dword formatS
        call [printf]
        add ESP, 4*2
        
        ;printing the result as HEXA
        push dword [aa]
        push dword formatX
        call [printf]
        add ESP, 4*2
        
        ;print h
        push dword messageH
        push dword formatS
        call [printf]
        add ESP, 4*2
        
        ;print newline
        push dword messageN
        push dword formatS
        call [printf]
        add ESP, 4*2
        
    ;B part
        
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
        
        mov AL, [b]
        cbw
        cwde
        mov [bb], EAX
        
        ;print "b = "
        push dword messageB
        push dword formatS
        call [printf]
        add ESP, 4*2
        
        ;printing the result as DECIMAL
        push dword [bb]
        push dword formatD
        call [printf]
        add ESP, 4*2
        
        ;print newline
        push dword messageN
        push dword formatS
        call [printf]
        add ESP, 4*2
        
        mov EAX, [aa]
        add EAX, [bb]

        ;printing A+B as decimal
        push dword EAX
        push dword formatD
        call [printf]
        add ESP, 4*2
        
        ;print d
        push dword messageD
        push dword formatS
        call [printf]
        add ESP, 4*2
        
        push dword 0
        call [exit]