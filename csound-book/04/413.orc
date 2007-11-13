sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

        instr   413     
k1      line    2, p3, 1            ; GENERATE THE INVERSE OF THE ENVELOPE
a1      oscil   32000, 440*k1, 1    ; APPLY IT WITH MULTIPLICATION ...
        out     a1                  ; ... INSTEAD OF DIVISION
        endin       
