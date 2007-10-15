; SINE220.ORC
; ORCHESTRA FILE FOR GENERATING 220 HZ SINE TONE
sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

        instr   1303
a1      oscil   20000, 220, 1, 0
        out     a1
        endin
