; 1- When user runs your program.com on Dosbox, ask user to enter name, 
; roll number, course name and section on same screen (using DOS or BIOS 
; service). Save the data in a memory. Print user friendly message “Enter
; your name:” (using BIOS/DOS Service).

[org 0x0100]

jmp start

; printing messages
messagename: db 'Enter Your Name : $'
messagerollno: db '                                                                                Enter Your Roll no : $'
messagecourse: db '                                                                                                                                                                Enter Your Course : $'
messagesection: db '                                                                                                                                                                                                                                                Enter Your Section : $'

; input buffers

buffername: db 80
db 0
times 80 db 0

bufferrollno: db 80
db 0
times 80 db 0

buffercourse: db 80
db 0
times 80 db 0

buffersection: db 80
db 0
times 80 db 0


;-------------------------------------------------------------------------------------------
clrscr: 			
		push es 		; pushing relevant registers
 		push ax 
 		push cx 
		push di 

 		mov ax, 0xb800 
 		mov es, ax 		; point es to video base 
 		xor di, di 		; point di to top left column 
 		mov ax, 0x0720 		; space char in normal attribute 
 		mov cx, 2000 		; number of screen locations 
 		cld 			; auto increment mode 
 		rep stosw 		; clear the whole screen 

 		pop di			; popping relevant used registers
 		pop cx 
 		pop ax 
 		pop es 
 		ret 
;-------------------------------------------------------------------------------------------


start:

call clrscr
mov dx,messagename		; printing user name input request
mov ah,9
int 0x21

mov dx,buffername		; taking input from user here
mov ah,0x0a
int 0x21

mov bh,0			; reading the size of user input and putting $ null at the end
mov bl,[buffername+1]
mov byte[buffername+2+bx],'$'

mov dx,messagerollno		; printing user name input request
mov ah,9
int 0x21

mov dx,bufferrollno		; taking input from user here
mov ah,0x0a
int 0x21

mov bh,0			; reading the size of user input and putting $ null at the end
mov bl,[bufferrollno+1]
mov byte[bufferrollno+2+bx],'$'
 
mov dx,messagecourse		; printing user name input request
mov ah,9
int 0x21

mov dx,buffercourse		; taking input from user here
mov ah,0x0a
int 0x21

mov bh,0			; reading the size of user input and putting $ null at the end
mov bl,[buffercourse+1]
mov byte[buffercourse+2+bx],'$'
 
mov dx,messagesection		; printing user name input request
mov ah,9
int 0x21

mov dx,buffersection		; taking input from user here
mov ah,0x0a
int 0x21

mov bh,0			; reading the size of user input and putting $ null at the end
mov bl,[buffersection+1]
mov byte[buffersection+2+bx],'$'

mov ax,0x4c00
int 0x21
