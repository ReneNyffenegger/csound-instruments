strset	9,	"fox.aif"
strset	10,	"gaussReverb.con"

	instr	2604	; MIX REVERB, DELAY & DARKEN
iscale	=	p4
iexcite	=	p5
irespond	=	p6
idelay	=	2.972789-0.02	; REVERB STARTS 20 MS AFTER SOUND
irat	=	0.3	; RATIO OF REVERB TO DIRECT SOUND
aa	soundin	iexcite
ad	delay	aa, idelay
ab	convolve	aa, irespond 
ab	tone	ab, 1000	; DARKEN (LPF) THE REVERB
	out	ad+ab*iscale*irat
	endin
