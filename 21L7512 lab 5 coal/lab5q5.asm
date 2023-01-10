;Question no 5  ROLL NO 21L-7512 BSCS-3G LAB 5 COAL

[org 0x0100]

jmp start

clrscr:		        
                        push es
			push ax
			push di

			mov ax, 0xb800
			mov es, ax					; point es to video base
			mov di, 0	
nextloc:	
                        mov word [es:di], 0x0720	                ; clear next char on screen
			add di, 2					; move to next screen location
			cmp di, 4000			        	; has the whole screen cleared
			jne nextloc			 		; if no clear next position

			pop di
			pop ax
			pop es
                        mov di,0
                        mov bx,0x0760
                        ret

screen:	
                        push es
			push ax
			push di

			mov ax, 0xb800
			mov es, ax					; point es to video base
			mov di, 0
                        mov ax,0x8F00

nextloc1:	
                        mov word [es:di], ax  
                        add di,2 
                        add al,1                                       ; clear next char on screen
			cmp di, 4000			        	; has the whole screen cleared
			jne nextloc1			 		; if no clear next position

			pop di
			pop ax
			pop es
                        mov di,0 
                        ret

start:
    
       call clrscr 
       call screen 

