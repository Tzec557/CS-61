;=================================================
; Name: Tristan Zhao
; Email: ezhao012
; 
; Lab: lab 4, ex 1
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

HALT

SUB_FILL_ARRAY_3200 .FILL x3200
DEC_10 .FILL #10
ARRAY_PTR .FILL ARRAY
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

.ORIG x4000
ARRAY .BLKW #10
.END