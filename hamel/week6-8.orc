

; ORQUESTRA FILE
 
  sr        =  44100
  kr        =  4410
  ksmps     =  10.0


instr 1
  kenv      linseg    1, p3, 0 
  asig      foscil    p4*kenv, cpspch(p5), 1, 2.03, 1, 1
            out       asig
endin


