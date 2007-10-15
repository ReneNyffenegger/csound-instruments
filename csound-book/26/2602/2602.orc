	instr	2602	; FFT CONVOLUTION
a1	soundin	"fox.aif"	; SIGNAL A
a2	convolve	a1, "eightPoint.con"	; SIGNAL B, (USE CVANAL TO MAKE)
	out	a2*p4	; P4 IS SCALING FACTOR
	endin
