; ORQUESTRA FILE
 
sr = 44100
kr = 4410
ksmps = 10.0


instr 1
 ivar =  100				; ivar set to 100
 k3 linseg 100, p3*.5, 0, p3*.5, 100		; moves linearly from 100 to 0 and back to 100
 k3 =  k3 * ivar				; scale the amplitude of the envelope
 asig  oscil  k3, cpspch(p5), 1		; sine wave oscilator
 out    asig				; output 
endin

