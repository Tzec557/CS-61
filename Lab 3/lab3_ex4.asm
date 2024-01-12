;=================================================
; Name: Tristan Zhao
; Email: ezhao012@ucr.edu
; 
; Lab: lab 3, ex 4
; Lab section: 024
; TA: 
; 
;=================================================

.ORIG x3000

LEA R0, intro           ;prompt the user enter characters
PUTS

LD R0, newline
OUT

LD R1, array_100       ;load the address of the array into R1

DO_WHILE_LOOP
    GETC
    OUT
    STR R0, R1, #0      ;store user input R0 into memory address R1. (R0 -> Mem[R1+0])
    ADD R1, R1, #1      ;move to next memory location in the array
    ADD R2, R0, #-10    ;since enter key ascii value is #10, if user input is enter key 
                        ;when I add #-10 to it, it should add up to zero 
                        ;if it is zero jump out of the loop
    BRnp DO_WHILE_LOOP
    
LD R1, array_100       ;load the address of the array into R1

LD R0, newline
OUT

ANOTHER_LOOP
    LDR R0, R1, #0      ;load character from the array (Mem[R1+0] -> R0)
    OUT
    ADD R1, R1, #1      ;move to next memory location in the array
    ADD R2, R0, #-10    ;since I store the sentinel(enter key) at the end of the array, so it should add up to zero
    BRz END             ;if it is zero jump out of the loop
    BR ANOTHER_LOOP
    
LD R0, newline
OUT

END HALT

intro .STRINGz "Enter characters, finish with enter key"
newline .STRINGz "\n"
array_100 .FILL x4000


.END

.ORIG x4000
array .BLKW #100
.END