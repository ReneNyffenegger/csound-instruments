	strset	1, "hello.con"
	strset	2, "fox.con"
	strset	3, "oneEcho.aif"
	strset	4, "twoEchos.aif"
	strset	5, "fiveEchos.aif"
	strset	6, "gaussReverb.aif"
	strset	7, "uniformReverb.aif"
	strset	8, "whiteNoise.aif"

	instr	2603	; ECHO & REVERB DEMOS
iscale	=	p4
iexcite	=	p5
irespond	=	p6
aa	soundin	iexcite
ab	convolve	aa, irespond
	out	ab*iscale
	endin
