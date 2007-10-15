		instr	129
idur	=		p3
iamp	=		p4
ifrq	=		p5
iatk	=		p6
irel	=		p7
icut1	=		p8
icut2	=		p9
kenv	linen	iamp, iatk, idur, irel
kcut	expon	icut1, idur, icut2
anoise	rand	ifrq	
afilt	tone	anoise, kcut
       	out  	afilt*kenv
		dispfft	afilt, idur, 4096
		endin
		
		instr	130
idur	=		p3
iamp	=		p4
ifrq	=		p5
iatk	=		p6
irel	=		p7
icut1	=		p8
icut2	=		p9
kenv	linen	iamp, iatk, idur, irel
kcut	expon	icut1, idur, icut2
anoise	rand	ifrq	
afilt2	tone	anoise, kcut
afilt1	tone	afilt2, kcut
       	out  	afilt1*kenv
		dispfft	afilt1, idur, 4096
		endin
		
		instr	131
idur	=		p3
iamp	=		p4
ifrq	=		p5
iatk	=		p6
irel	=		p7
icut1	=		p8
icut2	=		p9
kenv	linen	iamp, iatk, idur, irel
kcut	expon	icut1, idur, icut2
anoise	rand	ifrq	
afilt3	tone	anoise, kcut
afilt2	tone	afilt3, kcut
afilt1	tone	afilt2, kcut
       	out  	afilt1*kenv
		dispfft	afilt1, idur, 4096
		endin
		
		instr	132
idur	=		p3
iamp	=		p4
ifrq	=		p5
iatk	=		p6
irel	=		p7
icut1	=		p8
icut2	=		p9
kenv	linen	iamp, iatk, idur, irel
kcut	expon	icut1, idur, icut2
anoise	rand	ifrq	
afilt4	tone	anoise, kcut
afilt3	tone	afilt4, kcut
afilt2	tone	afilt3, kcut
afilt1	tone	afilt2, kcut
       	out  	afilt1*kenv
		dispfft	afilt1, idur, 4096
		endin
