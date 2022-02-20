[org 0x7c00]

mov ax, 3
int 0x10

xchg bx, bx

mov ax, 0
mov ss, ax

mov sp, 0x7c00

push byte 4 ; 2
push dword 7 ; 4
push word 5 ; 2

pop ax ; 5
pop bx ; 7 低16位
pop cx ; 0 高16位
pop dx ; 4

jmp $

times 510 - ($ - $$) db 0
dw 0xaa55
