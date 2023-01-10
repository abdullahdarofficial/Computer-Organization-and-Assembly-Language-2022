;Activity 2 [Nested Loop]: Write a program that 
;computes factorial of a number without using
;multiplication instruction

[org 0x0100]

mov ax,[num]    ;ax=num
mov bx,ax       ;bx=ax
mov dx,ax       ;dx=ax

sub dx,1        ;dx=dx-1
mov cx,dx       ;cx=dx
loop1:
mov ax,0
      loop2:
            add ax,bx
            sub cx,1
            jnz loop2
mov bx,ax
sub dx,1
mov cx,dx
cmp dx,0
jne loop1
     
mov [factorial],ax

mov ax,0x4c00            ;termination
int 0x21

num: dw 7
factorial: dw 0