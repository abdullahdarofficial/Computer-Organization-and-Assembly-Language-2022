;Write a program in assembly language that calculates the square of six by adding six to the
;accumulator six times.

[org 0x0100] ;we will see org directive later

mov ax,6 ; ax=6
add ax,6 ; ax=ax+6
add ax,6 ; ax=ax+6
add ax,6 ; ax=ax+6
add ax,6 ; ax=ax+6
add ax,6 ; ax=ax+6

mov ax, 0x4c00 ;terminate the program
int 0x21