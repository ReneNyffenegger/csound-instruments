; ORQUESTRA FILE
 
sr = 44100
kr = 4410
ksmps = 10.0



instr 1
 asig oscil p4, cpspch(p5), 1	; oscilator
 afilter tone asig, 1000		; filter above 1000
 afin balance afilter, asig		; balance audio signal 
 out afin 			; output
endin


