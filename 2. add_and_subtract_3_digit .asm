; add and subtract two number up to 3 digits.      

.MODEL SMALL
.STACK 100H

.DATA
    A           DW ?
    B           DW ?
    ANS         DW ?
    
    INPUT_BUFFER DB 4
                 DB ?
                 DB 4 DUP(?)
    
    MSG_A       DB 'FIRST NUMBER (MAX 3 DIGITS): $'
    MSG_B       DB 13,10,'SECOND NUMBER (MAX 3 DIGITS): $'
    MSG_ADD     DB 13,10,'ADDITION: $'
    MSG_SUB     DB 13,10,'SUBTRACTION: $'
    NEWLINE     DB 13,10,'$'
    OUTPUT      DB 6 DUP('$')

.CODE

PRINT_STRING PROC
    MOV AH, 09H
    INT 21H
    RET
PRINT_STRING ENDP

TAKE_INPUT PROC
    LEA DX, INPUT_BUFFER
    MOV AH, 0AH
    INT 21H
    RET
TAKE_INPUT ENDP

STR_TO_INT PROC
    MOV SI, OFFSET INPUT_BUFFER + 2
    XOR AX, AX
    MOV CX, 10
    ; clear AX to accumulate number; base 10 for multiplication
    
NEXT_DIGIT:
    MOV BL, [SI]    ; load next input char
    CMP BL, 0DH
    JE DONE
    MUL CX          ; AX = AX * 10
    SUB BL, '0'     ; convert ASCII digit to number
    ADD AX, BX      ; add digit to AX
    INC SI
    JMP NEXT_DIGIT
    
DONE:
    RET
STR_TO_INT ENDP

INT_TO_STR PROC
    LEA SI, OUTPUT              ; point SI to output buffer
    MOV BX, 10                  ; divisor for decimal base
    XOR CX, CX                  ; digit count
    XOR DX, DX                  ; clear DX for DIV
    
    ; Check if number is negative
    MOV AX, ANS                 ; load ans into AX
    CMP AX, 0
    JGE no_negative
    
    ; add negative and negate the number
    MOV BYTE PTR [SI], '-'      ; put '-' in output
    INC SI                      ; move output pointer forward
    NEG AX
    MOV ANS, AX                 ; update ans with positive value
    
no_negative:
    MOV AX, ANS                 ; load positive ans to AX
    XOR CX, CX                  ; reset digit count
    MOV BX, 10
    XOR DX, DX
    
    CMP AX, 0
    JNE div_loop
    
    MOV BYTE PTR [SI], '0'      ; if zero, output '0'
    INC SI
    JMP finish
    
div_loop:
    XOR DX, DX
    DIV BX
    ADD DL, '0'
    PUSH DX
    INC CX
    CMP AX, 0
    JNE div_loop
    
write_back:
    POP DX
    MOV [SI], DL
    INC SI
    LOOP write_back
    
finish:
    MOV BYTE PTR [SI], '$'
    RET
INT_TO_STR ENDP

MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    LEA DX, MSG_A
    CALL PRINT_STRING          ; prompt for first number
    CALL TAKE_INPUT            ; get first number input
    CALL STR_TO_INT            ; convert input string to integer
    MOV A, AX                  ; store first number
    
    LEA DX, NEWLINE
    CALL PRINT_STRING          ; print newline
    
    LEA DX, MSG_B
    CALL PRINT_STRING          ; prompt for second number
    CALL TAKE_INPUT            ; get second number input
    CALL STR_TO_INT            ; convert input string to integer
    MOV B, AX                  ; store second number
    
    ; Addition
    MOV AX, A
    ADD AX, B                  ; compute A+B
    MOV ANS, AX
    LEA DX, MSG_ADD
    CALL PRINT_STRING          ; print "ADDITION:"
    MOV AX, ANS
    CALL INT_TO_STR            ; convert sum to string
    LEA DX, OUTPUT
    CALL PRINT_STRING          ; print sum
    
    ; Subtraction (A - B)
    MOV AX, A
    SUB AX, B
    MOV ANS, AX
    LEA DX, MSG_SUB
    CALL PRINT_STRING          ; print "SUBTRACTION:"
    MOV AX, ANS
    CALL INT_TO_STR            ; convert subtraction result to string
    LEA DX, OUTPUT
    CALL PRINT_STRING          ; print subtraction result
    
    ; DOS exit
    MOV AH, 4CH
    INT 21H
    
MAIN ENDP
END MAIN
