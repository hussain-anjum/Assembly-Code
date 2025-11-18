.MODEL SMALL
.STACK 100H
.DATA
    MSG DB "Enter the number of input: $"
    N   DB 0
    X   DB ?
.CODE

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AH, 9
    LEA DX, MSG
    INT 21H

    MOV AH, 1
    INT 21H
    SUB AL, 30H
    MOV N, AL

    MOV AH, 2
    MOV DL, 0DH
    INT 21H
    MOV DL, 0AH
    INT 21H

    XOR CX, CX
    MOV CL, N

READ_LOOP:
    MOV AH, 1
    INT 21H
    MOV X, AL

    MOV AH, 2
    MOV DL, 0DH
    INT 21H
    MOV DL, 0AH
    INT 21H

    MOV AH, 2
    MOV DL, X
    INT 21H

    MOV AH, 2
    MOV DL, 0DH
    INT 21H
    MOV DL, 0AH
    INT 21H

    LOOP READ_LOOP

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN