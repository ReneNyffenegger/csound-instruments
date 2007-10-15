gkgauss	init	0

	instr	1816	; A TIME-VARYING STOCHASTIC GENERATOR
itwopi	=	6.283185
imean	=	250	; MEAN FREQ
idev 	=	50	; STD DEVIATION
krnd1	rand	0.5, .05463
krnd2	rand	0.5, .34567
kgs1	=	sqrt(-2.0*log(0.501+krnd1))
kgs2	=	kgs1*cos(itwopi*(0.5+krnd2))
kgauss	=	kgs2*idev+imean
gkgauss	=	kgauss
	endin

	instr	1817	; A TIME-VARYING STOCHASTIC GENERATOR
kgt	oscil	1, p5, 2
kfr	samphold	gkgauss, kgt 
aosc	oscil	1, kfr, 1
asig	=	aosc*p4
	out	asig
	endin