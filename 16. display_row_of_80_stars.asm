; display a row of 80 stars.

.MODEL SMALL
.STACK 100H

.CODE
MAIN PROC
    MOV CX, 80          ; number of stars to print
    MOV AH, 2           ; DOS function: display character
    MOV DL, '*'         ; character to display
    
PRINT_LOOP:
    INT 21H             ; print character in DL
    LOOP PRINT_LOOP     ; decrement CX, repeat if not zero
    
    ; terminate program
    MOV AH, 4CH
    INT 21H
    
MAIN ENDP
END MAIN


