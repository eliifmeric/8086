code segment
    start:
    mov ax, data
    mov ds, ax
    mov ax, stack
    mov ss, ax
    mov si, offset str
    mov di, offset result
    mov ax, 00'/'
    push ax
    mov bx, 00'a'
  
  process:
    mov al, [si]
    cmp al, '$' ;compare if it's the end of string identifier or not
    je scheck   ;if equal, jump to scheck, if not continue
    cmp al, 'd' ;compare if it's 'd' or not
    je spush    ; if it's a 'd', go to spush, otherwise continue
    cmp al, 'c' ;compare if it's a 'c' or not
    je spop     ;if it's a 'c', go to spop label.
    jne reject  ;if the character isn't equal to 'd', 'c' or '$', jump to reject label
    
    scheck:
    pop bx
    cmp bl,al
    jge greater
       
    spop:
    pop bx      ;if there is a 'c', pop the top of the stack.
    inc si      ;increment si
    inc result  ;increment result
    cmp bl,'/'  ;compare that if it's the bottom of the stack identifier 
    je  counter ;if equal, jump to counter label
    jmp process ;if not equal, go back to process label.
    
    spush:
    push bx     ;if there is a 'd', it pushes bx(namely the value 00'a') into the stack.
    inc si      ;increment si
    jmp process ;then jump to first step (process).
  
    
    counter:
    mov [si], al       
    hlt 

    greater:
    mov [di], -1d ;if number of 'd' is greater than or equal to number of 'c',
    mov al, [di]  ;the result will be -1
    hlt
    
    reject:
    mov [di], -2d ;if the character isn't equal to 'd', 'c' or '$'
    mov al, [di]  ;the result will be -2
    hlt
    
data segment
    str db "dcddccc$" 
    result db 0d
    data ends

stack segment
    dw 128 dup(0)
    stack ends
end start
    



