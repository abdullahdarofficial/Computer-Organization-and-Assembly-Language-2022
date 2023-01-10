;;Activity 3 Program to read array 1 and save it to array 2 in reverse order
;array1 = 1,2,3,4,5,6
;array2 0,0,0,0,0,0
;after comnpilation
; array1: 1,2,3,4,5,6
; array2 6;5;4;3;2;1

[org 0x0100]

mov si,0 
mov di,10
mov cx,6

l1:
mov ax,[array1+si]
mov [array2+di],ax
add si,2
sub di,2
sub cx,1
jnz l1

mov ax,0x4c00
int 0x21

array1: dw 1,2,3,4,5,6
array2: dw 0,0,0,0,0,0