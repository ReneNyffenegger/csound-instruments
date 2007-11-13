sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

        instr   507
i1      =       cpsoct(p5)
k1      expseg  .0001,.05,p4,p3-.05,.0001
k2      linseg  1.69,.1,1.75,p3-.1,1.69
a1      foscil  k1,i1,1,2.01,k2,1
        out     a1
        endin
