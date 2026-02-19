; push and pop operations on a stack.      

.MODEL SMALL
.STACK 100H

.DATA
.CODE
START:
    MOV AX, @DATA
    MOV DS, AX         ; INITIALIZE DATA SEGMENT
    
    ; PUSH VALUES ONTO THE STACK
    MOV AX, 1234H
    PUSH AX            ; PUSH 1234H ONTO STACK
    
    MOV AX, 5678H
    PUSH AX            ; PUSH 5678H ONTO STACK
    
    MOV AX, 9ABCH
    PUSH AX            ; PUSH 9ABCH ONTO STACK
    
    ; POP VALUES FROM THE STACK
    POP BX             ; POP INTO BX (SHOULD BE 9ABCH)
    POP CX             ; POP INTO CX (SHOULD BE 5678H)
    POP DX             ; POP INTO DX (SHOULD BE 1234H)
    
    ; DOS EXIT
    MOV AH, 4CH        ; Fixed: AH not AX
    INT 21H

END START



