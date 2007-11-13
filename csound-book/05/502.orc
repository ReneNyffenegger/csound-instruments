  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   502
  kenv      linen     p4, .2, p3, .1
  asig1     oscil     kenv, cpspch(p5), 1
  asig2     oscil     kenv, cpspch(p5)*p6, 2
  asig3     oscil     kenv, cpspch(p5)*p7, 3
  amix      =  asig1 + asig2 + asig3
  aflt      butterbp  amix, 8000, p8
  aflt      balance   aflt, amix
            out       aflt
endin
