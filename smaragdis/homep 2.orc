							; TOOT1.ORC 
sr 		= 		44100 
kr 		= 		4410                                  
ksmps 	= 		10
nchnls 	= 		1

		instr 1
kenv 	oscil	p4,	1 / p3 , 2				; p4    = MAX,                 p3 = NOTE DUR
kven 	oscil	p6,	1 / p3,	3				; p6    = MAX
kvib 	oscil  	kven, p7, 1					; p6    = VIB DEPTH,           p7 = VIB SPEED
kpen 	line		p8, p3, p9					; p8,p9 = START/STOP LINE lvl
a1 		oscil	kenv, p5 + kpen + kvib, 1		; p5    = NOTE FREQ	
    		out    	a1
		endin
