;Modify this program to generate the sum of first five entries of table of 3, using registers,
;and watch its execution in the debugger.

[org 0x0100] ;we will see org directive later

mov ax, 3
add ax, 3
add ax, 3
add ax, 3
add ax, 3

mov ax, 0x4c00 ;terminate the program
int 0x21