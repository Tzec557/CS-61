;=================================================
; Name: Tristan Zhao
; Email: ezhao012
; 
; Lab: lab 4, ex 4
; Lab section: 024
; TA: 
; 
;=================================================

.ORIG x3000
LD R1 SUB_FILL_ARRAY_3200
AND R2 R2 #0
LD R3 DEC_10
LD R4 ARRAY_PTR

JSRR R1 

LD R1 SUB_CONVERT_ARRAY_3400
ADD R3 R3 #10
LD R4 ARRAY_PTR
LD R6 OFFSET
    
JSRR R1

LD R1 SUB_PRINT_ARRAY_3600
ADD R3 R3 #10
LD R4 ARRAY_PTR

JSRR R1

;LD R0 newline
;OUT
LD R1 SUB_PRETTY_PRINT_ARRAY_3800
AND R2 R2 #0
LD R2 SUB_PRINT_ARRAY_3600
JSRR R1


HALT

SUB_FILL_ARRAY_3200 .FILL x3200
SUB_CONVERT_ARRAY_3400 .FILL x3400
SUB_PRINT_ARRAY_3600 .FILL x3600
SUB_PRETTY_PRINT_ARRAY_3800 .FILL x3800
DEC_10 .FILL #10
ARRAY_PTR .FILL ARRAY
OFFSET .FILL x30
newline .FILL x0A
.END

.ORIG x3200
LOOP
    STR R2 R4 #0
    ADD R4 R4 #1
    ADD R2 R2 #1
    ADD R3 R3 #-1
    BRp LOOP
RET
.END

.ORIG x3400

CONVERT_LOOP
    AND R0 R0 #0 ; resets R0 with 0
    LDR R0 R4 #0 ; load R0 with R4's value
    ADD R0 R0 R6 ; convert to ascii
    STR R0, R4, #0 ; Store back the ascii to its position in the array
    ADD R4 R4 #1 ; move by one 
    ADD R3 R3 #-1; subtract one till zero
    BRp CONVERT_LOOP
RET
.END

.ORIG x3600
PRINT_LOOP
    AND R0 R0 #0 ; resets R0 with 0
    LDR R0 R4 #0 ; load R0 with R4's value
    OUT
    ADD R4 R4 #1 ; move by one 
    ADD R3 R3 #-1; subtract one till zero
    BRp PRINT_LOOP
RET
.END

.ORIG x3800
LEA R0 EQUAL
PUTS
JSRR R2
LEA R0 EQUAL
PUTS
RET
EQUAL .STRINGZ "======"
.END

.ORIG x4000
ARRAY .BLKW #10
.END