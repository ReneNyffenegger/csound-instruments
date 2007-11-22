  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  iamp      pow       10, 2
  a1        oscil     iamp, 100, 2
  a2        pow       a1, 2, 1
            out       a2
endin
