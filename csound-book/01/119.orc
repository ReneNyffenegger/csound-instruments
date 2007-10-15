		instr   119
k1      oscil   p4, 1/p3 * p8, p7
k2      line    p11, p3, p12
a1   	foscil 	k1, p5, p9, p10, k2, p6
		out     a1
		endin
