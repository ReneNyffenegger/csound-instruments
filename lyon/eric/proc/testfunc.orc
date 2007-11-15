  sr        =  1024
  kr        =  1024
  ksmps     =  1

instr 1
  aout      oscil     -32767.0, 1.0, 1            ; negative to invert lowered cos
            out       aout        
endin

instr 2
  kspeed    line      1,p3,4
  aout      oscili    32767.0, kspeed, 1          ; 
            out       aout        
endin