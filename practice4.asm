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
;додала числа до масиву array, які були введені з консолі
        cmp oneChar, '0'; порівнюємо значн
        jb jump_over ;Перескочуємо, якщо oneChar менше '0'

        cmp oneChar, '9'
        ja jump_over


        mov ax, array[di] ;Завантажуємо значення з масиву в регістр ax

        mov cl, oneChar
        
        sub cl, '0';Віднімаємо ASCII-код '0' від oneChar для десят-формат
        mov bx, 10
        mul bx ; ax множимо на bx
        add ax, cx

        jump_over:
            mov si, '1'
            mov array[di], ax
            jmp read_next
            
        add_number_to_array:
            cmp si, '1' ; Перевіряємо, чи вже було додано число до масиву
            jnz no_number_here

            nextNum:
                add di, 2 ; додаємо до індексу масиву,  двобайтові елементи
                mov array[di], 0

            no_number_here:
                mov si, '0'
                jmp read_next

    stop_reading:

    cmp si, '1' 
    jnz i12

    add di, 2

    i12:
    mov cx, 2
    mov ax, di
    div cx ;Ділення значення di на 2

    endss:
    mov size_of_array, ax ; збереження результату ділення у змінну 

    xor di, di ; Обнулення всіх регістрів 
    xor si, si
    xor ax, ax
    xor bx, bx
    xor dx, dx
    xor cx, cx
    call BubbleSort ;процедура бульбашкового сортування
    call find_middle_element_in_array

    mov ah, 02h
    mov dl, 10
    int 21h

    xor ax, ax
    xor dx, dx

    call findin_avarage_in_array

    mov ah, 02h
    mov dl, 10
    int 21h

    mov ax, 4C00h
    int 21h

