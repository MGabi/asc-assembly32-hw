bits 32

global start        

extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    a dw 12h, 3h, 0fh, 0ffh
    d db 88h, 0Ah, 12h
    b dw 8, 5, 3, -4, -8
    c dd 573A8FEh
    n db 0
    m db 0
    msj db "Octetul de pe pozitia M este: ", 0
    fmt db "%d", 10, 13, 0
    fmt2 db "%x", 10, 13, 0
    fmts db "%s", 10, 13

segment code use32 class=code
    start:
        mov eax, 00000000000000000000000011110000b
        and eax, [c]
        mov [n], eax; n = 1111 1000b
        mov ebx, 00000000111100000000000000000000b
        and ebx, [c]
        shr ebx, 20; ebx = 0x0111b
        shl bl, 1
        or [n], bl
        
        mov al, 0
        mov al, [n]; n = 1111 1110b
        cbw
        cwde
        
        push eax
        push fmt
        call [printf]
        add esp, 4*2
        
        mov eax, [n]
        mov [m], eax
        
        not byte[m]
        add byte[m], 1
        add byte[m], 2
        mov eax, 0
        mov al, [m]
        cbw
        cwde
        
        push dword eax
        push fmt
        call [printf]
        add esp, 4*2
        
        mov eax, [m]
        add eax, a
        
        mov ebx, [eax]
        and ebx, 00000000000000000000000000001111b
        push ebx
        
        push fmt2
        call [printf]
        add esp, 4*2
        
        mov eax, 0
        mov ebx, 0
        mov ecx, 0
        mov edx, 0
        
        mov ecx, n-a
        mov edx, 0
        repeta:
        loop repeta
        
        push dword 0
        call [exit]