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
    fmt_s db "%s", 0
    fmt_c db "%c", 0
    p_nume db "Nume fisier: ", 0
    nume_fisier times 10 db 0
    desc_fisier dd -1
    mod_access db "w+", 0
    
    
segment code use32 class=code
    start:
        
        push dword p_nume
        call [printf]
        add esp, 4
        
        push dword nume_fisier
        push dword fmt_s
        call [scanf]
        add esp, 4*2
        
        push dword mod_access
        push dword nume_fisier
        call [fopen]
        add esp, 4*2
        
        cmp eax, 0
        je final
        
        mov [desc_fisier], eax
        
        mov ecx, 9
        mov esi, 8
        parc_nume:
        
            cmp esi, -1
            je final
            
            pushad
            mov al, [nume_fisier+esi]
            
            cmp al, 'A'
            jb continue
            cmp al, 'Z'
            ja continue
            
            cbw
            cwde
            
            push dword eax
            push dword fmt_c
            push dword [desc_fisier]
            call [fprintf]
            add esp, 4*3
            
            
            continue:
            popad
            dec esi
            loop parc_nume
            
        mov ecx, 9
        mov esi, 8
        parc_nume_2:
        
            cmp esi, -1
            je final
            
            pushad
            mov al, [nume_fisier+esi]
            
            cmp al, 'a'
            jb continue2
            cmp al, 'z'
            ja continue2
            
            cbw
            cwde
            
            push dword eax
            push dword fmt_c
            push dword [desc_fisier]
            call [fprintf]
            add esp, 4*3
            
            
            continue2:
            popad
            dec esi
            loop parc_nume_2
        
            
    final:
    
        push dword [desc_fisier]
        call [fclose]
        add esp, 4
        
        push dword 0
        call [exit]