sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

gkpwr	init	0

		instr	1821
igm		=		1.618
imp		=		p4
kln		line	3, p3, 0
afm1	foscil	imp, p5, 1, p5*igm, kln, 1
asig	linen	afm1, 0.01*p3, p3, 0.6*p3
		out		asig
gkpwr	rms		asig
		endin	
								
		instr	1822	; PULSED NOISE INSTRUMENT
klfo	oscil	0.5, 8, 1	
klfo1	=		klfo+0.5			; RESCALE [0-1]
anoiz	rand	1	
apulse	=		anoiz*klfo1	
kpw		=		p4-gkpwr			; POWER CURVE
kmp		port	kpw, 0.2			; SMOOTH CURVE
asig	=		apulse*kmp		
		out		asig	
		endin
