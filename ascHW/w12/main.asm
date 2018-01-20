bits 32

global start        

extern exit, printf, scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
;Se cere se se citeasca numerele a, b si c si sa se calculeze si afiseze a+b-c.

%include "make_sum.asm"

segment data use32 class=data
    fmt_d db "%d", 0
    fmt_s db "%s", 0
    p_a db "a = ", 0
    p_b db "b = ", 0
    p_c db "c = ", 0
    p_rez db "a + b - c = ", 0
    a dd 0
    b dd 0
    c dd 0
    rez dd 0

segment code use32 class=code
    start:
    
        push p_a
        call [printf]
        add esp, 4*1
        
        push dword a
        push dword fmt_d
        call [scanf]
        add esp, 4*2
        
        push p_b
        call [printf]
        add esp, 4*1
        
        push dword b
        push dword fmt_d
        call [scanf]
        add esp, 4*2
        
        push p_c
        call [printf]
        add esp, 4*1
        
        push dword c
        push dword fmt_d
        call [scanf]
        add esp, 4*2
        
        push dword [a]
        push dword [b]
        push dword [c]
        
        call make_sum
        
        mov [rez], eax
        
        push dword p_rez
        call [printf]
        add esp, 4
        
        push dword [rez]
        push dword fmt_d
        call [printf]
        add esp, 4
        
        push dword 0
        call [exit]