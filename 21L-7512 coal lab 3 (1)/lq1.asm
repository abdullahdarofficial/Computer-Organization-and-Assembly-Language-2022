;Activity 1 [Conditional Jump]: Find frequency of an integer from an array of 10 integers.
;For example frequency of 2 in array 2, 4, 2, 8, 2 is 3.

[org 0x0100]
mov al,[num]     ;al=[num]
mov cx,1         ;cx=1
mov si,0         ;si=0
mov dl,1         ;dl=1
mov [freq],si
jmp start        ;jump to start label

increment_freq:  ;label
add [freq],dl    ;[freq]=dl+[freq]
jmp return       ;jump return 
start:           ;label
loop1:           ;label
cmp [array+si],al        ;compare 
je increment_freq        ;move to label if equal
return:                  ;label
add si,1                 ;si=si+1
add cx,1                 ;cx=cx+1
cmp cx,10                ;compare 
jne loop1                ; move to loop1 if not equal


mov ax,0x4c00            ;termination
int 0x21

array: db 1,3,12,6,3,2,5,3,9,10
num: db 3
freq: db 0