;=================================================
; Name: Tristan Zhao
; Email: ezhao012
; 
; Lab: lab 2. ex 1
; Lab section: 024
; TA: 
; 
;=================================================

.ORIG x3000

LD R3, DEC_65
LD R4, HEX_41

HALT
DEC_65 .FILL #65
HEX_41 .FILL x41
.END