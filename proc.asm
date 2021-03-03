code segment
    init:
    mov ax,data
    mov ds,ax
    mov si,offset arr
    mov di,offset result 
    mov cl,length
    mov bx,result 
    
    call decimal
    hlt
    
    decimal proc   
 
    loopbody: 
    mov ah,0d
    mov al,[si]
    push ax 
    cmp ax,base
    jge endlabel
    cmp ax,0d
    jl endlabel
    mov ax,base 
    mul bx      
    mov bx,ax
    pop ax 
    add bx,ax 
    inc si
    dec cl 
    cmp cl,0d
    jne loopbody
    je assign
    
    
    endlabel:
    mov bx,-1d
    mov [di],bx
    hlt
   
    assign:
    mov [di],bx
    hlt
   
   
    decimal endp
    code ends


    data segment
    arr db 1d,5d,3d,4d,2d
    length = ($-arr)
    result dw 0d
    base dw 7d
    
    data ends  
    
    stack segment
    dw 128 dup(0)
    stack ends
      
    end init
