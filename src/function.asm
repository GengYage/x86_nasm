[org 0x7c00]

mov ax, 3
int 0x10

; 设置栈寄存器

mov ax, 0
mov ss, ax
mov sp, 0x7c00

xchg bx, bx

; 段寄存器es 默认与 bx配对

; 设置计数器为10
mov cx, 10
;调用10次函数
prints:
    xchg bx, bx
    ; 远调用,相当于callif,会入栈两个地址,cs和ip
    call 0:print
    loop prints

jmp $

video:
    dw 0x0

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
    ; retif, 远调用使用,相当于 pop ip, pop cs

    ; 还原调用方寄存器
    pop es
    pop bx
    pop ax
    
    retf


times 510 - ($ -$$) db 0
dw 0xaa55