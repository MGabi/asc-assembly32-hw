bits 32

global start        

extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    fmts db "%s", 0, 0, 0
    fmtc db "%c", 0, 0, 0
    s1 db '+', '4', '2', 'a', '3', '4', 'X', '5', '7', '8', 0
    l1 equ $-s1
    s2 db 'a', '4', '5', '6', 0
    l2 equ $-s2
    d times l1/3+l2 db 0
    l3 equ $-d
    index db 0
    
segment code use32 class=code
    start:
        mov ecx, l1 ; setting how much time the first loop will be repeated
        mov esi, 0;setting the index for start point in the s1 array
        ;jecxz End
        ParcurgereS1:
            ;checking if the position is a multiple of 3
            mov edx, 0
            mov eax, esi
            mov ebx, 3
            div ebx
            
            ;if the reminder is 0, the position is a multiple of 3
            ;and the jump `jnz` will not be executed
            test edx, edx
            jnz NotMultiple
            
            ;here we are adding in the final array the current element
            mov eax, dword[index]
            mov bl, [s1+esi]
            mov [d+eax], bl
            
            inc byte[index];incrementing the index in the new array
            
            NotMultiple:
                inc esi
                loop ParcurgereS1
                
        ;now, we will add in reverse the elements from the second array
        mov esi, l2-2
        mov ecx, l2-1
        ParcurgereS2:
            ;here we are adding in the final array the current element
            mov eax, dword[index]
            mov bl, [s2+esi]
            mov [d+eax], bl
            
            dec esi;decrementing the pointer for the second array, to go decreasingly
            inc byte[index];incrementing the index for the new array
            loop ParcurgereS2
        
        ;setting lenght in ecx and esi for index in array
        
        ;printing all at once
        push dword d
        push dword fmts
        call [printf]
        add esp, 4*2
        
        ;printing one by one
        ; mov ecx, l3
        ; mov esi, 0
        
        ; AfisareD:
            ; mov eax, 0
            ; mov al, [d+esi]
            
            ; cbw
            ; cwde
            
            ; pushad
            
            ; push eax
            ; push dword fmtc
            ; call [printf]
            ; add esp, 4*2
            
            ; popad
            ; inc esi
            ; loop AfisareD
            
        End:
            push dword 0
            call [exit]