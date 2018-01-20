bits 32

global start        

extern exit
import exit msvcrt.dll

segment data use32 class=data
    ;a - dword
    ;b,c - byte
    ;x - qword
    a dd 10
    b db 6
    c db 4
    x dq 20
segment code use32 class=code
    start:
        ;(a+b)/(2-b*b + b/c)-x
        ;(16)/(2-36+1)-20
        ;16/-33 - 20
        ;-20
        mov AL, [b]
        cbw
        mov DX, 0
        cwd
        push DX
        push AX
        pop EAX
        add EAX, [a]
        push EAX;(a+b) on the stack
        
        mov AX, 0
        mov AL, [b]
        imul byte[b]
        mov BX, 2
        sub BX, AX
        ;bx = 2 - b*b
        ;b/c
        mov AX, 0
        mov AL, [b]
        idiv byte[c]
        cbw
        ;AX = b/c
        add AX, BX
        cwd;EAX is (2-b*b+b/c)
        push DX
        push AX
        pop EBX;EBX = -33
        pop EAX
        mov EDX, 0
        idiv EBX
        cdq
        sub EAX, dword[x]
        sbb EDX, [x+4]
        ;EDX:EAX - ECX:EBX
        
        push dword 0
        call [exit]