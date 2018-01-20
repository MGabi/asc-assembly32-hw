bits 32
;se citesc caractere pana la !
;se pritneaza nr de vocale
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
    access db "r+", 0
    len equ 1
    char db 0
    nr_voc dd 0
    
    
segment code use32 class=code
    start:
        
        push dword access
        push dword nume_fisier
        call [fopen]
        add esp, 4*2
        
        cmp eax, 0
        je close
        
        mov [desc_fisier], eax
        
        citire:
            
            push dword [desc_fisier]
            push dword len
            push dword 1
            push dword char
            call [fread]
            add esp, 4*4
            
            cmp byte [char], '!'
            je final
            
            check_char:
                cmp byte [char], 'a'
                je incremenet
                
                cmp byte [char], 'e'
                je incremenet
                
                cmp byte [char], 'i'
                je incremenet
                
                cmp byte [char], 'o'
                je incremenet
                
                cmp byte [char], 'u'
                je incremenet
                
                jmp not_voc
                
                incremenet:
                    inc dword [nr_voc]
                
                not_voc:
                
                
            
        jmp citire
    final:
        
        push dword [nr_voc]
        push dword fmt_d
        call [printf]
        add esp, 4*2
        
        push dword [desc_fisier]
        call [fclose]
        add esp, 4
        
    close:
        push dword 0
        call [exit]