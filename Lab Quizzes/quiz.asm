[org 0x0100]

jmp start

text1: db 'Hi, you pressed a ', 17
text2: db 'Hi, you pressed b ', 17
text3: db 'Wrong Credentials ', 18
counter: dw 0

clrscr: 
		push es
		push ax
		push cx
		push di
		mov ax, 0xb800
		mov es, ax 
		xor di, di 
		mov ax, 0x0720 
		mov cx, 2000 
		cld 
		rep stosw 
		pop di 
		pop cx
		pop ax
		pop es
		ret 

printstr:	
			push bp
			mov bp, sp
			pusha

			mov ax,18
			cmp ax, 0
			jz exitt
			mov cx, ax 
			mov ax, 0xb800
			mov es, ax
			mov al, 80 
			mul byte [bp+8] 
			add ax, [bp+10]
			shl ax, 1 
			mov di,ax 
			mov si, [bp+4] 
			mov ah, [bp+6]
			cld 
			nextchar: lodsb 
			stosw
			loop nextchar
			exitt: 
			popa
			pop bp
			ret 8 


pressa:
		mov ax, 0
		push ax  
		mov ax,2	; x
		push ax 
		mov ax, 0x71 	; y
		push ax 
		mov ax, text1
		push ax 
		call printstr 

jmp return1

pressb:
		mov ax, 0
		push ax  
		mov ax, 4	; x
		push ax 
		mov ax, 0x71 	; y
		push ax 
		mov ax, text2
		push ax 
		call printstr 
jmp return1

else:
		mov ax, 0
		push ax  
		mov ax, 6	; x
		push ax 
		mov ax, 0x71 	; y
		push ax 
		mov ax, text3
		push ax 
		call printstr 
jmp return1
start:

mov ah,0
int 0x16
call clrscr

		
mov cx,4
loop1:
mov ah,0
int 0x16
cmp al,0x61
je pressa
cmp al,0x62
je pressb
jne else
return1:
loop loop1

		

mov ax,0x4c00
int 0x21

