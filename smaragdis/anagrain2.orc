  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  ims       =  100
  ifr       =  2*1.3113
  a1        linseg    2000, 5, 100, 3, 100, 5, 0
  k1        linseg    .0005, 5, .3, p3 -  5, .3
  kf        linseg    0, 8, 0, 0, ifr/2, 5, 0
  a3        grain     4000,ifr, a1, 0, kf, k1, 1, 2, .4
            out       a3
endin

instr 2
  ims       =  100
  ifr       =  1.3113
  a1        linseg    10, p3/2, 50, p3/2, 1
  a3        grain     4000, ifr/2, a1, 4000, ifr, .05, 1, 3, .05
            out       a3
endin

instr   3
  a1        oscil     10000, 2.5, 1
            out       a1
endin
