; ORQUESTRA FILE
 
sr = 44100
kr = 4410
ksmps = 10.0



instr 1
 kenv linseg 0, p3/2, p4, p3/2, 0 	; up-down envelope 
 krand randi cpspch(p5) *.03, kr 	; a band of frequencies
 aindex phasor cpspch(p5) + krand	; read table at pitch rate
 asig table aindex * 1024, 1;    	; index table
 out asig * kenv			; output signal
endin

