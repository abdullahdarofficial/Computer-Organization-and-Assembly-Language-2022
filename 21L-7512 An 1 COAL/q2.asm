;Q2 union

[org 0x0100]
mov di ,0     ;DI=0
mov si ,0     ;si=0
mov ax ,0     ;AX=0
mov bx ,0     ;bx=0
mov dx ,0     ;dx=0

cmp di,0      ;cmp di=0
je loop1      ;label


put_Any_set:
         mov si,ax                    ;si=ax
         mov cx,[set1+si]             ;cx=set1+si
         mov [union+di],cx            ;union+di=cx
         add di,2                     ;di=di+2
         add ax,2                     ;ax=ax+2
         add bx,2                     ;bx=bx+2
         jnz return                   ;label not zero
put_set1:                             ;label
         mov si,ax                    ;si=ax
         mov cx,[set1+si]             ;cx=set1+si
         mov [union+di],cx            ;union + di=cx
         add di,2                     ; di=di+2
         add ax,2                     ;ax=ax+2
         jnz return                   ;label return

put_set2:
         mov si,bx                    ;si=bx
         mov cx,[set2+si]             ;cx=set2+si   
         mov [union+di],cx            ;union +di=cx
         add di,2                     ;di+ di+2
         add bx,2                     ;bx=bx+2
         jnz return                   ;label for return

loop1:
      mov si,bx                       ;si = bx
      mov cx,[set2+si]                ;cx=set1+si
      mov si,ax                       ;si=ax
      cmp [set1+si],cx                ;set1+si=cx
      je put_Any_set                  ;if equal jump label
      jc put_set1                     ;if set 1 is small
      ja put_set2                     ;if set 2 is small
      return:                         ;return label
      mov si,ax                       ;si=ax
      cmp [set1+si],dx                ;compare if set1+si with dx
      je set1_End                     ;jump to label
      mov si,bx                       ;si=bx
      cmp [set2+si],dx                ;set2+si = dx
      je set2_End                     ;jump if equal to label set2_End
      jne loop1                       ;jump if not equal label loop1

set1_End:                             ;label
         mov si,bx                    ;si=bx
         mov cx,[set2+si]             ;cx=set2+si
         mov [union+di],cx            ;union + di =cx
         add bx,2                     ;bx=bx+2
         add di,2                     ;di=di+2
         mov si,bx                    ;si=bx
         cmp [set2+si],dx             ;set2+Si=dx
         jne set1_End                 ;jump if not equal label
cmp [set2+si],dx                      ;compare with zero
je end                                ;jump if equal label
set2_End:                             ;label
         mov si,ax                    ;si =ax
         mov cx,[set1+si]             ;cx=set1+si
         mov [union+di],cx            ;union+di=cx
         add ax,2                     ;ax=ax+2
         add di,2                     ;di=di+2
         mov si,ax                    ;si=ax
         cmp [set1+si],dx             ;set1+si=dx
         jne set2_End                 ;label jump if not zero
end:            ;label
mov ax,0x4c00
int 0x21

set1: dw 1,4,6,0,0                    ;set1
set2: dw 1,3,5,8,0                    ;set2
union: dw 0,0,0,0,0,0,0,0,0,0         ;union
