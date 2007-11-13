sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

        instr   415 
a1      oscil   8000, p5, 1
a1      =       a1/2
a1      =       a1 + 4000
a1      =       sqrt(a1)
a1      reverb  a1, 1
        out     a1
        endin
