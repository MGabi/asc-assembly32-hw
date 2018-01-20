bits 32
;se citeste numele unui fisier
;un caracter si un n
;in output.txt se pune contiutul fisierului si litera carater sa apara de n ori
global start        

extern exit, scanf, printf, fopen, fprintf, fread, fclose
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fread msvcrt.dll
import fclose msvcrt.dll

segment data use32 class=data
    counter_voc dd 0
    fmt_s db "%s", 0
    fmt_d db "%d", 0
    p_n db "n = ", 0
    p_v db "v = ", 0
    new_line db 10, 0
    p_int db "Introduceti mesaje pana la # ", 10, 13, 0
    p_voc db "Introduceti nr vocale: ", 0
    nume_fisier db "out.txt", 0
    access db "w+", 0
    vocale dd 0
    n dd 0
    desc_fisier dd -1
    cuvant resb 8
    stopper db "#"
    
    
segment code use32 class=code
    start:
    
        push dword p_voc
        push dword fmt_s
        call [printf]
        add esp, 4*2
        
        push dword vocale
        push dword fmt_d
        call [scanf]
        add esp, 4*2
        
        push dword p_int
        push dword fmt_s
        call [printf]
        add esp, 4*3
        
        push dword access
        push dword nume_fisier
        call [fopen]
        add esp, 4*2
        
        cmp eax, 0
        je final
        
        mov [desc_fisier], eax
        
        
        citire:
            mov dword [cuvant], 0
            push dword cuvant
            push dword fmt_s
            call [scanf]
            
            mov eax, [cuvant]
            cbw
            cwde
            cmp eax, '#'
            je final
            
            mov esi, 0
            
            mov dword [counter_voc], 0
            
            nr_voc:
                cmp byte [cuvant+esi], 0
                je compare
                
                cmp byte [cuvant+esi], 'a'
                je add_voc
                
                cmp byte [cuvant+esi], 'e'
                je add_voc
                
                cmp byte [cuvant+esi], 'i'
                je add_voc
                
                cmp byte [cuvant+esi], 'o'
                je add_voc
                
                cmp byte [cuvant+esi], 'a'
                je add_voc
                
                jmp not_voc
                        
                add_voc:
                    inc dword [counter_voc]
                   
                not_voc:
                inc esi
                jmp nr_voc
            
            compare:
                mov eax, 0
                mov eax, [counter_voc]
                mov ebx, 0
                mov ebx, [vocale]
                cmp eax, ebx
                jl continue
            
            print_cuv:
                push dword new_line
                push dword cuvant
                push dword fmt_s
                push dword [desc_fisier]
                call [fprintf]
                add esp, 4*3
            
            continue:
            jmp citire
            
    final:
    
        push dword [desc_fisier]
        call [fclose]
        add esp, 4
        push dword 0
        call [exit]