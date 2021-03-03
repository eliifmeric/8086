CODE SEGMENT
 ASSUME CS : CODE , DS : CODE

 init :
 MOV CL , 0D
 MOV AL , 11D ; input value -- needs to be modified
 MOV DL , AL ; input value is copied into DL for further use

iseven : ; evenness check
 MOV BL , 2D
 IDIV BL ; ( signed ) divide input value with two
 CMP AH , 0D ; check if the reminder ( stored in AH ) is 0
 JE lp ; if so ( meaning that the input number is even ) ,
 ; jump into the loop with the input value itself

 SUB DL , 1D ; otherwise decrement the input value and then loop

 lp :
 ; compute the summation here
  ADD CL, DL
  SUB DL, 2D
  CMP DL, 0D
  JG lp

 printleds :
 MOV AL, CL
 MOV DX, 3FD2H
 OUT DX, AL

 halt :
 HLT

 CODE ENDS
 END init