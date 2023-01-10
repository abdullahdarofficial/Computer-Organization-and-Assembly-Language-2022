;Activity no 2
;LAB 4 21L-7512


[org 0x0100]

mov cx, 32                          ; 32 bits i.e b is 32 bit number
mov bl,1                            ;bl=1

bit_wise:                           ;bitwise label
              test bl,[b]           ;test bl with value st
              je skip               ;if equal then move to label skip

              mov ax, [a]           ;moving all bits to result by taking 16 bits at a time
              add [result],ax       ; due to restriction of 16 bit registers
              mov ax, [a+2]
              adc [result+2], ax
              mov ax, [a+4]
              adc [result+4], ax
              mov ax, [a+6] 
              adc [result+6], ax       

skip:    
              shr word [b+2],1      ; it will shift b right instead
              rcr word [b],1        ; of shifting bl left bits
              shl word [a],1 
              rcl word [a+2],1      ;rotating a bit through carry left
              rcl word [a+4],1
              rcl word [a+6],1

              dec cx                ;cx-=1
              jnz bit_wise          ;repeat loop till zero

              mov ax, 0x4c00        ;termination code
              int 0x21


;GLOBAL VARIABLES

a: dd 0xABCDD4E1, 0x0               ; 64 bits  by allocating two dd consective                
b: dd 0xAB5C32                      ; 32 bits                 
result: dd 0x0, 0x0                 ; 64 bits  