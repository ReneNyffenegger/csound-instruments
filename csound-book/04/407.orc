sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

		instr 	407		
k1		line	0, p3, 32000		; GENERATE THE ENVELOPE SCALED THIS TIME
a1		oscil	k1, 440, 1			; NOW APPLY IT ON THE OSCILATOR
		out		a1					; AND PLAY THE RESULT
		endin		
