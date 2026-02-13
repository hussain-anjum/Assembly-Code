;3.Case conversion upper to lower & lower to : 

.MODEL SMALL
.STACK 100H

.DATA
    CR      EQU 0DH
    LF      EQU 0AH
    
    MSG1    DB 'Enter a letter: $'
    MSG2    DB CR, LF, 'Converted letter: $'
    CHAR    DB ?

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    LEA DX, MSG1
    MOV AH, 9
    INT 21H
    
    MOV AH, 1
    INT 21H
    MOV CHAR, AL
    
    CMP AL, 'A'
    JL SKIP
    
    CMP AL, 'Z'
    JG CHECK_LOWER
    
    ADD CHAR, 32
    JMP DISPLAY
    
CHECK_LOWER:
    CMP AL, 'a'
    JL SKIP
    
    CMP AL, 'z'
    JG SKIP
    
    SUB CHAR, 32
    
SKIP:
DISPLAY:
    LEA DX, MSG2
    MOV AH, 9
    INT 21H
    
    MOV DL, CHAR
    MOV AH, 2
    INT 21H
    
    MOV AH, 4CH
    INT 21H
    
MAIN ENDP
END MAIN

