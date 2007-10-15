		instr	120
idur	=		p3
iamp	=		ampdb(p4)
ifrq	=		cpspch(p5)
ifun	=		p6
iatk	=		p7
irel	=		p8
iatkfun	=		p9				
kenv	envlpx	iamp, iatk, idur, irel, iatkfun, .7, .01
asig3   oscil	kenv, ifrq*.99, ifun
asig2   oscil	kenv, ifrq*1.01, ifun
asig1   oscil	kenv, ifrq, ifun
amix	=		asig1+asig2+asig3
       	out  	amix
       	display	kenv, p3
		endin
