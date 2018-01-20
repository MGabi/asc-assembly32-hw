bits 32
global baza
extern printf
import printf msvcrt.dll

; segment data use32 class=data public

    ; formatd db "%d ",0
    ; red dd 0
    

segment code use32 class=code public
    baza:
        mov ebx, [esp+4]
        mov eax, esp
        add eax, 8
        push eax
        push ebx
        call [printf]
        add esp, 4*2
        ret

        
        
        