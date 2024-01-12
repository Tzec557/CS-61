;=================================================
; Name: Tristan Zhao
; Email: ezhao012
; 
; Lab: lab 8, ex 1
; Lab section: 024
; TA: 
; 
;=================================================

.orig x3000

LD R6, top_stack_addr

; Test harness
;-------------------------------------------------
LD R1 LOAD_FILL_VALUE_3200
JSRR R1

ADD R2 R2 #1

LD R1 OUTPUT_AS_DECIMAL_3400
;add 1 to the number and invoke subroutine 2 
JSRR R1
HALT

; Test harness local data
;-------------------------------------------------
top_stack_addr .fill xFE00
LOAD_FILL_VALUE_3200 .FILL x3200
OUTPUT_AS_DECIMAL_3400 .FILL x3400
.end

;=================================================
; Subroutine: LOAD_FILL_VALUE_3200
; Parameter: // Fixme
; Postcondition: Fill R1 with a hard-coded value in the subroutine data
; Return Value: R2 
;=================================================

.orig x3200

; Backup registers
ADD R6 R6 #-1  
STR R7 R6 #0

ADD R6 R6 #-1
STR R1 R6 #0

; Code
LD R2 Value

LDR R1 R6 #0    
ADD R6 R6 #1

LDR R7 R6 #0
ADD R6 R6 #1

RET
introPromptPtr .STRINGZ "Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
Value .FILL #32766
.end

;=================================================
; Subroutine: OUTPUT_AS_DECIMAL_3400
; Parameter: R2
; Postcondition: we put R2 as our input then print it as decimal
; Return Value: no return value
;=================================================

.orig x3400

; Backup registers
ADD R6 R6 #-1  
STR R7 R6 #0

ADD R6 R6 #-1
STR R1 R6 #0

ADD R6 R6 #-1
STR R2 R6 #0

; Code
ADD R0 R2 #0
BRN PRINT_NEG_SIGN
BR START

;if it is negative, print the sign, and change it to positive num
PRINT_NEG_SIGN
LD R0 NEG_SIGN
out

NOT R2 R2
ADD R2 R2 #1

START
;10000S
LD R3 DEC_10000
AND R4 R4 #0 ;COUNTER

NUM_IN_10000
    ADD R2 R2 R3
    BRN END_NUM_IN_10000
    ADD R4 R4 #1
    BR NUM_IN_10000
END_NUM_IN_10000

NOT R3 R3
ADD R3 R3 #1
;add it back to get the reminder
ADD R2 R2 R3

ADD R2 R2 #0
BRZ SKIP_TO_1000

LD R3 DEC_48
ADD R0 R4 #0
ADD R0 R0 R3
OUT

;1000S
SKIP_TO_1000
LD R3 DEC_1000
AND R4 R4 #0 ;COUNTER
NUM_IN_1000
    ADD R2 R2 R3
    BRN END_NUM_IN_1000
    ADD R4 R4 #1
    BR NUM_IN_1000
END_NUM_IN_1000

NOT R3 R3
ADD R3 R3 #1
ADD R2 R2 R3

ADD R2 R2 #0
BRZ SKIP_TO_100

LD R3 DEC_48
ADD R0 R4 #0
ADD R0 R0 R3
OUT

;100S
SKIP_TO_100
LD R3 DEC_100
AND R4 R4 #0 ;COUNTER
NUM_IN_100
    ADD R2 R2 R3
    BRN END_NUM_IN_100
    ADD R4 R4 #1
    BR NUM_IN_100
END_NUM_IN_100

NOT R3 R3
ADD R3 R3 #1
ADD R2 R2 R3

ADD R2 R2 #0
BRZ SKIP_TO_10

LD R3 DEC_48
ADD R0 R4 #0
ADD R0 R0 R3
OUT

;10S
SKIP_TO_10
LD R3 DEC_10
AND R4 R4 #0 ;COUNTER
NUM_IN_10
    ADD R2 R2 R3
    BRN END_NUM_IN_10
    ADD R4 R4 #1
    BR NUM_IN_10
END_NUM_IN_10

NOT R3 R3
ADD R3 R3 #1
ADD R2 R2 R3

ADD R2 R2 #0
BRZ SKIP_TO_1

LD R3 DEC_48
ADD R0 R4 #0
ADD R0 R0 R3
OUT

;1S
SKIP_TO_1
LD R3 DEC_1
AND R4 R4 #0 ;COUNTER
NUM_IN_1
    ADD R2 R2 R3
    BRN END_NUM_IN_1
    ADD R4 R4 #1
    BR NUM_IN_1
END_NUM_IN_1

NOT R3 R3
ADD R3 R3 #1
ADD R2 R2 R3

LD R3 DEC_48
ADD R0 R4 #0
ADD R0 R0 R3
OUT

; Restore registers
LDR R2 R6 #0    
ADD R6 R6 #1

LDR R1 R6 #0    
ADD R6 R6 #1

LDR R7 R6 #0
ADD R6 R6 #1

RET


DEC_10000 .FILL #-10000
DEC_1000 .FILL #-1000
DEC_100 .FILL #-100
DEC_10 .FILL #-10
DEC_1 .FILL #-1
DEC_48 .FILL #48
NEG_SIGN .STRINGZ "-"
.end