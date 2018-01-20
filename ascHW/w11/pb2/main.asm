bits 32

global start        

extern exit, scanf, printf, fopen, fprintf, fread
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fread msvcrt.dll

segment data use32 class=data
    msj_fisier db "fisier = ", 0
    fmt_string db "%s", 0
    nume_fisier times 16 db 0
segment code use32 class=code
    start:
        
        push dword msj_fisier
        call [printf]
        add esp, 4*1
        
        push dword nume_fisier
        push dword fmt_string
        call [scanf]
        add esp, 4*2
        
        push dword nume_fisier
        push dword fmt_string
        call [printf]
        add esp, 4*2
        
        push dword 0
        call [exit]