;  multiplication and division of two numbers up to 2 or 3 digits.
                                                                       
.MODEL SMALL
.STACK 100H

.DATA
    A           DW ?
    B           DW ?
    ANS         DW ?
    
    INPUT_BUFFER DB 4
                 DB ?
                 DB 4 DUP(?)
    
    MSG_A       DB 'ENTER FIRST NUMBER (MAX 3 DIGITS): $'
    MSG_B       DB 'ENTER SECOND NUMBER (MAX 3 DIGITS): $'
    MSG_MUL     DB 0DH,0AH,'MULTIPLICATION: $'
    MSG_DIV     DB 0DH,0AH,'DIVISION: $'
    MSG_ERR     DB 0DH,0AH,'ERROR: DIVISION BY ZERO!$'
    NEWLINE     DB 0DH,0AH,'$'
    OUTPUT      DB 6 DUP('$')

.CODE

; print string
PRINT_STRING PROC
    MOV AH, 09H
    INT 21H
    RET
PRINT_STRING ENDP

; read user input line
TAKE_INPUT PROC
    LEA DX, INPUT_BUFFER
    MOV AH, 0AH
    INT 21H
    RET
TAKE_INPUT ENDP

; convert ASCII string to integer
STR_TO_INT PROC
    MOV SI, OFFSET INPUT_BUFFER + 2
    ; SKIP LENGTH BYTES TO INPUT CHARS
    XOR AX, AX             ; CLEAR AX FOR RESULT
    MOV CX, 10             ; DECIMAL BASE
    
NEXT_DIGIT:
    MOV BL, [SI]
    CMP BL, 0DH            ; CHECK FOR ENTER KEY (CR)
    JE DONE
    MUL CX                 ; MULTIPLY AX BY 10
    SUB BL, '0'            ; CONVERT ASCII DIGIT TO NUMERIC VALUE
    ADD AX, BX             ; ADD DIGIT TO AX
    INC SI
    JMP NEXT_DIGIT
    
DONE:
    RET
STR_TO_INT ENDP

; convert integer to ASCII string
INT_TO_STR PROC
    LEA SI, OUTPUT
    MOV BX, 10
    XOR CX, CX
    XOR DX, DX
    
    CMP AX, 0
    JNE DIV_LOOP
    
    MOV BYTE PTR [SI], '0' ; HANDLE ZERO CASE
    INC SI
    JMP FINISH
    
DIV_LOOP:
    DIV BX                  ; DIVIDE AX BY 10
    ADD DL, '0'             ; CONVERT REMAINDER TO ASCII
    PUSH DX
    INC CX
    XOR DX, DX
    CMP AX, 0
    JNE DIV_LOOP
    
WRITE_BACK:
    POP DX                  ; POP DIGITS IN REVERSE ORDER
    MOV [SI], DL
    INC SI
    LOOP WRITE_BACK
    
FINISH:
    MOV BYTE PTR [SI], '$'  ; TERMINATE STRING FOR DOS PRINT
    RET
INT_TO_STR ENDP

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    ; prompt and read first number
    LEA DX, MSG_A
    CALL PRINT_STRING
    CALL TAKE_INPUT
    CALL STR_TO_INT
    MOV A, AX
    
    ; print newline before next prompt
    LEA DX, NEWLINE
    CALL PRINT_STRING
    
    ; prompt and read second number
    LEA DX, MSG_B
    CALL PRINT_STRING
    CALL TAKE_INPUT
    CALL STR_TO_INT
    MOV B, AX
    
    ; multiply A * B and display result
    MOV AX, A
    MOV BX, B
    MUL BX
    MOV ANS, AX
    LEA DX, MSG_MUL
    CALL PRINT_STRING
    MOV AX, ANS
    CALL INT_TO_STR
    LEA DX, OUTPUT
    CALL PRINT_STRING
    
    ; divide A BY B, check for division by zero
    MOV AX, A
    MOV BX, B
    CMP BX, 0
    JE DIV_ZERO
    
    XOR DX, DX              ; CLEAR DX BEFORE DIVISION
    DIV BX
    MOV ANS, AX
    LEA DX, MSG_DIV
    CALL PRINT_STRING
    MOV AX, ANS
    CALL INT_TO_STR
    LEA DX, OUTPUT
    CALL PRINT_STRING
    JMP END_PROG
    
DIV_ZERO:
    ; handle division by zero error
    LEA DX, MSG_ERR
    CALL PRINT_STRING
    
END_PROG:
    ; DOS EXIT
    MOV AH, 4CH
    INT 21H
    
MAIN ENDP
END MAIN



