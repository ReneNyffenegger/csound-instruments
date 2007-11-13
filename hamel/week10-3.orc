; ORQUESTRA FILE
 
sr = 44100
kr = 4410
ksmps = 10.0


instr 1
 aindex phasor (.894/1.5) / p3, p6 	; offset passed in p6 (between 0 and 1)
 asig table aindex*32768, 1		; read table 1 (with raw values) 
 out asig			;output 
endin
