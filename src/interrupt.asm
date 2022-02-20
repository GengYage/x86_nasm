[org 0x7c00]

;软中断

mov ax, 3
int 0x10

;注册中断
mov ax, 0
mov ss, ax
;注册中断要确保ds为0
mov ds, ax

xchg bx, bx

; 中断其实存储的是2个字节的偏移地址,2个字节的段地址
mov word [0x80 * 4], print
mov word [0x80 * 4 + 2], 0

; 触发中断其实是间接寻址的函数调用,因为地址是从内存中读出来的
; 触发中断
int 0x80

jmp $

print:
    ;保存调用方的寄存器
    push ax
    push bx
    push es


    ; 显卡内存
    mov ax, 0xb800 
    mov es, ax
    ; 偏移地址
    mov bx, [video]
    ; 打印.
    mov byte [es:bx], '.'
    ; 跳过设置字体格式
    add word [video], 2

    ; 还原调用方寄存器
    pop es
    pop bx
    pop ax
    
    ; 弹出三个值,flag es ip
    iret

; 间接寻址的函数调用
function:
    dw print, 0

video:
    dw 0x0

times 510 - ($ - $$) db 0

dw 0xaa55