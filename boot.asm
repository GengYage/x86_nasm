[org 0x7c00]

mov ax, 3

; bios调用，清空屏幕
int 0x10

xchg bx, bx

;初始化段寄存器
mov ax, 0
mov ds, ax
mov es, ax
mov ss, ax
mov sp, 0x7c00

; mov ax, 5
; mov bx, 7
; ; ax = ax + bx
; add ax, bx

;清空标志位
clc;

mov ax, [number1]
mov bx, [number2]
add ax, bx
mov [sum], ax

mov ax, [number1 + 2]
mov bx, [number2 + 2]
adc ax, bx
mov [sum + 2], ax

number1:
    dd 0xcfff_ffff
number2:
    dd 4

sum:
    dd 0x0000_0000

halt:
    jmp halt

times 510 - ($ - $$) db 0
;小端存储
dw 0xaa55