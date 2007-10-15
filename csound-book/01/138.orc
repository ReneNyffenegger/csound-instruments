sr 		= 		44100
kr 		= 		4410
ksmps 	= 		10
nchnls 	= 		2

garvb	init	0

		instr   138 ;sweeping fm with vibrato & discrete pan
idur	=		p3
iamp	=		ampdb(p4)
ifrq	=		cpspch(p5)
ifc		=		p6
ifm		=		p7
iatk	=		p8
irel	=		p9
indx1	=		p10
indx2	=		p11
indxtim	=		p12	
ilfodep	=		p13
ilfofrq	=		p14		
ipan	=		p15		
irvbsnd	=		p16		
kampenv	expseg	.01, iatk, iamp, idur/9, iamp*.6, idur-(iatk+irel+idur/9), iamp*.7, irel,.01
klfo	oscil	ilfodep, ilfofrq, 1
kindex  expon  	indx1, indxtim, indx2
asig   	foscil 	kampenv, ifrq+klfo, ifc, ifm, kindex, 1
		outs     asig*ipan, asig*(1-ipan)
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

