.model small
.stack 100h
.386
.data
    oneChar db ?, '$'
    array dw 10000 Dup(?)
    size_of_array dw ?
    
    
.code
start:
    ; Иниціализація сегмента данных
    mov ax, @data
    mov ds, ax

    xor ax, ax
    xor di, di
    xor si, si
    mov array[0], 0
    xor si, si
    read_next:
        mov ah, 3Fh
        mov bx, 0h  ; ввід даних з stdin 
        mov cx, 1   ; 1 byte to read
        mov dx, offset oneChar   ;
        int 21h          ;Виклик DOS-служби для чит символу

        or ax, ax;  ax = number of bytes read
        je stop_reading

        cmp oneChar, ' '; Перевірка, чи символ - пробіл
        jz add_number_to_array

        cmp oneChar, 13 ; перевірка чи це CR
        je add_number_to_array
        cmp oneChar, 10 ; LF
        je add_number_to_array
