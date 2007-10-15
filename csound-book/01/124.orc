		instr	124
idur	=		p3
iamp	=		ampdb(p4)
ifrq	=		cpspch(p5)
ifun	=		p6
iatk	=		p7
irel	=		p8
iatkfun	=		p9
imodp1	=		p10
imodp2	=		p11
imodfr1	=		p12
imodfr2	=		p13
imodfun	=		p14				
kenv	envlpx	iamp, iatk, idur, irel, iatkfun, .7, .01
kmodpth	expon	imodp1, idur, imodp2
kmodfrq	line	cpspch(imodfr1), idur, cpspch(imodfr2) 		
alfo	oscil	kmodpth, kmodfrq, imodfun	
asig   	oscil	alfo, ifrq, ifun
       	out  	asig*kenv
		endin
