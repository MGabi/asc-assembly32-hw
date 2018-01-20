bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a db 4
    b db 3
    c db 2 
    d dw 3
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;AX = 5
        ;DX = 3
        ;a, b, c - byte
        ;d - word
        ;d * (d + 2*a )/(b*c)
        ;2*a
        mov AL, 2
        mul byte[a]
        ;AX = 2*a
        
        add AX, [d]
        
        mul word[d]
        ;DX:AX = rez
        ;rez / (b*c)
        push DX
        push AX
        mov AL, [b]
        mul byte[c]
        
        ;AX = b*c
        mov CX, AX
        pop AX
        pop DX
        div CX
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
