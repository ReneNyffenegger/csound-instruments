sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1
          
; CHEESY FM

; f1 	0 		4096 10 1
; i1 	0 		DUR FREQ AMP

		instr 1 			; ACCENT
icar 	= 		1.
icps 	= 		p4
imod 	= 		1.0 * icar
igain 	= 		p5 * 25000
isust 	= 		p3 - .2
kenv 	linseg 	0, .1, igain, isust, igain, .1, 0
kindex 	line 	1, p3,  2.
kmod 	line 	icar, p3, icar * 2
afm 		foscil 	kenv, icps, icar, kmod, kindex, 1	; SINE
		out 		afm
		endin
