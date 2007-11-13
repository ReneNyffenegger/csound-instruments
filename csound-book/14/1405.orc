  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   1405
  k1        linseg    0, p3*.1, 0, p3*.8, 6, p3*.1, 6
  a1        fof       15000, 200, 650, k1, 40, .003, .02, .007, 5, 1, 2, p3
            out       a1
endin
