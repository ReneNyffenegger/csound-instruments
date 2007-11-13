sr		=		44100
kr		=		4410
ksmps	=		10
nchnls	=		1


		instr 	1
a1 		expseg 	.001,p7,1,p3-p7,.001
a1 		oscili 	a1,p4,3

a2 		oscili 	p5,p6,2
		out 		a1*a2
		endin
