;Question no 1  ROLL NO 21L-7512 BSCS-3G LAB 5 COAL

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

star:		        
                        push es
			push ax
			push di
			mov ax, 0xb800
			mov es, ax					; point es to video base
			mov di, 0				
movright:	
                        call delay                                      ; delay calling
                        mov word [es:di], 0x0720                        ; printing space
                        add di, 2	
                        mov word [es:di], 0x072A                        ; print star						                
			cmp di, 158			                ; has the whole screen cleared
		        jne movright					; if no clear next position
movbottom:
                        call delay                                      ; delay calling                       
                        mov word [es:di], 0x0720                        ; printing space
                        add di, 160	                      
                        mov word [es:di], 0x072A                        ; print star
	         	call delay                                      ; delay calling			             
			cmp di, 3998			                ; has the whole screen cleared
			jne movbottom					
movleft:	
                        call delay                                      ; delay calling
                        mov word [es:di], 0x0720                        ; printing space
                        sub di, 2	
                        mov word [es:di], 0x072A                        ; print star						               
			cmp di, 3840			                ; has the whole screen cleared
			jne movleft	
movtop:
                        call delay                                      ; delay calling       
                        mov word [es:di], 0x0720                        ; printing space
                        sub di,160	                       
                        mov word [es:di], 0x072A                        ; print star
		        call delay                                      ; delay calling	        		
                 	cmp di, 0		                 	; has the whole screen cleared
			jne movtop
		        mov word [es:di], 0x072A                        ; print star                        
			pop di
			pop ax
			pop es
                        mov di,0
                        ret


delay:                  push cx
			mov cx, 0xFFFF
loop1:		loop loop1
			mov cx, 0xFFFF
loop2:		loop loop2
			pop cx
			ret


start:
    
       call clrscr 
       call star 








