	instr	2014	; PHONE VOICE DESCRAMBLER
acarr	oscil	1, 8000, 1	; GEN CARRIER
amod	soundin	"VoiceScrambler.aif"	; FILE TO DESCRAMBLE
asig	=	amod*acarr	; MODULATE
a3	tone	asig, 10000	; GENTLE FILTER
adescr	convolve	a3, "Sharp_8kHz_Lowpass.con"	; SHARP FILTER
	out	adescr*0.7246
	endin
