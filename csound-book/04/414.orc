sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

        instr   414 
a1      oscil   8000, p5, 1
a2      =       a1/2
a3      =       a2 + 4000
a4      =       sqrt(a3)
a5      reverb  a4, 1
        out     a5
        endin
