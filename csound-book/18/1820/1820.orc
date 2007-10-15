sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

        instr   1820
igm     =       1.618
klin    line    3, p3, 0
afm1    foscil  1, p5, 1, p5*igm, klin, 1
asig    linen   afm1, 0.01, p3, 0.04
        out     asig*p4
        endin
