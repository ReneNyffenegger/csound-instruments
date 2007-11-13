sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

		instr 	205						
ksweep	linseg	0, p3*.5, .49, p3*.5, 0	; INDEX SWEEP FUNCTION
aindex	oscili	ksweep, p5, 2		; SOUND TO WAVESHAPE
atable	tablei	aindex, 26, 1, .5	; WAVESHAPE aindex
knorm	tablei	ksweep*2, 27, 1		; MAKE NORMALIZATION Fn
kenv	linen	p4, .01, p3, .02	; AMPLITUDE ENVELOPE
		out		atable*knorm*kenv	; NORMALIZE AND IMPOSE ENV
		endin
