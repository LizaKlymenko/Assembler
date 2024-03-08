.model small
.stack 100h

.data
input_buffer   db 100 dup(?)   ; Буфер для введених даних
output_buffer  db 100 dup(?)   ; Буфер для виведених даних

.code
start:
mov cx, 10  ; counter
mov si, offset src   ; addr of source
mov di, offset dest  ; addr of dest
cld   ;  left-to-right order
rep movsb   ; repeat bytes movs until CX=0
mov ah, 02h
mov dl, '0'
int 21h


end start