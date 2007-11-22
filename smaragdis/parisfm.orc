  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  a1        oscil     1000, 500, p4
  a2        oscil     20000, 500 + a1, p4
            out       a2
endin
