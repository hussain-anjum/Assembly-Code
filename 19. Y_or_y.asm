;  read a character. Y or y

.MODEL SMALL
.STACK 100H

.DATA
.CODE
MAIN PROC
    ; Read a character from keyboard
    MOV AH, 07H
    INT 21H                ; Read character (AL = char)
    
    ; Check if character is 'y'
    CMP AL, 'y'
    JE DISPLAY             ; If yes, jump to display
    
    ; Check if character is 'Y'
    CMP AL, 'Y'
    JE DISPLAY             ; If yes, jump to display
    
    ; Otherwise exit
    JMP EXIT
    
DISPLAY:
    MOV AH, 2              ; DOS function 2: Display character
    MOV DL, AL             ; Put char into DL for display
    INT 21H
    
EXIT:
    MOV AH, 4CH            ; DOS function 4Ch: Exit program
    INT 21H
    
MAIN ENDP
END MAIN



