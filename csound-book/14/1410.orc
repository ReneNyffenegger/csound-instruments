  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   1410
  k1        linseg    0, p3, 10
  a1        fof       15000, 2, 300, 0, k1, .003, .5, .1, 2, 1, 2, p3
            out       a1
endin
