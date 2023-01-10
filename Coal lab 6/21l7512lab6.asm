;lab no 6 - 21L-7512 - BSCS-3G

[org 0x0100]

jmp start
;-------------------------------------------------------------------
oldisr: dd 0 ; space for saving old isr 
buffer: times 4000 db 0 
sleep:		
		push cx
		mov cx, 0xFFFF
delay:		loop delay
		pop cx
		ret
;--------------------------------------------------------------------
; subroutine to clear the screen
;--------------------------------------------------------------------
clrscr:		
			push es
			push ax
			push di

			mov ax, 0xb800
			mov es, ax					; point es to video base
			mov di, 0					; point di to top left column

nextloc:		mov word [es:di], 0x0720			; clear next char on screen
			add di, 2					; move to next screen location
			cmp di, 4000					; has the whole screen cleared
			jne nextloc					; if no clear next position

			pop di
			pop ax
			pop es
			ret

;-----------------------------------------------------------------
; subroutine to save the screen
;-----------------------------------------------------------------
saveScreen:	
			pusha						; push all general purpose registers
			mov cx, 4000 					; number of screen location
			mov ax, 0xb800
			mov ds, ax					; ds = 0xb800
			push cs
			pop es
			mov si, 0
			mov di, buffer

			cld						; set auto increment mode
			rep movsb 					; save screen
			popa						; pop all general purpose registers
			ret
;-----------------------------------------------------------------
; subroutine to restore the screen
;-----------------------------------------------------------------
restoreScreen:		
			pusha						; push all general purpose registers
			mov cx, 4000 					; number of screen locations
			mov ax, 0xb800
			mov es, ax 					; ds = 0xb800
			push cs
			pop ds		
			mov si, buffer
			mov di, 0
			cld 						; set auto increment mode
			rep movsb 					; save screen
			popa						; pop all general purpose registers
			ret	
;-------------------------------------------------------------------
; keyboard interrupt service routine
;-------------------------------------------------------------------
kbisr:		
                        push ax
			push es
			mov ax, 0xb800
			mov es, ax 					; point es to video memory
			in al, 0x60 					; read a char from keyboard port
loop1:		
                        cmp al, 0x30                                   ; Pressed key = b
			jne nextcompare                                 ; if not equal compare next key
			call saveScreen					; saving screen if key is b
			call clrscr					; clear screen after saving
                        jmp end             				; jmp to last
nextcompare:	
                	cmp al, 0xB0					; comparing with other keys
			jne nomatch					; jump to nomatch label if not equal
                	;call sleep					; for checking execution
          		call restoreScreen				; restoring screen
			jmp end						; jump to last
nomatch:	
                	pop es
			pop ax
			jmp far [cs:oldisr]           			; call the original ISR
end:
			mov al, 0x20					; moving intrrupt call to al
			out 0x20, al          				;  send EOI to PIC
			pop es
			pop ax

			iret 						; return from interrupt
;-------------------------------------------------------------------
;Main Function
;-------------------------------------------------------------------
start:	
		xor ax, ax
		mov es, ax 
		mov ax, [es:9*4]
		mov [oldisr], ax 					; save offset of old routine called
		mov ax, [es:9*4+2]
		mov [oldisr+2], ax 					; save segment of old routine called
		cli 							; disabling ints
		mov word [es:9*4], kbisr 				; store offset at n*4
		mov [es:9*4+2], cs 					; store segment at n*4+2
		sti 							; enable interrupts
		mov dx, start 						
		add dx, 15 						; adding 15 to round up to next paragraph
		mov cl, 4
		shr dx, cl 						; 2^4
		mov ax, 0x3100 						; stay resident
		int 0x21