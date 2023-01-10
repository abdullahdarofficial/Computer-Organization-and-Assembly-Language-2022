;Q2 intersection

[org 0x0100]

mov di ,0       ;DI=0
mov si ,0       ;SI=0
mov ax ,0       ;AX=0
mov bx ,0       ;BX=0
mov dx ,0       ;DX=0

cmp di,0        ;compare DI with 0
je loop1        ; if DI == 0 exit to loop1

put_Any_set:    ;Label for if both equal
         mov si,ax             ;SI = AX
         mov cx,[set1+si]      ;CX = [SET1+SI]
         mov [union+di],cx     ;[UNION + DI] = CX
         add di,2              ;DI=DI+2
         add ax,2              ;AX=AX+2
         jnz return            ;RETURN BACK

move_on:        ;LABEL IF NOT EQUAL MOVE ON
        add bx,2               ;BX=BX+2
        mov si,bx              ;SI=BX
        cmp [set2+si],dx       ;COMPARE IF NEXT ELEMENT IS ZERO TERMINATION
        je next_ele_set1       ;JUMP TO NEXT ELE LABEL IF ITS ZERO
        jnz return             ;ELSE MOVE TO RETURN LABEL 

next_ele_set1: ;LABEL FOR TERMINATION OF LOOP ONE
       mov bx,0                ;SET 2 AGAIN CHECKED FOR NEXT ELE OF SET1
       add ax,2                ;AX=AX+2
       mov si,ax               ;SI=AX
       cmp [set1+si],dx        ;COMPARE IF SET1 IS ZERO TERMINATION 
       je end                  ;JUMP TO END LABEL

loop1:         ;MAIN LOOP
      mov si,bx                ;SI=BX
      mov cx,[set2+si]         ;CX=[SET2+SI]
      mov si,ax                ;SI=AX
      cmp [set1+si],cx         ;[SET1+SI]
      je put_Any_set           ;IF(BOTH EQUAL THE PUT ANY ONE)
      jne move_on              ;IF NOT EQUAL LABEL MOVE ON
      return:                  ;RETURN LABEL 
      mov si,ax                ;SI=AX
      cmp [set1+si],dx         ;COMPARE [SET1+SI] WITH DX
      je end                   ;IF BOTH EQUAL MOVE TO LABEL END
      jne loop1                ;IF NOT EQUAL MOVE TO LABEL LOOP1

end:          ;LABEL END
mov ax,0x4c00 ;EXIT
int 0x21  

set1: dw 1,4,6,0,0             ;SET1
set2: dw 1,3,6,8,0             ;SET2
union: dw 0,0,0,0,0,0,0,0,0,0  ;UNION
