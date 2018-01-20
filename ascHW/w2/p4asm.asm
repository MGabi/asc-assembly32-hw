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
    a dw 5
    b db 3
    c db 2
    d db 4
    e dd 6
    x dq 8
    rez dd 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;(a*2+b/2+e)/(c-d)+x/a 
        ;-7
        ;a-word;
        ;b,c,d-byte;
        ;e-doubleword;
        ;x-qword
        ; exit(0)
        
        mov AX, 2
        mul word [a]
        push DX
        push AX
        ;in DX:AX on the stack is a*2
        
        mov DX, 0
        mov AX, [b]
        mov BX, 2
        idiv BX
        ;in AL is b/2 and in AH is b%2
        mov EBX, 0
        pop EBX
        ;in EBX is now 10
        mov AH, 0
        mov DX, 0
        push DX
        push AX
        pop EAX
        ;in EAX is b/2
        adc EBX, EAX
        adc EBX, [e]
        ;in EBX is the first par. (a*2 + b/2 + e)
        mov EAX, EBX
        ;now is in EAX
        mov EBX, 0
        mov ECX, 0
        mov EDX, 0
        ;registers are clear
        mov BL, [c]
        sbb BL, [d]
        
        ;now we are dividing EDX:EAX with EBX
        ;in EAX is 17, 00000011
        ;in EBX is -2, 000000FE
        ;CF is 1
        ;cdq
        push EAX ; pushing EAX to the stack
        mov EAX, EBX;moving EBX on EAX to convert to a signed dword
        cbw
        cwd
        push DX;pushing the result to the stack
        push AX
        mov EAX, 0
        mov EDX, 0
        pop EBX;getting them back from stack
        pop EAX
        idiv EBX
        ;which should be -8 in EAX
        ;and we can clear the EDX which is %, which should be 1
        ;but the EAX is 0 and EDX is 17
        ;WHY??????????
        mov EDX, 0
        
        
        
        
        
        
        
        
        
        
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
