; VIBECHORD.ORC

sr 		= 		44100
kr 		= 		4410
ksmps 	= 		10
nchnls 	= 		2


		instr	1										; a pseudo-vibraphone instrument

ishift	=		.02										; pitch shift by 24 cents (Pythagorean
														; comma)
ipch		=		cpspch(p5)								; converts p5 to cps
ioct		=		octpch(p5)								; converts p5 to oct
kvib		oscil	1/120, ipch/50, 1							; vibrato
ag		pluck	1000, cpsoct(ioct+kvib), 1000, 1, 1		 	; amp, kcps, icps, ifn, imeth (1 - 6)
aglt		pluck	1000, cpsoct(ioct+ishift), 1000, 1, 1
agrt		pluck	1000, cpsoct(ioct-ishift), 1000, 1, 1
adump	delayr	0.3										; delay time of 0.3 sec
		delayw	ag										; put source signal into delay line
ad1		deltap	0.2										; delay 200 msec.
ad2		deltap	0.25										; delay 250 msec.
		outs		aglt+ad1, agrt+ad2							; left & right outputs combined with tap delay
		endin
