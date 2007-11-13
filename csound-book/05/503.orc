  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   503
  kenv      linen     p4, .3, p3, .3
  asig      oscil     kenv, cpspch(p5), 1
            out       asig
endin
