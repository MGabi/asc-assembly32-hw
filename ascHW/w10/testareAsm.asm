bits 32

global start        

extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    a times 3 dw 10 
    b dd 0xAB 
segment code use32 class=code
    start:
        stc
       sbb al, al
       div bh
    
    push dword 0
        call [exit] 