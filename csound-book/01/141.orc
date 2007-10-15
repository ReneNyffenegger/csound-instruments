sr 		= 		44100
kr 		= 		4410
ksmps 	= 		10
nchnls 	= 		2

garvb	init	0

		instr	141   ; lfo pan - am pulser
idur	=		p3
iamp	=		ampdb(p4)
ifrq	=		cpspch(p5)
ifun	=		p6
iatk	=		p7
irel	=		p8
iatkfun	=		p9
imodpth	=		p10
imodfrq	=		p11
imodfun	=		p12
ipanfrq	=		p13	
irvbsnd	=		p14			
kenv	envlpx	iamp, iatk, idur, irel, iatkfun, .7, .01
kpan	oscil	.5, ipanfrq, 1
klfo	oscil	imodpth, imodfrq, imodfun	
asig    oscil	klfo*kenv, ifrq, ifun
kpanlfo	=		kpan+.5
       	outs  	asig*kpanlfo, asig*(1-kpanlfo)
garvb	=		garvb+(asig*irvbsnd)
		endin
				
		instr 	199
idur	=		p3					
irvbtim	=		p4
ihiatn	=		p5
arvb	nreverb	garvb, irvbtim, ihiatn
		outs		arvb, arvb
garvb	=		0
		endin

