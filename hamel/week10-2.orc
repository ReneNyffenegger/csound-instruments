; ORQUESTRA FILE
 
sr = 44100
kr = 4410
ksmps = 10.0


instr 1
 aindex line 0, p3, 1		; rises from 0 to 1 in the total duration
 asig table aindex*32768, 1 	; read table 1 (with raw values) 
 out asig			;output 
endin
