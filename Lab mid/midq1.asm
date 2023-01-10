;21L-7512 Abdullah Dar BSCS 3G MID Q1

[org 0x0100]

jmp start

arr: db 7,4,8,2,7,7,9,5,6,1 ; array
min: db 0 ; storing min
max: db 0 ; storing max

updatemin:
	 mov [min],al 	; update min
	jmp return1
updatemax:
	mov [max],al	;update the max 
	jmp return2
start:

mov cx,10		 	 ; size of array
mov si,0   			 ; si used for indexing
mov al,[arr+si] 		 ; placing first ele in al
mov [min],al			 ; placing first index at min and max
mov [max],al

loop1:
        mov al,[arr+si]		; checking witj al register
	cmp al,[min]		; comparing
	jl updatemin		; if al has smaller value than min then jump  for updation
	return1:
	cmp al,[max]		; cmp al with max 
	jg updatemax		; if al has greater value than max than jmp for updation
	return2:
	inc si			; inc si for next index 
	cmp si,cx		; cmp si with size of array
	jne loop1		; loop till si eqaul size

mov ax,0x4c00		;termination here
int 0x21


	
	

