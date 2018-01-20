bits 32                         
segment code use32 public code
global factorial

factorial:
	mov eax, 1
	mov ecx, [esp + 8]
	mov ebx, [esp + 4]
	repet: 
		mul ecx
	loop repet
    
    add eax, ebx
    adc edx, 0
    
    mov ecx, eax
    sub ecx, ebx
    sub ecx, ebx
    
    ret 8 ; in acest caz 4 reprezinta numarul de octeti ce trebuie eliberati de pe stiva (parametrul pasat procedurii)