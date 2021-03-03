code segment
assume cs : code
assume ds : code

init :
   mov si , offset str1
   mov di , offset str2

compare :
   mov al , cs :[ si ]
   mov bl , cs :[ di ]
   
  cmp al,bl
  jg greater    ;if al>bl then jump to the code labeled greater
  je equal      ;if al=bl then jump to the code labeled equal      
  jl less          ;if al<bl then jump to the code labeled less
        
                  
greater :
   mov al , 1d
   jmp printleds
less :
   mov al , 3d
   jmp printleds
equal :
   inc si                ;increment the pointers si and di and jump back to  
   inc di               ;the code labeled ''compare'' unless              
   cmp al, '$'       ;encountering the '$' -signaling the end of string-
   jne compare   ;in either of the input strings
                  
   mov al , 2d
printleds :
   mov dx , 3FD2h
   out dx , al
   hlt

str1 db ’ aarabcx$ ’
str2 db ’ aarabcxz$ ’
code ends
end init