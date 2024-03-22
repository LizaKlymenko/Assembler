.model small
.stack 100h

.data
    srcMsg db "1234567890123456$", 0   ; Десяткове число в рядковому форматі
    destMsg db 32 dup(?)               ; Місце для завдання 2: суми 16-бітних чисел

.code
    mov ax, @data
    mov ds, ax

    ; Завдання 1: конвертує десяткове значення у бінарне представлення (слово) у доповнювальному коді
    mov si, offset srcMsg
    mov di, offset destMsg
    call decimalToBinaryComplement

    ; Завдання 2: сумує 16-бітні числа та накопичує результат у 32-бітному (2 слова)
    call sum16bitNumbers

    mov ah, 4Ch
    int 21h

decimalToBinaryComplement PROC
    mov cx, 16             ; Лічильник для циклу

    cld                    ; Очистити прапор напрямку (читати зліва направо)

convertLoop:
    mov al, [si]           ; Завантажити поточний символ в al
    cmp al, '$'            ; Перевірити, чи досягнуто кінця рядка
    je endConversion       ; Якщо символ '$', завершити конвертацію
    sub al, '0'            ; Конвертувати ASCII від '0' до числа
    not al                 ; Інвертувати біти у числі
    stosb                  ; Записати байт в destMsg
    inc si                 ; Перейти до наступного символу
    loop convertLoop

endConversion:
    ret
decimalToBinaryComplement ENDP

sum16bitNumbers PROC
    mov cx, 8

    mov si, offset srcMsg  ; Адреса першого числа
    mov di, offset destMsg ; Адреса для накопичення результату

sumLoop:
    mov ax, 0             ; Обнулити регістр ax
    lodsw                 ; Завантажити 16-бітне число в ax
    add word ptr [di], ax ; Додати 16-бітне число до результату в destMsg
    adc word ptr [di+2], 0 ; Додати carry до старших біть

    add di, 4             ; Перейти до наступного 16-бітного числа у destMsg
    loop sumLoop

    ret
sum16bitNumbers ENDP

end
