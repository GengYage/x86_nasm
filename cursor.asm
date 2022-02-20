[org 0x7c00]

CRT_ADDR_REG equ 0x3D4
CRT_DATE_REG equ 0x3D5

CRT_CURSOR_HIGH equ 0x0E
CRT_CURSOR_LOW equ 0x0F

mov ax, 3
int 0x10

; bochs 断点
xchg bx, bx

mov ax, 15 * 80

call set_cursor

; 清空ax
mov ax, 0x0000

;验证ax是否位0x04b0
call get_cursor

jmp $

set_cursor:
    ; 设置光标位置,参数用ax传递
    ; 暂存 dx,bx
    push dx
    push bx
    
    ; 用bx存储光标位置, 因为下面会修改ax
    mov bx, ax

    mov dx, CRT_ADDR_REG
    mov al, CRT_CURSOR_LOW
    out dx, al

    mov dx, CRT_DATE_REG
    mov al, bl
    out dx, al

    mov dx, CRT_ADDR_REG
    mov al, CRT_CURSOR_HIGH
    out dx, al

    mov dx, CRT_DATE_REG
    mov al, bh
    out dx, al

    ; 恢复寄存器
    pop bx
    pop dx
    ret

get_cursor:
    push dx,
    ;获取光标高八位 dx, al 端口号, ax存储光标位置
    mov dx, CRT_ADDR_REG
    mov al, CRT_CURSOR_HIGH
    out dx, al

    mov dx, CRT_DATE_REG
    mov al, bh
    in al, dx
    ; ax 左移8位,因为先获取的高八位
    shl ax, 8
    ; 获取低八位
    mov dx, CRT_ADDR_REG
    mov al, CRT_CURSOR_LOW
    out dx, al

    mov dx, CRT_DATE_REG
    mov al, bl
    in al, dx
    
    pop dx
    ret


message:
    db 'hello, world', 0

times 510 - ($ - $$) db 0
dw 0xaa55