

[org 0x0100]


jmp start

top: dw 330 ;starting coordinate
left: dw 470; 
bottom: dw 1910 ; left coordinate
right: dw 1770

clrscr:
	push es
	push ax
	push cx
	push di


	mov ax,0xb800
	mov es,ax
	xor di,di
	mov ax,0x0720
	mov cx,2000
	
	cld
	rep stosw

	pop di
	pop cx
	pop ax
	pop es

	ret

drawrect:
	push bp
	mov bp,sp
	push ax
	push bx
	push cx
	push dx
	push es
	push di

	mov ax,0xb800
	mov es,ax
	
	mov di,[bp+10]
	mov bx,[bp+8]
loop1:
	mov word[es:di],0x072B
	add di,2
	cmp di,bx
	jne loop1

        mov bx,[bp+6]
loop2:
	mov word[es:di],0x077c
	add di,160
	cmp di,bx
	jne loop2


     mov bx,[bp+4]
loop3:
	mov word[es:di],0x077e
	sub di,2
	cmp di,bx
	jne loop3

        mov bx,[bp+10]
loop4:
	mov word[es:di],0x077c
	sub di,160
	cmp di,bx
	jne loop4

	pop di
	pop es
	pop dx
	pop cx
	pop bx
	pop ax
	pop bp
	
	ret 8


start:

	call clrscr

	
	mov ax,[top]
	push ax
	mov ax,[left]
	push ax
	mov ax,[bottom]
	push ax
	mov ax,[right]
	push ax
	
	call drawrect
mov ax,0x4c00
int 0x21