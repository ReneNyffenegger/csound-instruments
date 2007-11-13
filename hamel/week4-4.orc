
; ORQUESTRA FILE
sr = 44100
kr = 4410
ksmps = 10.0



instr 1
 ifund = cpspch(p5)					; fundamental
 kenv1     expseg .0001, .01, 1, .01, .5, p3 - .02, .0001	; envelope 1
 asig1     oscil p4 * kenv1, ifund, 1			; oscillator 1
 kenv2 expseg .0001, .01, .7, .03, .4, p3 - .04, .0001		; envelope 2
 asig2 oscil p4 * kenv2, ifund*2, 1				; oscillator 2
 out    (asig1 + asig2) / 2					; output mix
endin


