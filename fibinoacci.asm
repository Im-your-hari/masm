assume cs:code,ds:data
data segment 
msg1 db 0dh,0ah,"Enter number of terms: $"
msg2 db 0dh,0ah,"Fibonacci series is $"
nwline db 0dh,0ah,"$"
n dw 1
data ends
code segment
print macro msg
push ax
lea dx,msg
mov ah,09h
int 21h
pop ax
endm
read proc
xor ax,ax
push ax
l1:
mov ah,01h
int 21h
cmp al,0dh
je l2
mov ah,00h
sub al,30h
mov bx,ax
mov dx,000ah
pop ax
mul dx
add ax,bx
push ax
jmp l1
l2:
pop ax
ret
read endp
display proc
push ax
push cx
mov bx,000ah
xor cx,cx
l3:
xor dx,dx
div bx
add dx,0030h
push dx
inc cx
cmp ax,0000h
jnz l3
l4:
pop dx
mov ah,02h
int 21h
loop l4
pop cx
pop ax
ret
display endp
fib proc
mov cx,n
xor ax,ax
mov si,0001h
rpt:
print nwline
call display
add ax,si
xchg ax,si
loop rpt
ret
fib endp
start:
mov ax,data
mov ds,ax
print msg1
call read
mov n,ax
print msg2
call fib
mov ah,4ch
int 21h
code ends
end start