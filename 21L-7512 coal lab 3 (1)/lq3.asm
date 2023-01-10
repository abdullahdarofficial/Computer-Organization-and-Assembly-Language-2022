;Activity 3: Write a program that compresses an ordered array (having multiple occurrences of one
;integer). You are not allowed to use any extra array, just modify the input array.
;Sample Run:
;Arr: 2,2,2,3,4,4,5,5,5,6
;After Compression, Arr: 2,3,4,5,6,0,0,0,0,0


[org 0x0100]

mov al,0
mov cx,10
mov si,0
mov di,0
mov bx,cx
mov [arr+10],al
mov al,0
jmp start

update_index:
             mov dx,si
             loop2:
                   mov bl,[arr+si+1]
                   mov [arr+si],bl
                   add si,1
                   add dx,1
                   return_update_index:
                   cmp cx,dx
                   je return
                   jne loop2
next_index:
           add di,1
           ;mov al,0
           jmp return
          start:          
loop1:
      mov bl,[arr+si]
      cmp bl,[arr+si+1]
      je update_index
      jne next_index
      cmp [arr+di],al
      je next_index
      return:
     
      mov si,di
      cmp di,5
      je end        
      cmp di,10
      jne loop1
     
end:

mov ax,0x4c00            ;termination
int 0x21

arr: db 2,2,2,3,4,4,5,5,5,6



