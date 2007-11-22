  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr   1
  k1        linseg    0,p3*.8,1,p3*.2,0
  a1        oscili    p6, p5, p4
  a2        oscili    30000, p5 + (a1*k1), p4
            out       a2
endin
