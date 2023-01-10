 ;Question no 3 ROLL NO 21L-7512 BSCS-3G LAB 5 COAL

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
                        ret

screen:	
                        push es
			push ax
			push di

			mov ax, 0xb800
			mov es, ax					; point es to video base
			mov di, 0	
		
underscore:	
                        mov word [es:di], 0x075F	                ; clear next char on screen
			add di, 2					; move to next screen location
			cmp di, 2080			        	; has the whole screen cleared
			jne underscore			 		; if no clear next position
dot:
                        mov word [es:di], 0x072E	                ; clear next char on screen
			add di, 2					; move to next screen location
			cmp di, 4000			        	; has the whole screen cleared
			jne dot		        	 		; if no clear next position

			pop di
			pop ax
			pop es
                        mov di,0
                        ret

start:
    
       call clrscr 
       call screen 

