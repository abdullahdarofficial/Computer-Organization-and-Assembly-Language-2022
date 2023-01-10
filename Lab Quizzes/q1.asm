[org 0x0100]
;21L-7512
jmp start


convertascii:
	push bp
	mov bp,sp
	pusha
	mov ax,0xb800
	mov es,ax
	mov di,2
	mov ax,[bp+4]
	mov cx,0
	mov bx, 10 

nextdigit:
	mov dx, 0 
	div bx
	;add dl,0x30
	push dx 
	inc cx
	cmp ax,0
	jnz nextdigit

loop1:

	pop bx
	add bx,50
;add bl,0x30
	mov ax,0x0700
	add bx,ax
	mov [es:di],bx
	add di,160
	dec cx
	jnz loop1

popa
pop bp
ret 2
	
start:

mov ax,0x7512
push ax


call convertascii


mov ax,0x4c00
int 0x21