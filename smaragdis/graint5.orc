  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  kdens     line      1, p3, 2000
  agr       grain     5000, 0, 1000, 0, kdens, .005, 1, 2, 2
            out       agr
endin
