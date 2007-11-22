  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   1
  k1        line      0, p3, sr/2
  a1        oscil     32000, k1, 1
            out       a1
endin
