  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  kamp      line      0, p3, 20000
  agr       grain     kamp, 0, 1000, 0, 10, .005, 1, 2, 2
            out       agr
endin

