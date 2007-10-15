gacmb	init	0
garvb	init	0
		instr 	137
idur	=		p3
iamp	=		ampdb(p4)
ifrq	=		cpspch(p5)
ifun	=		p6
iatk	=		p7
irel	=		p8
irvbsnd	=		p9
icmbsnd	=		p10
kenv	linen	iamp, iatk, idur, irel
asig	loscil	kenv, ifrq, ifun
		out		asig
garvb	=		garvb+(asig*irvbsnd)
gacmb	=		gacmb+(asig*icmbsnd)
		endin

		instr	198
idur	=		p3
itime 	= 		p4
iloop 	= 		p5
kenv	linen	1, .01, idur, .01
acomb 	comb	gacmb, itime, iloop, 0
		out		acomb*kenv
gacmb	=		0
endin

		instr 	199
idur	=		p3					
irvbtim	=		p4
ihiatn	=		p5
arvb	reverb2	garvb, irvbtim, ihiatn
		out		arvb
garvb	=		0
		endin
