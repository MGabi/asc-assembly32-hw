bits 32
;se citeste un nume de fisier si un numar
;sa se citeasca din fisier cuvintele separate prin spatiu
;si sa se afiseze in consola cuvintele de pe pozitiile multiplii de N
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
    nume_fisier times 32 db 0
    n dd 0
    fmt_s db "%s", 0
    fmt_c db "%c", 0
    fmt_d db "%d", 0
    p_n db "n = ", 0
    p_nume db "Fisier: ", 0
    poz_cuv dd 0
    cuvant times 32 db 0
    access db "r+"
    len equ 1
    
    
    
    
    
segment code use32 class=code
    start:
        
        push dword p_n
        call [printf]
        add esp, 4
        
        push dword n
        push dword fmt_d
        call [scanf]
        add esp, 4*2
        
        push dword p_nume
        call [printf]
        add esp, 4
        
        push dword nume_fisier
        push dword fmt_s
        call [scanf]
        add esp, 4*2
        
        push dword access
        push dword nume_fisier
        call [fopen]
        add esp, 4*2
        
        cmp eax, 0
        je close
        
        mov [desc_fisier], eax
        
        citire_cuvinte:
        
            mov esi, 0
            citire:
                
                lea eax, [cuvant+esi]
                pushad
                
                push dword [desc_fisier]
                push dword len
                push dword 1
                push dword eax
                call [fread]
                add esp, 4*4
                
                
                cmp eax, 0
                je final
                
                
                popad
                
                cmp byte [cuvant+esi], ' '
                je check_poz
                inc esi
                
                jmp citire
            
            check_poz:
                
                mov eax, [poz_cuv]
                mov edx, 0
                
                mov ebx, [n]
                div ebx
                
                cmp edx, 0
                jne continue
                
                printare_consola:
                    
                
                    pushad
                    
                    push dword cuvant
                    call [printf]
                    add esp, 4
                    
                    popad
            continue:
            inc dword [poz_cuv]
            
        jmp citire_cuvinte
            
    final:
    
        push dword [desc_fisier]
        call [fclose]
        add esp, 4
        
    close:
        push dword 0
        call [exit]