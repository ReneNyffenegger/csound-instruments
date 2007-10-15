	instr	2610	; BRIGHT MUSIC DEMOS
iscale	=	p4
iexcite	=	p5
irespond	=	p6
aa	soundin	iexcite
ab	convolve	aa, irespond
ab	diff	ab
	out	ab*iscale
	endin
