%ifndef _MAKE_SUM_ASM_
%define _FACTORIAL_ASM_

make_sum:
    mov eax, [esp + 4*3]
    add eax, [esp + 4*2]
    sub eax, [esp + 4*1]
    
    ret 12

%endif