; ORQUESTRA FILE
  sr        =  44100
  kr        =  4410
  ksmps     =  10.0


instr 1
  kenv      expon     1, p3, .0001                ; expon envelope
  asig      foscil    p4 * kenv, cpspch(p5), 1, 1.414, 2, 1 ; an fm bell 
  adel      delay     asig, .5                    ; delay .5 seconds
            out       asig + adel
endin
