;=================================================
; Name: Tristan Zhao
; Email: ezhao012@ucr.edu
; 
; Lab: lab 6, ex 2
; Lab section: 024
; TA: 
; 
;=================================================
.ORIG x3000
LD R1 VALUE
LD R3 BASE
LD R4 MAX
LD R5 TOS

PUSH
    LD R6 SUB_STACK_PUSH_3200
    JSRR R6

    ADD R1 R1 #-1
    BRP PUSH

AND R1 R1 #0
ADD R1 R1 #6

POP
    LD R6 SUB_STACK_POP_3400
    JSRR R6
    
    ;IF R5 IS UNDERFLOW THEN STOP
    ; NOT R2 R3
    ; ADD R2 R2 #1
    ; ADD R2 R2 R5
    ; BRP PRINT
    ; BRN QUIT
    
    ; PRINT
    LD R2 DEC_48
    ADD R0 R2 R0
    OUT
    
    ; QUIT
    ADD R1 R1 #-1
    BRP POP
    
   
HALT
VALUE .FILL #6
BASE .FILL xA000
MAX .FILL xA005
TOS .FILL xA000
SUB_STACK_PUSH_3200 .FILL x3200
SUB_STACK_POP_3400 .FILL x3400
DEC_48 .FILL #48
.END

;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_PUSH
; Parameter (R1): The value to push onto the stack
; Parameter (R3): BASE: A pointer to the base (one less than the lowest available                      ;                       address) of the stack
; Parameter (R4): MAX: The "highest" available address in the stack
; Parameter (R5): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has pushed (R1) onto the stack (i.e to address TOS+1). 
;		    If the stack was already full (TOS = MAX), the subroutine has printed an
;		    overflow error message and terminated.
; Return Value: R5 ← updated TOS
;------------------------------------------------------------------------------------------

.ORIG x3200
ADD R6 R6 #-1 ;back up value
STR R7 R6 #0

ADD R6 R6 #-1 
STR R1 R6 #0

;turn the max value to negative
NOT R2 R4
ADD R2 R2 #1
;add the negative num with the current tos
;if they add up to zero then it is overflow
ADD R2 R2 R5
BRZ OVER

STR R1 R5 #0 ;store the value(r1) in r5
ADD R5 R5 #1 ;move to next
BR END
  
OVER
    LEA R0 OVERFLOW
    PUTS
END

LDR R1 R6 #0 ;restore
ADD R6 R6 #1

LDR R7 R6 #0 
ADD R6 R6 #1
    
RET
    
OVERFLOW .STRINGZ "OVERFLOW\n"
.END
;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_POP
; Parameter (R3): BASE: A pointer to the base (one less than the lowest available                      ;                       address) of the stack
; Parameter (R4): MAX: The "highest" available address in the stack
; Parameter (R5): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped MEM[TOS] off of the stack and copied it to R0.
;		    If the stack was already empty (TOS = BASE), the subroutine has printed
;                an underflow error message and terminated.
; Return Values: R0 ← value popped off the stack
;		   R5 ← updated TOS
;------------------------------------------------------------------------------------------
.ORIG x3400
ADD R6 R6 #-1 ;back up value
STR R7 R6 #0

ADD R6 R6 #-1 
STR R1 R6 #0

ADD R6 R6 #-1 
STR R2 R6 #0

;turn base to negative
NOT R2 R3
ADD R2 R2 #1
;add it with base, if it is 0 it is underflow
ADD R2 R2 R5
BRZ UNDER

ADD R5 R5 #-1
LDR R0 R5 #0
BR DONE

UNDER
    LEA R0 UNDERFLOW
    PUTS
DONE  

LDR R2 R6 #0 ;restore
ADD R6 R6 #1

LDR R1 R6 #0 
ADD R6 R6 #1

LDR R7 R6 #0 
ADD R6 R6 #1

RET
    
UNDERFLOW .STRINGZ "\nUNDERFLOW\n"
.END