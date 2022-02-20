[org 0x7c00]

; 中断处理器主片控制端口 
PIC_M_CMD equ 0x20
; 数据端口
PIC_M_DATA equ 0x21

mov ax, 3
int 0x10

; bochs 断点
xchg bx, bx

; 注册时钟中断
; 四个字节是一个中断向量号 时钟中断是8
mov word [8 * 4], clock
mov word [8 * 4 + 2], 0

; 设置中屏蔽字 OCW1
mov al, 0b1111_1110
out PIC_M_DATA, al

; 打开cpu中断标识
sti;
; 关闭中断
; cli

loopA:
    mov bx, 3
    mov al, 'A'
    call blank
    jmp loopA

; 中断调用之前 中断标识是1 中断中是0 
; 防止处理中断时发生中断
clock:
    ; 中断处理 会 push flags, push cs, push ip
    ; xchg bx, bx
    push bx
    push ax

    mov bx, 4
    mov al, 'C'
    call blank

    ;中断处理完毕 OCW2
    mov al, 0x20
    out PIC_M_CMD, al

    pop ax
    pop bx
    iret

blank:
    push dx
    push es

    mov dx, 0xb800
    mov es, dx

    shl bx, 1
    ; 将第三个字符拿到dl
    mov dl, [es:bx]
    
    cmp dl, ' '
    ; 不是空格
    jnz .set_speac
    ; 是空格
    .set_char:
        mov [es:bx], al
        jmp .done
    .set_speac:
        mov byte [es:bx], ' '
    .done:
        shr bx, 1

    pop es
    pop dx
    ret

jmp $


    

times 510 - ($ - $$) db 0
dw 0xaa55