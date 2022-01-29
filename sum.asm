[org 0x7c00]

mov ax, 3
int 0x10

mov ax, 0
mov cx, 100

; start:
;     add ax, cx
;     sub cx, 1
;     ; 判断 cx是否为0,为0跳转到end
;     jz end
;     jmp start

start: 
    add ax, cx
    loop start

end:

xchg bx, bx


times 510 - ($ - $$) db 0
dw 0xaa55