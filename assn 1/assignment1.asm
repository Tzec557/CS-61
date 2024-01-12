;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Tristan Zhao
; Email: ezhao012@ucr.edu
; 
; Assignment name: Assignment 1
; Lab section: 024
; TA: 
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

;--------------------------------------------------
;REG VALUES         R0  R1  R2  R3  R4  R5  R6  R7
;--------------------------------------------------
;Pre-loop            0   6   12  0   0   0   0   0
;literation 01       0   5   12  12  0   0   0   0
;literation 02       0   4   12  24  0   0   0   0
;literation 03       0   3   12  36  0   0   0   0
;literation 04       0   2   12  48  0   0   0   0
;literation 05       0   1   12  60  0   0   0   0
;End of the program  0 32767 12  72  0   0 12286 0
;---------------------------------------------
;
;
;
;
;
;
;


.ORIG x3000			; Program begins here
;-------------
;Instructions: CODE GOES HERE
;-------------
LD R1, DEC_6
LD R2, DEC_12
And R3, R3, #0
    
DO_WHILE    ADD R3, R3, R2
            ADD R1, R1, #-1
            BRp DO_WHILE
    
HALT
    
;---------------	
;Data (.FILL, .STRINGZ, .BLKW)
;---------------

DEC_6 .FILL  #6
DEC_12 .FILL #12


;---------------	
;END of PROGRAM
;---------------	
.END


