  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   508
  k1        expon     p4, p3, .001
  a1        foscil    k1,cpspch(p5),1,.5,p6,1
            out       a1
endin
