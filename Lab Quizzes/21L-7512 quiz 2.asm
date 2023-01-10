;21L-7512 Quiz 2

[org 0x0100]
jmp start
; Global variables
tickcount: dw 0
location: dw 0,0,0,0
timer:		
			push ax
			inc word [cs:tickcount]
			push word[cs:tickcount]
			call movearrow
			mov al, 0x20
			out 0x20, al
			pop ax
			iret
top:
mov word[location+4],0x0f5e
add di,2
jmp exit		

corner:
mov word[location+4],0x0f3e
sub di,2
jmp exit

down:
mov word[location+4],0x0f76
mov di, [location]
cmp di,3998
je corner
cmp di,3840
ja return1
add di,160
jmp exit

bottom:
mov word[location+4],0x0f3c
sub di,2
jmp exit

up:
mov di,[location]
cmp di,0
jna return1
sub di,160
jmp exit

movearrow:
push bp
mov bp, sp
pusha
mov ax, 0xb800
mov es, ax 		
mov di,[location]
mov ax,[location+2]
mov [es:di],ax		
cmp di,158
jc top
cmp di,3840
ja bottom 
shr di,1
shr di,1
jc down
jnc up
return1:
exit:
mov ax,[es:di]
mov [location+2],ax		; save screen
mov ax,[location+4]		; char
mov word[es:di],ax		; print
mov [location], di		; location index
popa
pop bp
ret 2
start:
xor ax,ax
mov es,ax
cli
mov word[es:8*4],timer
mov [es:8*4+2],cs
sti
mov dx, start
add dx, 15
mov cl, 4
shr dx, cl 
mov ax, 0x3100 ; stay resident
int 0x21 
