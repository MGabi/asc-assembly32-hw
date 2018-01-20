bits 32

global start
global s
global s1  
global rezultat      

extern exit, printf, scanf
extern cautare
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
    s1 times 6 db 0
    s times 8 db 0
    n db 5
    rezultat db -1
    prt_fmr db "%d", 0
    scan_fmt db "%s", 0
    prompt_sir db "Introduceti 5 siruri", 10, 13, 0
    msg_false db "False", 10, 13, 0
    msg_true db "True", 10, 13, 0
    ecx_var dd 0
    
segment code use32 class=code
    start:

    
    push dword prompt_sir
    call [printf]
    add esp, 4
    
    mov ECX, 0
    mov ECX, [n]
    sub ECX, 1
    
    mov [ecx_var], ECX
    
    pushad
    push DWORD s1
    push DWORD scan_fmt
    call [scanf]
    add ESP, 4*2
    popad
    bucla:
        
        pushad
        push DWORD s
        push DWORD scan_fmt
        call [scanf]
        add ESP, 4*2
        popad
        
        push DWORD 6
        push DWORD 8
        call cautare
        add ESP, 4*2
        
        mov AL, [rezultat]
        cmp AL, 1
        je print_true
        jmp print_false
        print_true:
            pushad
            push DWORD msg_true
            call [printf]
            add ESP, 4*1
            popad
            jmp final
            
        print_false:
            pushad
            push DWORD msg_false
            call [printf]
            add ESP, 4*1
            popad
        final:
        mov AL, -1
        mov [rezultat], AL
        mov CL, BYTE [ecx_var]
        dec CL
        cmp CL, 0
        je stop 
        jmp bucla

    stop:

   ;push dword 3
    ;push dword 4
   ; call cautare
    ;add esp, 4*2
    
   




   ;mov AL, [rezultat]
    ;cbw
    ;cwde
    
    ;push DWORD EAX
    ;push DWORD prt_fmr
    ;call [printf]
    ;add ESP, 4*2
    
    push dword 0
    call [exit]
    