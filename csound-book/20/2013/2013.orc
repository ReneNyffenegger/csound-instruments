	instr	2013	; PHONE VOICE SCRAMBLER
acarr	oscil	1, 8000, 1	; GEN CARRIER
amod	soundin	"Hamlet.aif"	; THE FILE TO SCRAMBLE.
a1	tone	amod, 10000	; GENTLE PREFILTER
a2	convolve	a1, "Sharp_8kHz_Lowpass.con"	; SHARP PREFILTER
asig	=	a2*acarr	; MODULATE
a3	tone	asig, 10000	; GENTLE FILTER
ascram	convolve	a3, "Sharp_8kHz_Lowpass.con"	; SHARP FILTER
	out	ascram*0.2999
	endin
