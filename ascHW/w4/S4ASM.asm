bits 32

global start        

extern exit
import exit msvcrt.dll

segment data use32 class=data
    a dw 0010110100110101b
    b dw 0000000000000000b
    c dd 00000000000000000000000000000000b
    bb db 00000000b
    
segment code use32 class=code
    start:
        ;A- word
        ;sa se obtina nr intreg reprezentat de bitii 0-2 ai lui A
        
        ;sa se obtina in B cuvantul rezultat prin rotirea spre dreapta
        ;fara carry a bitilor lui A cu `n` pozitii.
        
        ;sa se obtina dublucuvantul C: bitii 8-15 ai lui C sunt 0
        ;bitii 16-23 ai lui C coincid cu bitii 7-14 ai lui A
        ;24-31 ai lui C coincid cu bitii 7-14 ai lui A
        ;bitii 0-7 ai lui C sunt 1
        ;      
        ;EAX = 00000000000000000000000011111111b
        mov CX, 0000000000000111b
        mov BX, word[a] ; BX = 0000000000110101b
        and BX, CX;       BX = 0000000000000101b - numarul format din bitii 0-2 ai lui A-
        
        mov CX, [a];  CX    = 0010110100110101b
        mov [b], CX; [b]    = 0010110100110101b
        shr word[b], 3;  [b]    = 0000010110100110b - in B este valoarea bitilor lui A shiftati spre dreapta cu 3 biti
        
        ;bitii 7-14 ai lui A sunt : 01011010
        mov EAX, 0; EAX = 00000000000000000000000000000000b, in EAX se construieste C
        
        ;bitii 8-15 ai lui C sunt 0
        and AH, 00000000b
        
        ;bitii 16-23 ai lui C sunt bitii 7-14 ai lui A
        mov ECX, 0
        mov CX, [a]
        and CX, 0111111110000000b; ECX = 00000000000000000010110100000000
        shl ECX, 9 ;               ECX = 00000000010110100000000000000000
        or EAX, ECX;               EAX = 00000000010110100000000000000000
        
        ;next: bitii 24-31 ai lui C coincid cu bitii 7-14 ai lui A
        shl ECX, 8 ;               ECX = 01011010000000000000000000000000
        or EAX, ECX ;              EAX = 01011010010110100000000000000000
        mov AL, 11111111b ;        EAX = 01011010010110100000000011111111
        
        
        
        mov EAX, 0
        mov ECX, 0
        ;problema 10.
        ;sa se inlocuiasca bitii 0-3 ai octetului B cu bitii 8-11 a cuvantului A
        mov CX, [a]
        and CX, 0000111100000000b
        shr CX, 8
        or AX, CX; in CX este rezultatul
        
        push dword 0
        call [exit]