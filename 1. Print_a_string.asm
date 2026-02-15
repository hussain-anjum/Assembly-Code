;1.Print a string:

.MODEL SMALLL
.STACK 100H 
.DATA  
MSG DB 'HELLO WORLD!$' 
.CODE
 
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
 
    LEA DX, MSG
    MOV AH, 9
    INT 21H  
     
;return to DOS
    MOV AH, 4CH
    INT 21H
MAIN ENDP
    END MAIN



