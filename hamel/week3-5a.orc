; ORQUESTRA FILE
 
sr = 44100
kr = 4410
ksmps = 10.0



instr 1
  ivar =  10000			; ivar set to 10000
  k1 line 1, p3, 0		; moves linearly from 1 to 0 in the duration p3
  k1 =  k1 * ivar			; scale the amplitude of the envelope
  asig  oscil  k1, cpspch(p5), 1	; sine wave oscilator
  out    asig			; mono output 
endin


