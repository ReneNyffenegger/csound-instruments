  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  ifr       cpsmidib  2
  a1        oscil     32000, ifr, 1
            out       a1
endin
