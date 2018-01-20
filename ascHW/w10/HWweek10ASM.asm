;Se dau un nume de fisier si un text (definite in segmentul de date).
;Textul contine litere mici, litere mari, cifre si caractere speciale.
;Sa se transforme toate literele mari din textul dat in litere mici.
;Sa se creeze un fisier cu numele dat si sa se scrie textul obtinut in fisier.

bits 32

global start        

extern exit, fopen, fprintf, fclose
import exit msvcrt.dll
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll

segment data use32 class=data
    fisier db "fisier.txt", 0
    access db "w", 0
    file_descriptor dd -1
    sir db "saIA12d9*$#deanWFNI", 0
    len equ $-sir
    
segment code use32 class=code
    start:
        mov ecx, len
        mov esi, 0
        parcurgeSir:;going through the string
            cmp byte [sir+esi], 65;checking if it's higher than 65 (ascii code)
            jge greater
            jmp notGreater
            greater:
                cmp byte [sir+esi], 90;checking if it's lower than 90(end of upper alphabet
                jle isBigCharacter
                jmp notGreater
            isBigCharacter:;translating to lower case if it's upper
                mov al, [sir+esi]
                add al, 32
                mov [sir+esi], al
            notGreater:
                inc esi
        loop parcurgeSir
        
		
		;printing to file
        push dword access
        push dword fisier
        call [fopen]
        add esp, 4*2
        
        mov [file_descriptor], eax
        cmp eax, 0
        je final
        
        push dword sir
        push dword [file_descriptor]
        call [fprintf]
        add esp, 4*2
        
        push dword [file_descriptor]
        call [fclose]
        add esp, 4
        
        final:
            push dword 0
            call [exit]