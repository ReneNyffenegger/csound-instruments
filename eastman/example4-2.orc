  sr        =  44100
  kr        =  2205
  ksmps     =  20
  nchnls    =  1

instr 1
  kamp      expseg    1, .2, 8000, p3-.4, 5000, .2, 1
  ipitch    =  cpspch(p4)
  a1        gbuzz     kamp,  ipitch, p5, p6, p7, 1
            out       a1
endin

