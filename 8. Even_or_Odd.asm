;  Even or Odd:

.MODEL SMALL
.STACK 100H

.DATA
    MSG_EVEN   DB 'NUMBER IS EVEN.$'
    MSG_ODD    DB 'NUMBER IS ODD.$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX        ; initialize data segment
    
    MOV AX, 15        ; change this to test other numbers
    
    TEST AX, 1        ; CHECK THE LEAST SIGNIFICANT BIT (LSB)
    JZ EVEN_NUMBER    ; IF ZERO, JUMP TO EVEN_NUMBER
    
    ; ODD NUMBER
    LEA DX, MSG_ODD
    JMP PRINT_MSG
    
EVEN_NUMBER:
    LEA DX, MSG_EVEN
    
PRINT_MSG:
    MOV AH, 09H       ; DOS PRINT STRING FUNCTION
    INT 21H
    
    MOV AH, 4CH
    INT 21H
    
MAIN ENDP
    END MAIN

