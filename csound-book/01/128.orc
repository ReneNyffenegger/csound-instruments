		instr	128
idur	=		p3
iamp	=		p4
ifrq	=		p5
iatk	=		p6
irel	=		p7
icf1	=		p8
icf2	=		p9
ibw1	=		p10
ibw2	=		p11
kenv	expseg	.001, iatk, iamp, idur/6, iamp*.4, idur-(iatk+irel+idur/6), iamp*.6, irel,.01
anoise	rand	ifrq
kcf		expon	icf1, idur, icf2
kbw		line	ibw1, idur, ibw2
afilt	reson	anoise, kcf, kbw, 2
       	out  	afilt*kenv
       	display	kenv, idur
		endin
