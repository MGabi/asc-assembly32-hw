bits 32
global start

import printf msvcrt.dll
import exit msvcrt.dll
extern printf, exit

extern factorial

segment data use32
	format_string db "factPlus=%d", 10, 13, 0
    format_string2 db "factMinus=%d", 10, 13, 0

segment code use32 public code
start:
	push dword 4
	push dword 2
    call factorial
    
    pushad
    push eax
	push format_string
	call [printf]
	add esp, 2*4
    popad
    
    push ecx
    push format_string2
    call [printf]
    add esp, 4*2
    
	push 0
	call [exit]
