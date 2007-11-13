sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

		instr 	409		
a1		oscil	32000, 440, 1		; READ FROM A TABLE CONTAINING THE MODULATED SIGNAL
		out		a1					; AND PLAY THE OUTPUT
		endin
