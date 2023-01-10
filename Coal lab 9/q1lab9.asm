; Question no 1
; 21L-7512  Abdullah Dar BSCS-3G COAL

[org 0x0100]
jmp start
;-----------------------------------------------
;Goose Subroutine
;-----------------------------------------------
goose:
	push bp
	mov bp,sp
	push bx
	mov bx, -4
	mov [bp+4], bx
	pop bx
	pop bp
ret 
;-----------------------------------------------
;Sky Subroutine
;-----------------------------------------------
sky:
	push bp
	mov bp,sp
	push ax
	push bx

	mov ax,[bp+6]
	mov bx,[bp+4]
	sub ax,bx
	mov [bp+8],ax

	pop bx
	pop ax
	pop bp
ret 4
;-----------------------------------------------
;Sheep subroutine
;-----------------------------------------------
return1:
	mov bx,1
	mov [bp+6],bx
	jmp exitsheep
sheep:
	push bp
	mov bp,sp
	push bx
	mov bx,[bp+4]
	cmp bx,0
	jl return1
	mov bx,0
	mov [bp+6],bx
exitsheep:
	pop bx
	pop bp
	ret 2
;-----------------------------------------------
;duck subroutine
;-----------------------------------------------
returnnegative:
	mov bx,[bp+4]
	not bx
	add bx,1
	mov [bp+6],bx
	jmp exitduck
duck:
	push bp
	mov bp,sp
	push bx
	mov bx,[bp+4]
	push bx
	push bx
	call sheep
	pop bx		; bx has the value of return from function sheep
	cmp bx,1
	je returnnegative
	mov bx,[bp+4]
	mov [bp+6],bx
exitduck:
	pop bx
	pop bp
	ret 2
;-----------------------------------------------
;Main of program
;-----------------------------------------------
start:
; GOOSE MAIN
mov bx,0		; space for value return
push bx
call goose
pop bx		; bx has the value of return from function goose
;-----------------------------------------------
; SKY MAIN
mov bx, 0
push bx
mov bx, 4
push bx
mov bx, 2
push bx
call sky
pop bx 		; bx has the value of return from function sky
;-----------------------------------------------
; SHEEP MAIN
mov bx,0
push bx
mov bx,-10
push bx
call sheep
pop bx		; bx has the value of return from function sheep
;-----------------------------------------------
; DUCK MAIN
mov bx,0
push bx
mov bx,-5
push bx
call duck
pop bx		; bx has the value of return from function duck
;-----------------------------------------------
mov ax,0x4c00
int 0x21


