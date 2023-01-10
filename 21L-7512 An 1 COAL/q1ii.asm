;Q1 (ii) signed
[org 0x0100]

mov cx,10        ; counter = 10
mov si,0         ; source index = 0
mov ax,[array]   ; AX = array[0]
mov [min],ax     ; [min]=AX
mov [max],ax     ; [max]=AX

update_max:      ; label for updating max
mov [max],ax     ; [max]=AX
jnl return

update_min:      ; label for updating min
mov [min],ax     ; [min]=AX
jl return 

loop1:
      cmp ax,[max]      ; comparing ax with max
      jnl update_max    ; jump if max < AX
      cmp ax,[min]      ; comparing ax with min
      jl update_min     ; jump if min > AX
      return:           ; label for return used by labels of updation
      add si,2          ; SI=SI+2
      mov ax,[array+si] ; AX=[array+si]
      sub cx,1          ; counter --
jnz loop1               ; jump to loop1 if cx=0

mov ax,0x4c00    ; termination of code
int 0x21

array: dw -5,-7,13,9,-1,-24,14,25,-17,11   ; array declared globally
min: dw 0                                  ; min = 0  
max: dw 0                                  ; max = 0