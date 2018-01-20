bits 32

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
    fmt_s db "%s", 0
    access db "r+", 0
    access_w db "w+", 0
    nume_fisier_in db "input.txt", 0
    desc_fisier_in dd -1
    desc_fisier_sec dd -1
    nume_fisier_sec times 16 db 0
    len equ 1
    propozitie times 128 db 0
    len_prop dd 0
    
    
    
segment code use32 class=code
    start:

    ;opening file
    push dword access
    push dword nume_fisier_in
    call [fopen]
    add esp, 4*2
    
    cmp eax, 0
    
    je close
    
    mov [desc_fisier_in], eax
    
    
    citire_propozitii:
        
        mov dword [propozitie], 0
        mov dword [propozitie+4], 0
        mov dword [propozitie+4*2], 0
        mov dword [propozitie+4*3], 0
        mov dword [propozitie+4*4], 0
        mov dword [propozitie+4*6], 0
        mov dword [len_prop], 0
        mov esi, 0
        read_one:
            pushad
            
            mov eax, propozitie
            add eax, esi
            
            push dword [desc_fisier_in]
            push dword len
            push dword 1
            push dword eax
            call [fread]
            add esp, 4*4
            
            cmp eax, 0
            je check_last
            
            cmp byte [propozitie+esi], 10
            jne not_new_line
            popad
            dec esi
            pushad
            not_new_line:
            
            cmp byte [propozitie+esi], '.'
            jne prop_not_done
            
            printare:
                mov byte [propozitie+esi], 0
                pushad
                
                mov esi, 0
                mov dword [nume_fisier_sec], 0
                mov dword [nume_fisier_sec+4], 0
                mov dword [nume_fisier_sec+4*2], 0
                mov dword [nume_fisier_sec+4*3], 0
                
                get_name:
                    cmp byte [propozitie+esi], ' '
                    je name_done
                    cmp byte [propozitie+esi], 0
                    je name_done
                    mov al, [propozitie+esi]
                    mov [nume_fisier_sec+esi], al
                    inc esi
                    jmp get_name
                    
                name_done:
                push dword access_w
                push dword nume_fisier_sec
                call [fopen]
                add esp, 4*2
                
                cmp eax, 0
                
                je close_sec
                
                mov [desc_fisier_sec], eax
                
                push dword propozitie
                push dword [desc_fisier_sec]
                call [fprintf]
                add esp, 4*2
                
                close_sec:
                    push dword [desc_fisier_sec]
                    call [fclose]
                    add esp, 4
                    
                jmp citire_propozitii
                popad
            
            prop_not_done:
            
            popad
            inc esi
            jmp read_one
            
        
        cont_citire:
        
        
        
    jmp citire_propozitii
    
    
    check_last:
    
    final:
        push dword [desc_fisier_in]
        call [fclose]
        add esp, 4
    
    close:
        push dword 0
        call [exit]