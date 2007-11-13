
; ORQUESTRA FILE
 
sr = 44100
kr = 4410
ksmps = 10.0


instr 1
 kenv expon 1, p3, .0001  				;expon envelope
 asig foscil p4*kenv, cpspch(p5), 1, 2.01, 1, 1 	; f.m. instrument 
 arev reverb asig, 2.0   				; 2 second reverb
 out arev + asig
endin


