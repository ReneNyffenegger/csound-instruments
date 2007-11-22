  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  kamp      line      0, p3, 20000
  agr       grain     30000, 0, 100, 500, 10, .05, 1, 2, 1
            out       agr
endin

