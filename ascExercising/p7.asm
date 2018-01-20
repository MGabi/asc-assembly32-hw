bits 32
;se citeste un n si numere de la tastatura
;se scriu in fisier numerele cu N cifre pare
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
    nume_fisier db "output.txt", 0
    fmt_s db "%s", 0
    fmt_c db "%c", 0
    fmt_d db "%d", 0
    access db "w+", 0
    new_line db "", 10, 0
    p_n db "n = ", 0
    n dd 0
    numar dd 0
    msg db "Introduceti numere pana la 0: ", 10, 13, 0
    nr_biti db 0
    c_pare db 0
    
segment code use32 class=code
    start:
        push dword access
        push dword nume_fisier
        call [fopen]
        add esp, 4*2
        
        cmp eax, 0
        je close
        
        mov [desc_fisier], eax
        
        push dword p_n
        call [printf]
        add esp, 4
        
        push dword n
        push dword fmt_d
        call [scanf]
        add esp, 4*2
        
        push dword msg
        call [printf]
        add esp, 4
        
        citire_nr:
            push dword numar
            push dword fmt_d
            call [scanf]
            add esp, 4*2
            
            cmp dword [numar], 0
            je final
            
            mov eax, [numar]
            mov byte [c_pare], 0
            check_nr:
                
                cmp eax, 0
                je done
                
                mov edx, 0
                mov ebx, 10
                
                div ebx
                
                push eax
                
                mov ax, dx
                mov bl, 2
                div bl
                
                cmp ah, 0
                
                jne ok
                
                
                inc byte [c_pare]
                
                ok:
                pop eax
                jmp check_nr
            
            done:
            mov eax, [n]
            cmp eax, [c_pare]
            
            jne not_equal
            
            pushad
            
            push dword [numar]
            push dword fmt_d
            push dword [desc_fisier]
            call [fprintf]
            add esp, 4*3
            
            push dword new_line
            push dword [desc_fisier]
            call [fprintf]
            add esp, 4*2
            
            not_equal:
                
        jmp citire_nr
        
    final:
    
        push dword [desc_fisier]
        call [fclose]
        add esp, 4
        
    close:
        push dword 0
        call [exit]