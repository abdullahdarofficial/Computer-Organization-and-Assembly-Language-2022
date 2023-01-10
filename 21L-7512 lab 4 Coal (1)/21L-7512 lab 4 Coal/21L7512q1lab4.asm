;Activity no 1
;LAB 4 21L-7512

[org 0x0100]

mov ax,[num1]       ;AX=NUM1
mov bx,[num2]       ;BX=NUM2
mov cx,0            ;CX=0
mov dx,0            ;DX=0
jmp start           ;JUMP TO START LABEL
increment:          ;INCREMENT FUNCTION
     inc cx         ;INC CX
     jmp return     ;JMUP TO LABEL RETURN
start:              ;START LABEL
loop1:              ;LOOP1 LABEL
     shr bx,1       ;SHR BX BY 1 BIT
     jc increment   ;IF CARRY 1 THEN JUMP
     return:        ;RETURN LABEL
     cmp bx,0       ;COMPARE BX WITH 0
     jnz loop1      ;JUMP IF NOT ZERO

loop2:              ;LOOP2 LABEL
      stc           ;SET CARRAY 1
      rcl dx,1      ;RCL DX BY 1 BIT
      sub cx,1      ; CX=CX-1
      jnz loop2     ;JUMP IF NOT ZERO

xor ax,dx           ;XOR AX WITH DX
mov [num3],ax       ;NUM3=AX
     
mov ax,0x4c00
int 0x21


num1: dw 0xaba5
num2: dw 0xb189
num3: dw 0
;abda