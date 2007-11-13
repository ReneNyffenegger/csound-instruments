  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   1404
  a2        expseg    5, p3*.8, 200, p3*.2, 150
  a1        fof       15000, a2, 650, 0, 40, .003, .02, .007, 5, 1, 2, p3
            out       a1
endin
