  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   505
  kenv      linen     p4, .1, p3, .1
  asig      oscil     kenv, p5, 1
            out       asig
endin

instr   506
  kenv      linen     p4, .4, p3, .1
  asig      oscil     kenv, p5, 2
            out       asig
endin
