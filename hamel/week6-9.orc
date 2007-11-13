
; ORQUESTRA FILE
 
sr = 44100
kr = 4410
ksmps = 10.0


instr 1
 kenv expon 1, p3, .0001  				; expon envelope
 kline line 1, p3, 8     				; sweep index from 1 to 8
 asig foscil p4 * kenv, cpspch(p5), 1, 1.414, kline, 1   ; bell with index sweep
 out asig
endin


