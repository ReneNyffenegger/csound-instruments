; ORQUESTRA FILE
 
sr = 44100
kr = 4410
ksmps = 10.0


instr 1
	ivar =  10000			; ivar set to 10000
	kenv linseg 1, p3, 0		; ramp from 1 to 0 in duration p3 
	kenv =  kenv * ivar		; scale the amplitude of the envelope
	asig  oscil  kenv, cpspch(p5), 1	; sine wave oscilator
	out    asig			; mono output 
endin


