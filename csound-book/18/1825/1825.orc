sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

gafb    init    0       ; INITIAL VALUE

        instr   1825    
kline   line    0, p3, 1    
aosc    oscil   1, p5*(1+kline*gafb), 1 
asig    linen   aosc, 0.07, p3, 0.075   
        out     asig*p4 
gafb    =       asig    
        endin
