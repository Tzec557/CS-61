;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Tristan Zhao
; Email: ezhao012@ucr.edu
; 
; Assignment name: Assignment 3
; Lab section: 024
; TA:
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
LD R6, Value_ptr		; R6 <-- pointer to value to be displayed as binary
LDR R1, R6, #0			; R1 <-- value to be displayed as binary 
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
LD R2 PRINT_0   
LD R3 PRINT_1
LD R4 COUNTER_19
LD R5 COUNTER_4

ADD R0 R1 #0
BRzp POSITIVE
BRn NEGATIVE


POSITIVE
ADD R0 R2 #0
OUT
BR SHIFTING

NEGATIVE
ADD R0 R3 #0
OUT
BR SHIFTING

SPACE
LD R0 SPACE_
OUT
AND R5 R5 #0
ADD R5 R5 #5

SHIFTING
ADD R4 R4 #-1
BRZ STOP

ADD R5 R5 #-1
BRZ SPACE

ADD R1 R1 R1
BRzp POSITIVE
BRn NEGATIVE



STOP
LD R0 NEWLINE
OUT

HALT
;---------------	
;Data
;---------------
Value_ptr	.FILL xCA01	; The address where value to be displayed is stored
COUNTER_19  .FILL #19
COUNTER_4   .FILL #4
PRINT_0     .FILL x30
PRINT_1     .FILL x31
NEWLINE     .FILL X0A
SPACE_      .STRINGZ " "

.END

.ORIG xCA01					; Remote data
Value .FILL xABCD			; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.
;---------------	
;END of PROGRAM
;---------------	
.END
