  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  a1        rand      10000
  a2        samphold  a1, 1000
            out       a2
endin

