;=================================================
; Name: Tristan Zhao
; Email: ezhao012@ucr.edu
; 
; Lab: lab 3, ex 2
; Lab section: 024
; TA: 
; 
;=================================================
.ORIG x3000

LEA R0, intro
PUTS

LD R0, newline
OUT

LEA R2, array_10        ;load the address of the array
LD R1, DEC_10


DO_WHILE_LOOP
    GETC
    OUT
    STR R0, R2, #0      ;store user input R0 into memory address R2. (R0 -> Mem[R2+0])
    ADD R2, R2, #1      ;move to next memory location in the array
    LD R0, newline
    OUT
    ADD R1, R1, #-1     ;decrease one at the time till it is nonpositive
    BRp DO_WHILE_LOOP


HALT
intro .STRINGz "Enter 10 characters you want to stroe in the array"
newline .STRINGz "\n"
array_10 .BLKW #10      ;BLWK means set aside n memory locations for later use. In here is 10 memory locations
DEC_10 .FILL #10

.END