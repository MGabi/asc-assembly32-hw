bits 32

global start        

extern exit
import exit msvcrt.dll

segment data use32 class=data
    
    a db 5
    b dw 3
    c dd 6
    d dq 4
    
segment code use32 class=code
    start:
        ;(a+b-d)+(a-b-d) = 2 = 2h
        ;4 + (-2)
        ;unsigned
        mov AL, [a];        AL = 5 = 5h (a)
        mov AH, 0;          AH = 0 = 0h, AX = 5 = 5h
        add AX, [b];        AX = 8 = 8h (a+b)
        mov DX, 0;          DX = 0 = 0h
        push DX ;           DX = 0 = 0h
        push AX ;           AX = 8 = 8h
        pop EAX ;           EAX = 8 = 8h
        mov EDX, 0 ;        EDX = 0 = 0h
        ;                   EDX:EAX = 8 = 8h
        ;                   ECX:EBX will be [d]
        mov EBX, dword[d] ; EBX = 4 = 4h
        mov ECX, [d+4] ;    ECX = 0 = 0h
        sub EAX, EBX ;      EAX = 4 = 4h
        sbb EDX, ECX ;      EDX = 0 = 0h
        ;                   EDX:EAX = (a+b-d) = 4 = 4h
        mov ECX, 0 ;        ECX = 0 = 0h
        mov EBX, 0 ;        EBX = 0 = 0h
        mov BL, [a] ;       BL = 5 = 5h
        ;                   EDX:EAX = 4 = 4h
        ;                   ECX:EBX = 5 = 5h
        add EAX, EBX ;      EAX = 9 = 9h
        adc EDX, ECX ;      EDX = 0 = 0h
        mov EBX, 0 ;        EBX = 0 = 0h
        mov ECX, 0 ;        ECX = 0 = 0h
        mov BX, [b] ;       BX = 3 = 3h
        sub EAX, EBX ;      EAX = 6 = 6h
        sbb EDX, ECX ;      EDX = 0 = 0h
        mov EBX, 0 ;        EBX = 0 = 0h
        mov ECX, 0 ;        ECX = 0 = 0h
        mov EBX, dword[d] ; EBX = 4 = 4h
        mov ECX, [d+4] ;    ECX = 0 = 0h
        sub EAX, EBX ;      EAX = 2 = 2h
        sbb EDX, ECX ;      EDX = 0 = 0h
        
        ;resetting them
        mov EAX, 0
        mov EBX, 0
        mov ECX, 0
        mov EDX, 0
        
        ;signed
        ;(a+b-d)+(a-b-d) = 2 = 2h
        mov AL, [a];        AL = 5 = 5h (a)
        cbw;                AX = 5 = 5h
        add AX, [b];        AX = 8 = 8h (a+b)
        cwd;                DX:AX = 8
        push DX ;           DX = 0 = 0h
        push AX ;           AX = 8 = 8h
        pop EAX ;           EAX = 8 = 8h
        mov EDX, 0 ;        EDX = 0 = 0h
        ;                   EDX:EAX = 8 = 8h
        ;                   ECX:EBX will be [d]
        mov EBX, dword[d] ; EBX = 4 = 4h
        mov ECX, [d+4] ;    ECX = 0 = 0h
        sub EAX, EBX ;      EAX = 4 = 4h
        sbb EDX, ECX ;      EDX = 0 = 0h
        ;                   EDX:EAX = (a+b-d) = 4 = 4h
        mov ECX, 0 ;        ECX = 0 = 0h
        mov EBX, 0 ;        EBX = 0 = 0h
        push EDX
        push EAX
        mov EDX, 0
        mov EAX, 0
        ;                   (a+b-d)+(a-b-d) = 2 = 2h
        ;                   on the stack, EDX:EAX is the first paranthesis
        mov AL, [a];        AL = 5 = 5h
        cbw;                AX = 5 = 5h
        sub AX, [b];        AX = 2 = 2h   
        cwde;               EAX = 2 = 2h
        cdq
        ;                   EDX = 0 = 0h
        mov EBX, dword[d] ; EBX = 4 = 4h
        mov ECX, [d+4] ;    ECX = 0 = 0h
        sub EAX, EBX;       EAX = -2
        sbb EDX, ECX;       EDX = 0
        pop EBX
        pop ECX
        add EBX, EAX
        adc ECX, EDX;       ECX:EBX = 2 = 2h
                    
        
        
        
        
        