bits 32

global start        

extern exit
import exit msvcrt.dll

segment data use32 class=data
    A dd 00001010100011011001101010101010b
    B dd 0
    a dw 0001110011010101b
    b dw 0100100101111001b
    c dd 0
    
segment code use32 class=code
    start:
        ;PB 14
        ;nr intreg reprezentat de bitii 14-17 ai lui A: 0110 = 6
        mov EAX, 0
        mov EAX, [A]; EAX = 00001010100011011001101010101010b
        ;        00001010100011011001101010101010b
        and EAX, 00000000000000111100000000000000b
        ;   EAX= 00000000000000011000000000000000b
        shr EAX, 14; EAX = 00000000000000000000000000000110b = 6 - acesta este numarul natural format din bitii 14-17 ai lui A
        
        
        ;rotirea spre stanga cu N pozitii, n = 8
        mov EBX, 0
        mov EBX, [A]; EBX = 00001010100011011001101010101010b = 177052330
        mov CL, AL
        rol EBX, CL; EBX =   10001101100110101010101000001010b = 2375723530
        mov [B], EBX
        
        
        
        
        ; PB 2
        ; Se dau cuvintele A si B. Se cere dublucuvantul C:
        ; bitii 0-3 ai lui C coincid cu bitii 5-8 ai lui B done
        ; bitii 4-8 ai lui C coincid cu bitii 0-4 ai lui A done
        ; bitii 9-15 ai lui C coincid cu bitii 6-12 ai lui A done
        ; bitii 16-31 ai lui C coincid cu bitii lui B done
        
        mov EAX, 0
        mov EBX, 0
        mov ECX, 0
        mov EDX, 0
        
        mov EAX, dword[b];                            EAX = 00000000000000000100100101111001b
        and EAX, 00000000000000000000000111100000b
        ;   EAX =                                           00000000000000000000000101100000b
        shr EAX, 5 ;                                  EAX = 00000000000000000000000000001011b
        or [c], EAX ; [c] =                                 00000000000000000000000000001011b
        mov EAX, 0
        mov EAX, dword[a] ;                           EAX = 00000000000000000001110011010101b
        and EAX, 00000000000000000000000000011111b
        ;                                             EAX = 00000000000000000000000000010101b
        shl EAX, 4 ;                                  EAX = 00000000000000000000000101010000b
        or [c], EAX;                                  [c] = 00000000000000000000000101011011b   
        mov EAX, 0
        mov EAX, dword[a];                            EAX = 00000000000000000001110011010101b
        and EAX, 00000000000000000001111111000000b;   EAX = 00000000000000000001110011000000b
        shl EAX, 3;                                   EAX = 00000000000000001110011000000000b
        ;                                       old   [c] = 00000000000000000000000101011011b
        or [c], EAX;                            new   [c] = 00000000000000001110011101011011b
        mov EAX, 0
        mov EAX, dword[b] ;                            EAX = 00000000000000000100100101111001b
        shl EAX, 16 ;                                 EAX = 01001001011110010000000000000000b
        or [c], EAX ;                                 [c] = 01001001011110011110011101011011b
        mov EBX, 0
        mov EBX, [c]
        
        
        
        push dword 0
        call [exit]