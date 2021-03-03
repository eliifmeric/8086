code segment
    
init:
    mov ax,data
    mov ds,ax
    mov ax,stack
    mov ss,ax 
    mov ax,00'/'
    push ax
    mov bx, 00'x'
    
    
    mov ah,09h
    mov dx,offset msg
    int 21h
    
    mov ah, 0ah
    mov dx,offset str
    int 21h
    
    mov si,offset str+2 
    mov al,[si]
    
firstStep:
    cmp al, 'a'
    jne reject   
    
secondStep:
    cmp al, 'a'
    je increment
    
thirdStep:
    cmp al,'b'
    jne reject
    
fourthStep:
    cmp al, 'b'
    je pushlabel
    jne fifthStep
    
fifthStep:
    cmp al, 'c'
    jne reject
    
sixthStep:
    cmp al, 'c'
    je stackPop
    jne seventhStep
    
seventhStep:
    cmp al, '$'
    je poplabel
    jne reject
    
     
eighthStep:
    cmp bl, '/'
    je accept
    jne reject 
    
pushlabel:
    push bx
    push bx
    push bx
    inc si
    mov al, [si]
    jmp fourthStep  
    
poplabel:
    pop bx
    jmp eighthStep
     
stackPop:
    pop bx
    pop bx
    inc si
    mov al, [si]
    jmp sixthStep
    
increment:
    inc si
    mov al, [si]
    jmp secondStep
    
accept: 
    mov cx,1d
    mov ah,09h
    mov dx,offset accepted
    int 21h
    hlt

reject:
    mov cx,0d
    mov ah,09h
    mov dx,offset rejected
    int 21h
    hlt
    

    
data segment
    str db 100 dup("")
    msg db "Input a string ending with the dollar sign: $"
    accepted db 0ah,0dh, "The input string is accepted!$"
    rejected db 0ah,0dh, "The input string is rejected!$"
    
data ends
    
stack segment
    dw 128 dup(0)
stack ends
end init



