; ORQUESTRA FILE
 
sr = 44100
kr = 4410
ksmps = 10.0


instr 1
kenv linseg 0, .05, 1, p3-.05, 0        ; envelope scaled to 1
 asig oscil kenv * p4, cpspch(p5), 1    ; amp argument multiplied by max amplitude 
 out asig                        
endin


