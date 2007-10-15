			instr 135
idur		=		p3
iamp		=		p4
igain		=		p5
iloopt		=		p6
kenv		linen	iamp, .01, idur, .01
ain 		diskin  "hellorcb.aif", 1.1	
acomb 		comb	ain*kenv, igain, iloopt, 0
			out		ain+acomb
			endin
