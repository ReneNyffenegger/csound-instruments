		instr   122
idur	=		p3
iamp	=		ampdb(p4)
ifrq	=		cpspch(p5)
ifun	=		p6
iatk	=		p7
irel	=		p8
iatkfun	=		p9				
index1	=		p10
index2	=		p11
kenv	envlpx	iamp, iatk, idur, irel, iatkfun, .7, .01
kmodswp	expon	index1, idur, index2
kbuzswp expon   20, idur, 1
asig3   foscil 	kenv, ifrq, 1, 1, kmodswp, ifun
asig2   buzz   	kenv, ifrq*.99, kbuzswp+1, ifun
asig1 	pluck 	iamp, ifrq*.5, ifrq, 0, 1
amix	=		asig1+asig2+asig3	
		out     amix
		dispfft	amix, .25, 1024
		endin
