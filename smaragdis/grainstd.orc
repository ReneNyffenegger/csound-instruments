  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1
          
instr 1
  kamp      linseg    0, p3/4, 2000, 3*p3/4, 0
  kp        expon     1, p3, .5
  a1        grain     kamp, 1000*kp, 500, 0, 10,.05, 1, 2, .1
  a2        grain     kamp, 2000*kp, 500, 0, 10,.05, 1, 2, .1
  a3        grain     kamp, 1600*kp, 500, 0, 10,.05, 1, 2, .1
  gasnd     =  a1+a2+a3
            out       gasnd/2
endin

instr 2
  aout      reverb    gasnd, 2
  kamp      line      1, p3, 0
            out       aout/4
endin
