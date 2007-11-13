; ORQUESTRA FILE
 
sr = 44100
kr = 4410
ksmps = 10.0


instr 1
 aindex line p6, 2, p7  		; read from p6 to p7 (between 0 and 1) 
 asig table aindex*32768, 1 	; read table 1 (with raw values) 
 out asig			;output 
endin


