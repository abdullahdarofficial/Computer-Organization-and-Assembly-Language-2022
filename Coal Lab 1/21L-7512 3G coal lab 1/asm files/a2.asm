;Activity 2: Write a program that copies data from one array data1 to another array data2. 
;Initially data1 will have 2,4,6,8,10 and data2 will have all zeros in it.

[org 0x0100]

mov ax,[data1] ; ax=data1
mov [data2],ax ; data2=ax


mov ax,[data1+2] ; ax=data1+2
mov [data2+2],ax ; data2+2=ax


mov ax,[data1+4] ; ax=data1+4
mov [data2+4],ax ; data2+4=ax


mov ax,[data1+6] ; ax=data1+6
mov [data2+6],ax ; data2=ax+6


mov ax,[data1+8] ; ax=data1+8
mov [data2+8],ax ; data2+8=ax


mov ax, 0x4c00	;terminate the program
int 0x21

data1: dw 2,4,6,8,10
data2: dw 0,0,0,0,0



