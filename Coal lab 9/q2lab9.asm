; Question no 2
; 21L-7512 Abdullah Dar BSCS-3G COAL

[org 0x0100]
jmp start

array: dw 1,2,3,4,5,6,7,8,9,10
size: dw 10
;-----------------------------------------------
;Calculate Size Subroutine
;-----------------------------------------------
calculatesize:
	push bp
	mov bp,sp
	push ax
	push bx
	push cx
	mov cx,0
	mov ax,[bp+4]
	mov bx,[bp+6]
loop1:
	add cx,[bx]
	add bx,2
	sub ax,1
	jnz loop1
	
	mov [bp+8],cx
	pop cx
	pop bx
	pop ax
	pop bp
ret 4
;----------------------------------------------
; MAIN PROGRAM
;----------------------------------------------
start:
mov bx,0		; space for sum in stack
push bx
mov bx, array
push bx
mov bx,[size]
push bx
call calculatesize
pop bx

mov ax,0x4c00
int 0x21

