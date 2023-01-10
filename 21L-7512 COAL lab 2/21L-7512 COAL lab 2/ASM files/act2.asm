;Activity 2 Program to compute square of number and saves it in square
;where number and square are two memory variables of word length
;for any num your program should add that to n times
;i.e 5^2 = 5+5+5+5+5=25
; check for num = 5 and num = 9

[org 0x0100]
; for number = 5 
mov ax,0 ;AX=0
mov bx,[num1] ;Bx = num1 value
mov cx,[num1] ;cx= num1 value

l1:
add ax,bx ; ax= ax+bx
sub cx,1 ; cx-=1
jnz l1

mov [square1],ax ; save value of ax into square1
; for number = 9

mov ax,0 ;AX=0
mov bx,[num2] ;Bx = num2 value
mov cx,[num2] ;cx= num2 value

l2:
add ax,bx ; ax= ax+bx
sub cx,1 ; cx-=1
jnz l2

mov [square1],ax ; save value of ax into square2

mov ax,0x4c00
int 0x21

num1: dw 5 ; num1=5
square1: dw 0 ;square1 = 0
num2: dw 9 ;num2 =9
square2: dw 0 ;square2 =0




