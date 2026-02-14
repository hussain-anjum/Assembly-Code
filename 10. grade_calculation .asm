;10. grade calculation  

.MODEL SMALL
.STACK 100H

.DATA
    PROMPT      DB 'ENTER YOUR MARK : ','$'
    BUFFER      DB 255
                DB ?
                DB 255 DUP(?)
    MARKS       DW ?
    NEWLINE     DB 0AH, 0DH, '$'
    GRADEAP     DB 'GRADE : A+', '$'
    GRADEA      DB 'GRADE : A', '$'
    GRADEB      DB 'GRADE : B', '$'
    GRADEC      DB 'GRADE : C', '$'

.CODE
MAIN PROC
    ; INNIT DATA
    MOV AX, @DATA
    MOV DS, AX
    
    LEA DX, PROMPT
    MOV AH, 09H
    INT 21H
    
    LEA DX, BUFFER
    MOV AH, 0AH
    INT 21H
    
    CALL PRINT_NEWLINE
    CALL STR_TO_INT
    MOV MARKS, AX
    
    CMP AX, 80
    JGE PRINT_AP
    
    CMP AX, 70
    JGE PRINT_A
    
    CMP AX, 60
    JGE PRINT_B
    
    JMP PRINT_C
    
PRINT_AP:
    LEA DX, GRADEAP
    JMP PRINT_GRADE
    
PRINT_A:
    LEA DX, GRADEA
    JMP PRINT_GRADE
    
PRINT_B:
    LEA DX, GRADEB
    JMP PRINT_GRADE
    
PRINT_C:
    LEA DX, GRADEC
    
PRINT_GRADE:
    MOV AH, 09H
    INT 21H
    
EXIT:
    ; END
    MOV AH, 4CH
    INT 21H
    
MAIN ENDP

PRINT_NEWLINE PROC
    MOV AH, 09H
    LEA DX, NEWLINE
    INT 21H
    RET
PRINT_NEWLINE ENDP

STR_TO_INT PROC
    MOV SI, OFFSET BUFFER + 2
    XOR AX, AX
    MOV CX, 10
NEXT:
    MOV BL, [SI]
    CMP BL, 0DH
    JE DONE
    MUL CX
    SUB BL, '0'
    ADD AX, BX
    INC SI
    JMP NEXT
DONE:
    RET
STR_TO_INT ENDP

END MAIN
