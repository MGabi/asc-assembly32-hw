bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
extern printf,scanf
import printf msvcrt.dll
import scanf msvcrt.dll
           
extern baza          
;global red                       
; our data is declared here (the variables needed by our program)
segment data use32 class=data public
    ; ...
    format dd "%x", 0
    formatd dd "%d ",0
    text db "Sirul :",0
    text2 db "The number of elements: ",0
    text3 db "the new string: ",0
    
    var dd 0
    sir times 10 dd 0
    a dd 0
    nr dd 0
    
    
; our code starts here
segment code use32 class=code public
    start:
        ; show message
        push dword text2
        call [printf]
        add esp, 4*1
        
        push dword nr
        push dword format
        call [scanf]
        add esp, 4*2
        
        
        
        ;afisare Sirul este
        push dword text
        call [printf]
        add esp,4
        
        mov ecx, [nr]
        mov esi, 0
        ;pushad
      
        citire:
            pushad
            push dword var
            push dword format
            call [scanf]
            add esp,4*2
            popad
            
            mov eax, [var]
            mov [sir +esi], eax
            inc esi
            je ciclu
        loop citire
        
        push dword text3
        call [printf]
        add esp, 4*1
        
        ;pushad
        ;mov ecx, [nr]
        mov esi, 0
        mov ecx, [nr]
        
        ciclu:
        ;citire element
            ; pushad
            ; mov eax, [sir+esi]
            
            
            ; push dword eax
            ; push dword formatd
            ; call [printf]
            
            ; add esp,4*2
            ; popad
            
            ; inc esi
          
            mov eax, [sir + esi]
            pushad
            ;push dword[sir + esi]
            push dword eax
            push dword formatd
            call baza
            add esp, 4*2
            
            ;add esi, 4
            popad
            add esi, 4
        
        loop ciclu
        
    endi:
    
         
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
