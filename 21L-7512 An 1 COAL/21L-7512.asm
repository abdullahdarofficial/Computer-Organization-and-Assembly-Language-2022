
[org 0x0100]

;-------------Q1 (i) unsigned----------------
mov cx,10        ; counter = 10
mov si,0         ; source index = 0
mov ax,[array1]   ; AX = array[0]
mov [min1],ax     ; [min]=AX
mov [max1],ax     ; [max]=AX

jmp loop1

update_max1:      ; label for updating max
mov [max1],ax     ; [max]=AX
ja return1

update_min1:      ; label for updating min
mov [min1],ax     ; [min]=AX
jc return1 

loop1:
      cmp ax,[max1]      ; comparing ax with max
      ja update_max1     ; jump if max < AX
      cmp ax,[min1]      ; comparing ax with min
      jc update_min1     ; jump if min > AX
      return1:           ; label for return used by labels of updation
      add si,2          ; SI=SI+2
      mov ax,[array1+si] ; AX=[array+si]
      sub cx,1          ; counter --
jnz loop1               ; jump to loop1 if cx=0

;-------------Q1 (ii) signed----------------


mov cx,10        ; counter = 10
mov si,0         ; source index = 0
mov ax,[array2]   ; AX = array[0]
mov [min2],ax     ; [min]=AX
mov [max2],ax     ; [max]=AX

update_max2:      ; label for updating max
mov [max2],ax     ; [max]=AX
jnl return2

update_min2:      ; label for updating min
mov [min2],ax     ; [min]=AX
jl return2 

loop2:
      cmp ax,[max2]      ; comparing ax with max
      jnl update_max2    ; jump if max < AX
      cmp ax,[min2]      ; comparing ax with min
      jl update_min2     ; jump if min > AX
      return2:           ; label for return used by labels of updation
      add si,2          ; SI=SI+2
      mov ax,[array2+si] ; AX=[array+si]
      sub cx,1          ; counter --
jnz loop2               ; jump to loop1 if cx=0

;-------------Q2 Union ----------------
mov di ,0     ;DI=0
mov si ,0     ;si=0
mov ax ,0     ;AX=0
mov bx ,0     ;bx=0
mov dx ,0     ;dx=0
jmp loop3


put_Any_set1:
         mov si,ax                    ;si=ax
         mov cx,[set11+si]             ;cx=set1+si
         mov [union+di],cx            ;union+di=cx
         add di,2                     ;di=di+2
         add ax,2                     ;ax=ax+2
         add bx,2                     ;bx=bx+2
         jnz return3                   ;label not zero
put_set11:                             ;label
         mov si,ax                    ;si=ax
         mov cx,[set11+si]             ;cx=set1+si
         mov [union+di],cx            ;union + di=cx
         add di,2                     ; di=di+2
         add ax,2                     ;ax=ax+2
         jnz return3                   ;label return

put_set21:
         mov si,bx                    ;si=bx
         mov cx,[set21+si]             ;cx=set2+si   
         mov [union+di],cx            ;union +di=cx
         add di,2                     ;di+ di+2
         add bx,2                     ;bx=bx+2
         jnz return3                   ;label for return

loop3:
      mov si,bx                       ;si = bx
      mov cx,[set21+si]                ;cx=set1+si
      mov si,ax                       ;si=ax
      cmp [set11+si],cx                ;set1+si=cx
      je put_Any_set1                  ;if equal jump label
      jc put_set11                     ;if set 1 is small
      ja put_set21                     ;if set 2 is small
      return3:                         ;return label
      mov si,ax                       ;si=ax
      cmp [set11+si],dx                ;compare if set1+si with dx
      je set1_End1                     ;jump to label
      mov si,bx                       ;si=bx
      cmp [set21+si],dx                ;set2+si = dx
      je set2_End1                     ;jump if equal to label set2_End
      jne loop3                      ;jump if not equal label loop1

set1_End1:                             ;label
         mov si,bx                    ;si=bx
         mov cx,[set21+si]             ;cx=set2+si
         mov [union+di],cx            ;union + di =cx
         add bx,2                     ;bx=bx+2
         add di,2                     ;di=di+2
         mov si,bx                    ;si=bx
         cmp [set21+si],dx             ;set2+Si=dx
         jne set1_End1                ;jump if not equal label
cmp [set21+si],dx                      ;compare with zero
je end1                                ;jump if equal label
set2_End1:                             ;label
         mov si,ax                    ;si =ax
         mov cx,[set11+si]             ;cx=set1+si
         mov [union+di],cx            ;union+di=cx
         add ax,2                     ;ax=ax+2
         add di,2                     ;di=di+2
         mov si,ax                    ;si=ax
         cmp [set11+si],dx             ;set1+si=dx
         jne set2_End1                 ;label jump if not zero
end1:            ;label

;-------------Q3 Intersection ----------------


mov di ,0       ;DI=0
mov si ,0       ;SI=0
mov ax ,0       ;AX=0
mov bx ,0       ;BX=0
mov dx ,0       ;DX=0

