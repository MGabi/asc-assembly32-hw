bits 32
;se citeste n
;se citesc nr pana la 0
;se scriu in fisier numerele cu n cifre pare 
global start        

extern exit, scanf, printf, fopen, fprintf, fread, fclose, fwrite
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fread msvcrt.dll
import fclose msvcrt.dll
import fwrite msvcrt.dll

segment data use32 class=data
    desc_fisier dd -1
    fmt_s db "%s", 0
    fmt_c db "%c", 0
    fmt_d db "%d", 0
    fmt_x db "%x", 0
    p_n db "n = ", 0
    access db "w+", 0
    n db 0
    numar dd 0
    finalnr db 0
    nume_fisier db "fisier.out", 0
    new_line db 10, 13, 0
    nr_pare db 0
    
    
segment code use32 class=code
    start:
        
        push dword p_n
        call [printf]
        add esp, 4
        
        push dword n
        push dword fmt_d
        call [scanf]
        add esp, 4*2
        
        push dword access
        push dword nume_fisier
        call [fopen]
        add esp, 4*2
        
        cmp eax, 0
        je close
        
        mov [desc_fisier], eax
        
        
        citeste:
            
            push dword numar
            push dword fmt_d
            call [scanf]
            add esp, 4*2
            
            mov eax, [numar]
            cmp eax, 0
            je final
            
            mov byte [nr_pare], 0
            numara:
                cmp eax, 0
                je out_of_nr
                
                mov edx, 0
                mov ebx, 10
                div ebx
                
                ;EAX = nr / 10
                ;EDX = nr % 10
                
                push eax
                
                mov eax, edx
                mov edx, 0
                
                mov ebx, 2
                div ebx
                
                pop eax
                
                cmp edx, 0
                jne not_even
                
                inc byte [nr_pare]
                
                not_even:
                
            jmp numara
            
            out_of_nr:
            mov al, [nr_pare]
            mov ah, [n]
            cmp al, ah
            jb continue
            
            printeaza:
                
                push dword [numar]
                push dword fmt_x
                push dword [desc_fisier]
                call [fprintf]
                add esp, 4*2
            
            continue:
        jmp citeste
            
    final:
    
        push dword [desc_fisier]
        call [fclose]
        add esp, 4
        
    close:
        push dword 0
        call [exit]