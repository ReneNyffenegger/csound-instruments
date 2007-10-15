		instr 	117
k2      linseg  p5, p3/2, p9, p3/2, p5
k3      line    p10, p3, p11
k4      line    p12, p3, p13
k5      expon   p14, p3, p15
k6      expon	p16, p3, p17
a1 		grain 	p4, k2, k3, k4, k5, k6, 1, p6, 1
a2      linen   a1, p7, p3, p8
		out 	a2
		endin
