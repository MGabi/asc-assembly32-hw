bits 32
extern s, s1, rezultat
segment use32 public code
    poz db 0
    cnt dw 0
    len_S db 0
    len_S1 db 0
global cautare
    cautare:
        
        cld; setam DF la 0 pentru parcurgere de la stanga la dreapta
       
        
        mov ECX, [ESP + 4]
        mov [len_S], ECX
        
        mov EDX, [ESP + 8]
        mov [len_S1], EDX
        
        sub ECX, EDX
        add ECX, 1
        
        ;mov ECX, len_S - len_S1 + 1;parcurgem sirul intr-un loop de |s| - |s1| + 1 ori (|s| notat cardinal de s)
        mov EDX, 0; punem in EDX 0, pentru a juca rol de contor pentru sirul de pozitii
        cmp ECX, 0; comparam dimensiunea lui ECX cu 0, pentru ca in cazul in care |s1| > |s| sa nu avem ciclu infinit
        jng sf_Prg
        jecxz sf_Prg
        for_1:
            mov ESI, s;punem sirul sursa in ESI
            mov AL, [poz] ;punem in AL, pozitia curenta
            cbw ;AL -> AX
            cwde; AX -> EAX
            add ESI, EAX ;adunam la baza sirului sursa, pozitia curenta
            mov AL, [poz]  ;punem pozitia in AL
            inc AL           ;incrementam pozitia
            mov [poz], AL  
            mov EDI, s1 ;punem sirul destinatie in EDI
            push ECX ;salvam ECX pe stiva
            mov ECX, [len_S1]; punem in ECX lungimea lui S1
            mov AX, 0
            mov [cnt], AX ;setam numarul de potriviri de la pozitia curenta cu 0
            for_2:
                cmpsb ;compar element cu elemnt sirul de lungime len_S1 ce incepe la pozitia curenta din sirul sursa, cu elementele sirului destinatie
                je isEq ;daca sunt egale
                jne notEq
                isEq:
                mov AL, [cnt] 
                inc AL ;numar o potrivire
                mov [cnt], AL
                notEq:
                loop for_2 ;in caz de neegalitate refacem loop-ul
                
            mov AX, [cnt]  ;punem numarul de potriviri de la pozitia curenta in AX
            mov BX, [len_S1] ;punem lungimea sirului S1 in BX
            cmp AX, BX ;comparam cele doua valori
            je savePos ;daca numarul de potriviri este egal cu lungimea sirului, salvam pozitia
            jne notSave;daca numarul de potriviri nu este egal cu lungimea sirului, refacem loop-ul
            savePos:
                mov [rezultat], BYTE 1
               
            notSave:
            pop ECX ;restauram valoarea lui ECX
            loop for_1;facem inca odata loop la for_1
            
        sf_Prg: ;eticheta de sfarsit de program
        ret