; ORQUESTRA FILE
 
  sr        =  44100
  kr        =  4410
  ksmps     =  10.0


instr 1
  asig      oscil     p4, cpspch(p5), 1           ; oscillator
  asig      linen     asig, .05, p3, .1           ; attack .05, decay .1
            out       asig
endin

