
; ORQUESTRA FILE
 
  sr        =  44100
  kr        =  4410
  ksmps     =  10.0


instr 1
  amod      oscil     p4*.2, cpspch(p5), 1        ; modulator
  asig      oscil     p4*.8, cpspch(p5) + amod, 1 ; carrier
            out       asig
endin


