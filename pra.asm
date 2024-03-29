.model small
.stack 100h
.386
.data
    oneChar db ?, '$'
    array dw 10000 Dup(?)
    size_of_array dw ?
    
    
.code
start:
    ; Инициализация сегмента данных
    mov ax, @data
    mov ds, ax

    xor ax, ax
    xor di, di
    xor si, si
    mov array[0], 0
    xor si, si
    read_next:
        mov ah, 3Fh
        mov bx, 0h  ; stdin handle
        mov cx, 1   ; 1 byte to read
        mov dx, offset oneChar   ; read to ds:dx 
        int 21h   ;  ax = number of bytes read

        or ax, ax
        je stop_reading

        cmp oneChar, ' '
        jz add_number_to_array

        cmp oneChar, 13 ; CR
        je add_number_to_array
        cmp oneChar, 10 ; LF
        je add_number_to_array

        cmp oneChar, '0'
        jb jump_over

        cmp oneChar, '9'
        ja jump_over


        mov ax, array[di]

        mov cl, oneChar
        
        sub cl, '0'
        mov bx, 10
        mul bx
        add ax, cx

        jump_over:
            mov si, '1'
            mov array[di], ax
            jmp read_next
            
        add_number_to_array:
            cmp si, '1'
            jnz no_number_here

            nextNum:
                add di, 2
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
    div cx

    endss:
    mov size_of_array, ax

    xor di, di
    xor si, si
    xor ax, ax
    xor bx, bx
    xor dx, dx
    xor cx, cx
    call BubbleSort
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


    ; output single number which located in register ax
    out_one_number PROC
        first:  
                xor bx, bx
                xor     cx, cx
                mov     bx, 10 ; основание сс. 10 для десятеричной и т.п.
                mov     bx, 10 ; system
            second:
                xor     dx,dx
                div     bx

                push    dx
                inc     cx
                test    ax, ax
                jnz     second
                mov     ah, 02h
            third:
                pop     dx
                add     dl, '0'
                int     21h
                loop    third
        ret
    out_one_number ENDP

    ; print avarage number of the array
    findin_avarage_in_array proc
        xor di, di
        xor eax, eax
        xor ebx, ebx
        mov si, word ptr size_of_array

        countAv:
            mov bx, array[di]

            add eax, ebx

            add di, 2
            dec si
            cmp si, 0
            jbe exit2
            jmp countAv

        exit2:
            xor edx, edx
            div size_of_array

            xor ebx, ebx
            call out_one_number
            xor eax, eax

            ret
    findin_avarage_in_array ENDP

    ;bubble sort for array
    BubbleSort proc
        mov cx, word ptr size_of_array
        dec cx
        outerLoop:
            push cx
            lea si, array
        innerLoop:
            mov ax, [si]
            cmp ax, [si + 2]
            jl nextStep
            xchg [si + 2], ax
            mov [si], ax
        nextStep:
            add si, 2
            loop innerLoop
            pop cx
            loop outerLoop
        ret
    BubbleSort ENDP

    ; опис 
    find_middle_element_in_array PROC
        xor dx, dx
        mov bx, 2
        mov ax, word ptr size_of_array
        
        div bx
        mul bx
        mov di, ax
        mov ax, array[di]
        xor di, di
        xor bx, bx

        call out_one_number

        ret
    find_middle_element_in_array ENDP

end start