; ORQUESTRA FILE
 
sr = 44100
kr = 4410
ksmps = 10.0

instr 1
 ivar =  100				; ivar set to 100
 k4 expseg 100, p3*.5, .0001, p3*.5, 100	; moves exponentially from 100 to 0 and back 
 k4 =  k4 * ivar				; scale the amplitude of the envelope
 asig  oscil  k4, cpspch(p5), 1		; sine wave oscilator
 out    asig				; mono output 
endin

