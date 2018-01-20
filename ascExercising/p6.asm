bits 32
;sa se scrie in fisier pt fiecare numar numarul de biti de 1
;de la numerele citite de la tastatura
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
    nume_fisier db "input.txt", 0
    fmt_s db "%s", 0
    fmt_c db "%c", 0
    fmt_d db "%d", 0
    new_line db "", 10, 0
    numar dd 0
    access db "w+", 0
    msg db "Introduceti numere pana la 0: ", 10, 13, 0
    nr_biti db 0
    
segment code use32 class=code
    start:
        
        push dword access
        push dword nume_fisier
        call [fopen]
        add esp, 4*2
        
        cmp eax, 0
        je final
        
        mov [desc_fisier], eax
        
        push dword msg
        call [printf]
        add esp, 4
        
        citire_tastatura:
            
            pushad
            
            push dword numar
            push dword fmt_d
            call [scanf]
            add esp, 4*2
            
            
            cmp dword [numar], 0
            je final
            
            popad
            write_nr:
                
                mov ecx, 31
                mov byte [nr_biti], 0
                mov eax, [numar]
                nr_biti_count:
                    mov bl, 0
                    shr eax, 1
                    
                    adc bl, 0
                    cmp bl, 1
                    
                
                    
                    jne not_one
                    inc byte [nr_biti]
                    not_one:
                    
                    loop nr_biti_count
                    
                
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
                
                push dword [nr_biti]
                push dword fmt_d
                push dword [desc_fisier]
                call [fprintf]
                add esp, 4*3
                
                push dword new_line
                push dword [desc_fisier]
                call [fprintf]
                add esp, 4*2
                
                push dword new_line
                push dword [desc_fisier]
                call [fprintf]
                add esp, 4*2
                
                
                popad
        jmp citire_tastatura
        
    final:
    
        push dword [desc_fisier]
        call [fclose]
        add esp, 4
        
    close:
        push dword 0
        call [exit]