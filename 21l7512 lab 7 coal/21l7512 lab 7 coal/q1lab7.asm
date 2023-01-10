; question 1 abdullah dar lab 7 21l7512 bscs 3g coal


; Timer interrupt comes 18.2 times per second.
; after every 55ms
; display a tick count on the top right of screen
[org 0x0100]
jmp start
tickcount: dw 0
starloc: dw 0,0,0
;------------------------------------------------------
; subroutine to print a number at top left of screen
; takes the number to be printed as its parameter
;------------------------------------------------------
printnum:
 push bp
mov bp, sp
push es
push ax
push bx
push cx
push dx
push di

mov ax, 0xb800
mov es, ax 		; point es to video base

mov ax, [bp+4] 		; load number in ax
mov bx, 10 		; use base 10 for division
mov cx, 0			 ; initialize count of digits
nextdigit:
mov dx, 0 		;remainder dx ; ax qoutient	; zero upper half of dividend
div bx 			; divide by 10
add dl, 0x30		; convert digit into ascii value
push dx 			; save ascii value on stack
inc cx 			; increment count of values
cmp ax, 0 			; is the quotient zero
jnz nextdigit		 ; if no divide it again

mov di, 464 		; point di to 70th column

nextpos:
	pop dx 			; remove a digit from the stack
	mov dh, 0x07		 ; use normal attribute
	mov [es:di], dx 		; print char on screen
	add di, 2			 ; move to next screen location
	loop nextpos		 ; repeat for all digits on stack
	
	
	


pop di
pop dx
pop cx
pop bx
pop ax 
pop es
pop bp
ret 2
;------------------------------------------------------
printstar:


push bp
mov bp, sp
push es
push ax
push bx
push cx
push dx
push di


jmp starstart 

top:
add di,2
jmp exit

corner:
sub di,2
jmp exit

down:
mov di, [starloc]
cmp di,3998
je corner
cmp di,3840
ja return1
add di,160
jmp exit

bottom:

sub di,2
jmp exit

up:

mov di,[starloc]
cmp di,0
jna return1
sub di,160
jmp exit

save:

mov ax,[es:di+160]
mov [starloc+2],ax
jmp print

starstart:

mov ax, 0xb800
mov es, ax 		; point es to video base

mov di, [starloc] 	; getting old location	
cmp di,0
je save
print:
mov ax,[starloc+2]	; saving that old screen block
mov [es:di],ax		; printing on screen


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
mov [starloc+2],ax
mov word[es:di],0x0f2a
mov [starloc], di

pop di
pop dx
pop cx
pop bx
pop ax 
pop es
pop bp
ret 2


;------------------------------------------------------
; timer interrupt service routine
;------------------------------------------------------
timer:		push ax

			inc word [cs:tickcount]; increment tick count

					push word [cs:tickcount]
					call printnum ; print tick count
cmp word[cs:tickcount],18
jne exitt
mov word[cs:tickcount],0

			push word [cs:starloc]
			call printstar
exitt:
			mov al, 0x20
			out 0x20, al ; end of interrupt

			pop ax
			iret ; return from interrupt
;------------------------------------------------------
start:		xor ax, ax
			mov es, ax ; point es to IVT base

			cli ; disable interrupts
			mov word [es:8*4], timer; store offset at n*4
			mov [es:8*4+2], cs ; store segment at n*4+2
			sti ; enable interrupts

			mov dx, start ; end of resident portion
			add dx, 15 ; round up to next para
			mov cl, 4
			shr dx, cl ; number of paras

			mov ax, 0xb800
			mov es, ax 		; point es to video base
			mov di,0
			mov ax,[es:di]
			mov [starloc+2],ax

			mov ax, 0x3100 ; terminate and stay resident
			int 0x21 