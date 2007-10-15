garvb init 0

	instr	513	; expanded macro
a1	oscil	p4, p5, p6
ga	=	garvb+a1
	out	a1
	endin

	instr	514	; expanded macro
a1	wgpluck2	p8, p4, p5, p6, p7
ga	=	garvb+a1
	out	a1
	endin
