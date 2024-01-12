;=================================================
; Name: Tristan Zhao
; Email: ezhao012
; 
; Lab: lab 8, ex 2
; Lab section: 024
; TA: 
; 
;=================================================

.orig x3000

LD R6, top_stack_addr

; Test harness
;-------------------------------------------------
LEA R0 PROMPT
PUTS

GETC
OUT

ADD R2 R0 #0
LD R1 PARITY_CHECK_3600
JSRR R1

LD R0 NEWLINE
OUT

LEA R0 OUTPUT1
PUTS

ADD R0 R2 #0
OUT

LEA R0 OUTPUT2
PUTS

LD R4 DEC_48
ADD R0 R3 R4
OUT

HALT

; Test harness local data
;-------------------------------------------------
top_stack_addr .fill xFE00
PROMPT .STRINGZ "ENTER A SINGLE CHARACTER: "
PARITY_CHECK_3600 .FILL x3600
OUTPUT1 .STRINGZ "The number of 1’s in '"
OUTPUT2 .STRINGZ "' is: "
DEC_48 .FILL #48
NEWLINE .FILL x0A
.END

;=================================================
; Subroutine: PARITY_CHECK_3600
; Parameter: R2(USRER INPUT CHARACTER)
; Postcondition: count the number of  binary 1’s in the input character(in R2)
; Return Value (R3): Number of 1s.
;=================================================

.orig x3600

; Backup registers
ADD R6 R6 #-1  
STR R7 R6 #0

ADD R6 R6 #-1  
STR R1 R6 #0

ADD R6 R6 #-1  
STR R2 R6 #0
; Code
LD R4 CHECK
AND R3 R3 #0
LD R1 MASK ;0000 0001

LOOP
    AND R5 R2 R1
    BRnz NOT1
    ADD R3 R3 #1
    NOT1
    ADD R1 R1 R1 ;0000 0010, 0000 0100 etc...
    ADD R4 R4 #-1
    BRp LOOP

; Restore registers
LDR R2 R6 #0
ADD R6 R6 #1

LDR R1 R6 #0
ADD R6 R6 #1

LDR R7 R6 #0
ADD R6 R6 #1
RET
CHECK .FILL #8
MASK .FILL #1
.end