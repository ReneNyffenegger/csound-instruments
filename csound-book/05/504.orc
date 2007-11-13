  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   504
  kenv1     linen     p4, .3, p3, .3
  kenv2     linseg    0, p3*.9, p4, p3*.1, 0
  asig1     oscil     kenv1, cpspch(p5), 1
  asig2     oscil     kenv1, cpspch(p5)*p7, 2
  asig3     oscil     kenv2, cpspch(p5)*p6, 3
  amix      =  asig1 + asig2 + asig3
  aflt      butterlp  amix, p8*p9
            out       aflt
endin
