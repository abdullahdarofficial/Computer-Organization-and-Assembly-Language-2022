;Activity 1:
;Write program to compute arithematic sum of 
;first N numbers in AX where N is a memory variable if n is 6
;then output should be 6+5+4+3+2+1=21
;Test at diffirent numbers

[org 0x0100]

mov ax,0    ; AX = 0
mov cx,[N]  ; cx= n

l1:
add ax, cx ; AX = cx + Ax
sub cx, 1
jnz l1
 
mov [total],ax ;total memory location = ax

mov ax,0x4c00 
int 0x21

N: dw 6
total: dw 0