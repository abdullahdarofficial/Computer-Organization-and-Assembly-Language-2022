;Write a program that rotates the value of three registers clockwise twice i.e. given these
;initial values: ax=10, bx=20, cx=30.

[org 0x0100] ;we will see org directive later

mov ax,10 ;ax=10
mov bx,20 ;bx=20
mov cx,30 ;cx=30


mov dx,cx ;dx=cx
mov cx,bx ;cx=bx
mov bx,ax ;bx=ax
mov ax,dx ;ax=dx
mov dx,0  ;dx=0


mov dx,cx ;dx=cx
mov cx,bx ;cx=bx
mov bx,ax ;bx=ax
mov ax,dx ;ax=dx
mov dx,0  ;dx=0


mov ax, 0x4c00 ;terminate the program
int 0x21