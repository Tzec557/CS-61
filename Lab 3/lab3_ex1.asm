;=================================================
; Name: Tristan Zhao
; Email: ezhao012@ucr.edu
; 
; Lab: lab 3, ex 1
; Lab section: 024
; TA: 
; 
;=================================================
.ORIG x3000

LD R5, DATA_PTR

LDR R3, R5, #0          ;load what's in the R5(memory address) into R3
;LDR R4, R6, #0
LDR R4, R5, #1


ADD R3, R3, #1
ADD R4, R4, #1

STR R3, R5, #0          ;store R3 from R5 which is the memory address
STR R4, R5, #1

HALT
DATA_PTR .FILL x4000    ;pointer point to x4000 which store #65

.END

;; Remote data
.orig x4000
NEW_DEC_65	.FILL #65
NEW_HEX_41	.FILL x41
.END
