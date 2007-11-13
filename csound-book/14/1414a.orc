sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

        instr   1414
a3      linseg  0, p3*.01, 1, p3*.9, 1, p3*.09, 0
i1      =       sr/ftlen(1) ;speed factor (relative to sr and table length)
a2      phasor  i1*p5   ;phase input for speed
a1      fog     15000, 100, p4, a2, 0, 0, .01, .02, .01, 2, 1, 2, p3, 0, 1
        out     a1*a3
        endin
