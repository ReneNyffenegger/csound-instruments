
; ORQUESTRA FILE

sr = 44100
kr = 4410
ksmps = 10.0


instr 1
 kenv1 linseg 1, .1, 0, p3 - .1, 0			; short sharp envelope
 kran randh 1000, kr				; produce range of 1000
 kran =  kran + 2000				; centre freq is 2000
 anoise oscil kenv1 * p4, kran, 1			; noise oscillator
 kenv2 expon 1, p3, .0001				; exponential decay
 asig foscili p4*kenv2, cpspch(p5), 1, 1.414, 2, 1	; bell foscil 
 out (asig + anoise) * .5				; output mix of sounds
endin


