[org 0x7c00]

mov ax, 3
int 0x10

; bochs 断点
xchg bx, bx

mov ax, 0xb800 ; 显示器文本内存区域
mov es, ax; 段寄存器起始地址设置为 0xb800

mov si, message ; 源操作数
mov di, 0 ; 目的操作数

print:
    mov bl, [si] ; 将源操作数移动到bl
    
    cmp bl, 0; 遇到0跳出打印
    jz print_end

    mov [es:di], bl ; 将bl移动到段寄存器
    
    inc si
    add di, 2 ; 两个字节控制一个文字
    
    jmp print

print_end:


jmp $

message:
    db 'hello, world', 0

times 510 - ($ - $$) db 0
dw 0xaa55