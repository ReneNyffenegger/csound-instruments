  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   1403
  a2        oscil     20, 5, 1
  a1        fof       15000, 200+a2, 650, 0, 40, .003, .02, .007, 5, 1, 2, p3
            out       a1
endin
