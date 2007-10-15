sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

giseed	=		.5	
garev	init	0	
			
		instr 	801		
iamp	=		p4					; OVERALL AMPL. SCALING FACTOR
ifreq	=		p5					; PITCH IN HERTZ
ivibd	=		p6*ifreq/100.0		; VIB DEPTH RELATIVE TO FUND.
iatt	=		p7					; ATTACK TIME
idec	=		p8					; DECAY TIME
isus	=		p3-iatt-idec-.005	; SUSTAIN TIME
ifcut	tablei	p9, 2				; LP FILTER CUTOFF FREQUENCY 			
kvibd	linseg	.1, .8*p3, 1, .2*p3, .7	; VIBRATO
kvibd	=		kvibd*ivibd			; VIBRATO DEPTH
ivibr1	=		2.5+giseed 	
giseed	=		frac(giseed*105.947)	
ivibr2	=		4.5+giseed	
giseed	=		frac(giseed*105.947)	
kvrate	linseg	ivibr1, p3, ivibr2	; TIME-VARYING VIBRATO RATE
kvib	oscil	kvibd, kvrate, 1	
kfreq	=		ifreq+kvib	
amp1	linseg	0, .001, 0, .5*iatt, .5, .5*iatt, .9, .5*isus, 1, .5*isus, .9, .5*idec, .3, .5*idec, 0, 1, 0
amp2	=		amp1*amp1 			; WAVETABLE ENVELOPES
amp3	=		amp2*amp1	
amp4	=		amp3*amp1	
irange	tablei	ifreq, 4	
iwt1	=		1					; WAVETABLE NUMBERS
iwt2	table	(irange*4), 3	
iwt3	table	(irange*4)+1, 3	
iwt4	table	(irange*4)+2, 3	
inorm	table	(irange*4)+3, 3		; NORMALIZATION FACTOR
iphase	=		giseed				; SAME PHASE FOR ALL TABLES
giseed	=		frac(giseed*105.947)	
awt1	oscil	amp1, kfreq, iwt1, iphase ; WAVETABLE LOOKUP
awt2	oscil	amp2, kfreq, iwt2, iphase	
awt3	oscil	amp3, kfreq, iwt3, iphase	
awt4	oscil	amp4, kfreq, iwt4, iphase	
asig	=		(awt1+awt2+awt3+awt4)*iamp/inorm
afilt	tone	asig, ifcut			; LP FILTER...
asig	balance	afilt, asig			; ... TO CONTROL BRIGHTNESS
garev	=		garev+asig	
		out		asig	
		endin		
			
		instr 899		
arev	reverb	garev, 1.2			; OUTPUT REVERB SIGNAL
		out		.1*arev				; SET garev TO 0 ...
garev	=		0					; ... TO PREVENT FEEDBACK
		endin		
