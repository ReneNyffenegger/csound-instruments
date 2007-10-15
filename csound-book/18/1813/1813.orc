sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

gkvib	init	0	

		instr	1913		; VIBRATO
kline	line	p5, p3, p6				; FROM p5 TO p6 IN p3
kvb		oscil	1, kline, 1	
gkvib	=		kvb*0.01				; CHANGE RANGE
		endin		

		instr	1914
asig	oscil	p4, p5*(1+gkvib), 1
		out		asig
		endin	

		instr	1915
asig	oscil	p4, p5*(1+gkvib), 2
		out		asig
		endin
