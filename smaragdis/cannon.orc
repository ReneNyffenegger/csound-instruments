  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 5
  a1        linrand   20000
            out       a1
endin

instr 4
  a1        trirand   20000
            out       a1
endin

instr 3
  a1        gauss     20000
            out       a1
endin

instr 2
  a1        weibull   250, .5
            out       a1
endin

instr 1
  a1        betarand  20000, .5, .5
            out       a1
endin
