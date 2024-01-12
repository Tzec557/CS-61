; 	
; Author: Tristan Zhao
; UCR NetID/CS username: ezhao012
; Lab Section: 024
; TA: 
; Lab 1
; Date created: 10/04/2023
; 

.ORIG x3000
    
    LEA R0, MSG_TO_PRINT
    PUTS

    HALT

    MSG_TO_PRINT .STRINGZ "Hello world!"
    
.END