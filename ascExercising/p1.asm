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
    desc_fisier_in dd -1
    desc_fisier_out dd -1
    fmt_d db "%d", 0
    fmt_s db "%s", 0
    fmt_x db "%x", 0
    fmt_c db "%c", 0
    p_fisier db "Nume fisier: ", 0
    p_caracter db "Caracter: ", 0
    new_line db 10, 13, 0
    to_be_rep_char db 0
    p_n db "n = ", 0
    open_access_w db "w+", 0
    open_access_r db "r+", 0
    nume_fisier times 20 db 0
    nume_fisier_out db "output.txt", 0
    n dd 0
    len equ 1
    buffer resb len
    char db 0
    
    
segment code use32 class=code
    start:
        
        ;citire nume fisier
        push dword p_fisier
        call [printf]
        add esp, 4
        
        push dword nume_fisier
        push dword fmt_s
        call [scanf]
        add esp, 4*2
        
        push dword new_line
        push dword p_n
        push dword fmt_s
        call [printf]
        add esp, 4*3
        
        push dword n
        push dword fmt_d
        call [scanf]
        add esp, 4*2
        
        push dword new_line
        push dword p_caracter
        push dword fmt_s
        call [printf]
        add esp, 4*3
        
        push dword to_be_rep_char
        push dword fmt_s
        call [scanf]
        add esp, 4*2
        
        ;deschidere fisier input
        push dword open_access_r
        push dword nume_fisier
        call [fopen]
        add esp, 4*2
        
        cmp eax, 0
        je final
        mov [desc_fisier_in], eax
        
        push dword open_access_w
        push dword nume_fisier_out
        call [fopen]
        
        cmp eax, 0
        je final
        
        mov [desc_fisier_out], eax
        
        citire_fisier_in:
            push dword [desc_fisier_in]
            push dword len
            push dword 1
            push dword buffer
            call [fread]
            add esp, 4*4
            
            cmp eax, 0
            je final
            
            mov al, [buffer]
            
            mov [char], al
            
            pushad
            
            push dword char
            push dword [desc_fisier_out]
            call [fprintf]
            add esp, 4*2
            
            popad
            
            mov bl, [to_be_rep_char]
            cmp byte al, bl
            jne nu_repeta
            
            mov ecx, 2
            repeta :
                pushad
                push dword char
                push dword [desc_fisier_out]
                call [fprintf]
                add esp, 4*2
                popad
                
                loop repeta
            
            nu_repeta:
            
            jmp citire_fisier_in
        
            
        
        final:
        
            push dword [desc_fisier_in]
            call [fclose]
            add esp, 4
            
            push dword [desc_fisier_out]
            call [fclose]
            add esp, 4
            push dword 0
            call [exit]