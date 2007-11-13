
; ORQUESTRA FILE
 
sr = 44100
kr = 4410
ksmps = 10.0


instr 1
 kenv linseg 0, p3 * .5, 1, p3 * .5, 0	; up-down ramp envelope
 kran randh 50, kr			; produce values between -50 and 50
 kran =  kran + 200			; shift values to centre of 200
 asig oscil kenv * p4, kran, 1		; generate a band of noise
 out asig
endin


