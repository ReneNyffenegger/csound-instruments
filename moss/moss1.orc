  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  iamp      =  p4

  a3        oscil     iamp*.1, 2200, 1

  k2        linseg    0, .128*p3, .92, .19*p3, .3, .682*p3, 0
  a2        oscil     iamp*.0708*k2, a3+110, 2

  k1        line      1, p3, 0
  a1        oscil     iamp*.5957*k1, a2+220, 1

            out       a1
endin
