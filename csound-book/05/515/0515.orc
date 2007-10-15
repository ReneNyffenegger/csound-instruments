garvb init 0

#define	REVERB(A)	#garvb	=	garvb+$A.
			out	$A.#

	instr	515 ; reverb macro
a1	oscil	p4, p5, p6
	$REVERB(a1)	
	endin

	instr	516 ; reverb macro
a2	wgpluck2	p8, p4, p5, p6, p7
	$REVERB(a2)
	endin
