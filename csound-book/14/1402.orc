sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

        instr   1402
a2      linseg  0, p3*.3, 20000, p3*.4, 15000, p3*.3, 0
a1      fof     a2, 200, 650, 0, 40, .003, .02, .007, 5, 1, 2, p3
        out     a1
        endin
