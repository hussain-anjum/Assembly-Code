; Fibonacci series:

.MODEL SMALL
.STACK 100H

.DATA
    MSG     DB 'FIBONACCI: $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    LEA DX, MSG
    MOV AH, 09H
    INT 21H
    
    MOV AX, 0
    MOV BX, 1
    MOV CX, 10
    
PRINT_FIB:
    PUSH AX
    CALL PRINTNUM
    
    MOV DL, ' '
    MOV AH, 02H
    INT 21H
    
    POP AX
    
    MOV DX, AX
    ADD AX, BX
    MOV BX, DX
    
    LOOP PRINT_FIB
    
    MOV AH, 4CH
    INT 21H 
    
MAIN ENDP

PRINTNUM PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    XOR CX, CX
    MOV BX, 10
    
PRINT_LOOP:
    XOR DX, DX
    DIV BX
    PUSH DX
    INC CX
    
    TEST AX, AX
    JNZ PRINT_LOOP
    
PRINT_DIGITS:
    POP DX
    ADD DL, '0'
    MOV AH, 02H
    INT 21H
    
    LOOP PRINT_DIGITS
    
    POP DX
    POP CX
    POP BX
    POP AX
    
    RET
PRINTNUM ENDP

END MAIN



