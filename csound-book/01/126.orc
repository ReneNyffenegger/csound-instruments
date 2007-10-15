		instr	126
idur	=		p3
iamp	=		ampdb(p4)
ifrq	=		cpspch(p5)
iatk	=		p6
irel	=		p7
ivibdel	=		p8
imoddpt	=		p9
imodfrq	=		p10
iharm	=		p11
kenv	linen	iamp, iatk, idur, irel
kvibenv	linseg	0, ivibdel, 1, idur-ivibdel, .3
klfo	oscil	kvibenv*imoddpt, imodfrq, 1	
asig   	buzz   	kenv, ifrq+klfo, iharm, 1
       	out  	asig
		endin
