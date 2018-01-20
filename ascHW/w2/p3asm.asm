bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 5
    b db 4
    c db 6
    d dw 10
    
; our code starts here
segment code use32 class=code
    start:
        ; 3 * [20*(b - a + 2) - 10 * c ] + 2 * ( d - 3 ) = 
        ; = -106
        
        mov AL, [b]
        sub AL, [a]
        add AL, 2
        mov AH, 20
        mul AH
        
        ;AX = 20*(b-a+2)
        mov BX, AX
        ;BX = 20*(b-a+2)
        ;AX will be 10*c
        mov AL, 10
        mov AH, [c]
        mul AH
        
        ;BX is here rez
        sub BX, AX
        
        ;have to do 3*rez
        ;mov BX, AX
        mov AX, 3
        mul BX
        ;DX:AX is now 3*[20*(b-a+2)-10*c]
        ;DX:AX = -180
        push DX
        push AX
        
        ;bigger paranthesis is now on the stack
        mov AX, [d]
        sub AX, 3
        mov BX, 2
        mul BX
        ;DX:AX is now 2*(d-3)
        
        push DX
        push AX
        pop EAX
        ;EAX is now little paranthesis
        pop EBX
        ;ebx is now bigger paranthesis
        
        add EBX, EAX
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
