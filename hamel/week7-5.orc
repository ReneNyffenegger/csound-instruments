
; ORQUESTRA FILE

sr = 44100
kr = 4410
ksmps = 10.0


instr 1
 kenv linseg 0, p3 * .5, 1, p3 * .5, 0	; up-down ramp envelope
 kband line 50, p3, 5			; ramp bandwidth from 100 to 10
 kran randh kband, kr			; produce values between - and + kband
 kran =  kran + 200			; shift values to centre of 200
 asig oscil kenv * p4, kran, 1		; generate a band of noise
 out asig
endin

