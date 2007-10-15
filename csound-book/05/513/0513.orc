garvb init 0

#define	REVERB	#garvb	=	garvb+a1
			out 	a1#

	instr	513 ; macro example
a1	oscil	p4, p5, p6
	$REVERB.
	endin

	instr	514 ; macro example
a1	wgpluck2	p8, p4, p5, p6, p7
	$REVERB.
	endin
