bits 32

global start        

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a dw 5
    b db 3
    c dw 8
    x dq 60
segment code use32 class=code
    start:
        ;x - (a*100 + b) / (b+c-1)
        ;60 - (500 + 3) / (11 - 1)
        ;60 - 503 / 10
        ;60 - 50
        ;10
        
        ;unsigned
        mov DX, 0;          DX = 0 = 0h
        mov AX, 100;        AX = 100 = 64h
        mul word[a];        DX:AX = 500 = 1F4h
        push DX;            DX on stack
        push AX;            AX on stack
        pop EBX;            EBX = 500 = 1F4h
        mov EAX, 0;         EAX = 0 = 0h
        mov AL, [b];        AL = 3 = 3h
        add EBX, EAX;       EBX = 503 = 1F7h -> EBX = (a*100 + b)
        
        mov EAX, 0;         EAX = 0 = 0h
        mov AL, [b];        AL = 3 = 3h
        mov AH, 0;          AH = 0 = 0h
        ;                   AX = 3 = 3h
        add AX, [c];        AX = 11 = Bh
        sub AX, 1;          AX = 10 = Ah
        mov ECX, EAX;       ECX = 10 = 10h -> ECX = (b+c-1)
        mov EAX, EBX;       EAX = 503 = 1F7h
        mov EDX, 0;         EDX = 0 = 0h
        div ECX;            EAX = 50 = 32h | EDX = 3 = 3h
        mov EDX, 0;         EDX:EAX = 50 = 32h
        mov EBX, 0;         EBX = 0 = 0h
        mov ECX, 0;         ECX = 0 = 0h
        mov EBX, dword[x];  EBX = 60 = 3Ch
        mov ECX, [x+4];     ECX = 0 = 0h
        ;                   ECX:EBX = 60 = 3Ch
        sub EBX, EAX;       EBX = 10 = Ah
        sbb ECX, EDX;       ECX = 0 = 0h
        
        ;resetting them
        mov EAX, 0
        mov EBX, 0
        mov ECX, 0
        mov EDX, 0
        
        ;signed
        ;x - (a*100 + b) / (b+c-1)
        mov AX, 100;        AX = 100 = 64h
        imul word[a];       DX:AX = 500 = 1F4h
        push DX;            DX on stack
        push AX;            AX on stack
        pop EBX;            EBX = 500 = 1F4h
        mov AL, [b];        AL = 3 = 3h
        cbw;                AX = 3 = 3h
        cwde;               EAX = 3 = 3h
        add EBX, EAX;       EBX = 503 = 1F7h -> EBX = (a*100 + b)
        
        mov EAX, 0;         EAX = 0 = 0h
        mov AL, [b];        AL = 3 = 3h
        cbw;                AX = 3 = 3h
        add AX, [c];        AX = 11 = Bh
        sub AX, 1;          AX = 10 = Ah
        cwde;               EAX = 10 = AH
        mov ECX, EAX;       ECX = 10 = 10h -> ECX = (b+c-1)
        mov EAX, EBX;       EAX = 503 = 1F7h
        cdq;                EDX:EAX = 503 = 1F7h
        idiv ECX;           EAX = 50 = 32h | EDX = 3 = 3h
        cdq;                EDX:EAX = 50 = 32h
        mov EBX, 0;         EBX = 0 = 0h
        mov ECX, 0;         ECX = 0 = 0h
        mov EBX, dword[x];  EBX = 60 = 3Ch
        mov ECX, [x+4];     ECX = 0 = 0h
        ;                   ECX:EBX = 60 = 3Ch
        ;                   EDX:EAX = 50 - 32h
        sub EBX, EAX;       EBX = 10 = Ah
        sbb ECX, EDX;       ECX = 0 = 0h
        
        
        push dword 0
        call [exit]