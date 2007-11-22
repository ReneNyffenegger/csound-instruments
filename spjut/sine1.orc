  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  k1        linseg    0, p3/2, 32000, p3/2, 0
  a1        oscil     k1, 440, 1
            out       a1
endin
