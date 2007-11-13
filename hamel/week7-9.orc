; ORQUESTRA FILE

sr = 44100
kr = 4410
ksmps = 10.0


instr 1
 krand randi 1, .5			; range is -1 to +1, rate is every 2 seconds
 asig oscil p4, cpspch(p5) + krand, 1	; oscillator with 2 cps freq deviation
 out asig
endin


