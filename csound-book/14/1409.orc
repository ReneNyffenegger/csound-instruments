  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   1409
  k1        line      .003, p3, .1
  a1        fof       15000, 2, 300, 0, 0, k1, .5, .1, 2, 1, 2, p3
            out       a1
endin
