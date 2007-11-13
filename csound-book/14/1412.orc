sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

        instr   1412
k1      expon   .3, p3, .003
a1      fof     15000, 2, 300, 0, 0, .003, .01+k1, k1, 2, 1, 2, p3
        out     a1
        endin
