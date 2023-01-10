;Q3 finding index

[org 0x0100]

mov ax,0                  ;AX=0
mov cx,0                  ;CX=0
mov bx,0                  ;BX=0
mov di,0                  ;DI=0
mov si,0                  ;SI=0
add si,0                  ;SI=SI+0
je loop1                  ;JUMP TO LOOP1 LABEL

first_index:              ;LABEL
      add si,2            ;SI=SI+2
      add di,2            ;DI=DI+2
      mov cx,[set+di]     ;CX=SET+DI
      cmp cx,[subset+si]  ;IF BOTH EQUAL
      je second_index     ;JUMP TO SECOND INDEX LABEL
      jnz return          ;ELSE RETURN LABEL

second_index:             ;LABEL
      add si,2            ;SI=SI+2
      add di,2            ;DI=DI+2
      mov cx,[set+di]     ;CX=SET+DI
      cmp cx,[subset+si]  ;CX=SUBSET+SI
      je end              ;IF EQUAL JUMP TO END
      jl return           ;ELSE JUMP TO LABEL

loop1:                    ;LABEL
      mov cx,[set+di]     ;CX=SET+DI
      cmp cx,[subset+si]  ;COMPARE
      je first_index      ;IF EQUAL
      
return:                   ;LABEL
      mov si,0            ;SI=0
      add ax,2            ;AX=AX+2
      mov di,ax           ;DI=AX
      add bx,1            ;BX=BX+1
      cmp ax,20           ;COMPARE
      jl loop1            ;LOOP NOT COMPLETE
      je not_found        ; INDEX=-1 LABEL

end:                      ;LABEL
   mov [index],bx         ;INDEX=BX
   add si,6               ;SI=6
   jnz endd               ;END LABEL JUMP
not_found:                ;LABEL
   mov ax,-1              ;AX=-1
   mov [index],ax         ;INDEX=AX
endd:                     ;LABEL
mov ax,0x4c00             ;TERMINATION
int 0x21

set: dw 1,2,4,1,1,2,3,1,2,5 ;SET
subset: dw 1,2,3            ;SUBSET
index: dw 0                 ;INDEX