cmp di,0        ;compare DI with 0
je loop4        ; if DI == 0 exit to loop1

put_Any_set2:    ;Label for if both equal
         mov si,ax             ;SI = AX
         mov cx,[set12+si]      ;CX = [SET1+SI]
         mov [intersection+di],cx     ;[UNION + DI] = CX
         add di,2              ;DI=DI+2
         add ax,2              ;AX=AX+2
         jnz return4            ;RETURN BACK

move_on2:        ;LABEL IF NOT EQUAL MOVE ON
        add bx,2               ;BX=BX+2
        mov si,bx              ;SI=BX
        cmp [set22+si],dx       ;COMPARE IF NEXT ELEMENT IS ZERO TERMINATION
        je next_ele_set12       ;JUMP TO NEXT ELE LABEL IF ITS ZERO
        jnz return4             ;ELSE MOVE TO RETURN LABEL 

next_ele_set12: ;LABEL FOR TERMINATION OF LOOP ONE
       mov bx,0                ;SET 2 AGAIN CHECKED FOR NEXT ELE OF SET1
       add ax,2                ;AX=AX+2
       mov si,ax               ;SI=AX
       cmp [set12+si],dx        ;COMPARE IF SET1 IS ZERO TERMINATION 
       je end4                  ;JUMP TO END LABEL

loop4:         ;MAIN LOOP
      mov si,bx                ;SI=BX
      mov cx,[set22+si]         ;CX=[SET2+SI]
      mov si,ax                ;SI=AX
      cmp [set12+si],cx         ;[SET1+SI]
      je put_Any_set2           ;IF(BOTH EQUAL THE PUT ANY ONE)
      jne move_on2              ;IF NOT EQUAL LABEL MOVE ON
      return4:                  ;RETURN LABEL 
      mov si,ax                ;SI=AX
      cmp [set12+si],dx         ;COMPARE [SET1+SI] WITH DX
      je end4                   ;IF BOTH EQUAL MOVE TO LABEL END
      jne loop4               ;IF NOT EQUAL MOVE TO LABEL LOOP1

end4:          ;LABEL END

;-------------Q4 Subset ----------------



mov ax,0                  ;AX=0
mov cx,0                  ;CX=0
mov bx,0                  ;BX=0
mov di,0                  ;DI=0
mov si,0                  ;SI=0
add si,0                  ;SI=SI+0
je loop5                  ;JUMP TO LOOP1 LABEL

first_index5:              ;LABEL
      add si,2            ;SI=SI+2
      add di,2            ;DI=DI+2
      mov cx,[set5+di]     ;CX=SET+DI
      cmp cx,[subset5+si]  ;IF BOTH EQUAL
      je second_index5     ;JUMP TO SECOND INDEX LABEL
      jnz return5          ;ELSE RETURN LABEL

second_index5:             ;LABEL
      add si,2            ;SI=SI+2
      add di,2            ;DI=DI+2
      mov cx,[set5+di]     ;CX=SET+DI
      cmp cx,[subset5+si]  ;CX=SUBSET+SI
      je end5              ;IF EQUAL JUMP TO END
      jl return5           ;ELSE JUMP TO LABEL

loop5:                    ;LABEL
      mov cx,[set5+di]     ;CX=SET+DI
      cmp cx,[subset5+si]  ;COMPARE
      je first_index5      ;IF EQUAL
      
return5:                   ;LABEL
      mov si,0            ;SI=0
      add ax,2            ;AX=AX+2
      mov di,ax           ;DI=AX
      add bx,1            ;BX=BX+1
      cmp ax,20           ;COMPARE
      jl loop5            ;LOOP NOT COMPLETE
      je not_found5        ; INDEX=-1 LABEL

end5:                      ;LABEL
   mov [index],bx         ;INDEX=BX
   add si,6               ;SI=6
   jnz endd5               ;END LABEL JUMP
not_found5:                ;LABEL
   mov ax,-1              ;AX=-1
   mov [index],ax         ;INDEX=AX
endd5:                     ;LABEL

;---------------------------------------
mov ax,0x4c00    ; termination of code
int 0x21


array1: dw 5,7,13,9,1,24,14,25,17,11   ; array declared globally
min1: dw 0                             ; min = 0  
max1: dw 0                             ; max = 0

array2: dw -5,-7,13,9,-1,-24,14,25,-17,11   ; array declared globally
min2: dw 0                                  ; min = 0  
max2: dw 0                                  ; max = 0


set11: dw 1,4,6,0,0                    ;set1
set21: dw 1,3,5,8,0                    ;set2
union: dw 0,0,0,0,0,0,0,0,0,0         ;union


set12: dw 1,4,6,0,0             ;SET1
set22: dw 1,3,6,8,0             ;SET2
intersection: dw 0,0,0,0,0,0,0,0,0,0  ;intersection


set5: dw 1,2,4,1,1,2,3,1,2,5 ;SET
subset5: dw 1,2,3            ;SUBSET
index: dw 0                 ;INDEX