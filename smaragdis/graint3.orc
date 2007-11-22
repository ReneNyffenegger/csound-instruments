  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  kfreq     line      1, p3, 6000
  agr       grain     20000, 0, kfreq, 0, 10, .05, 1, 2, 2
            out       agr
endin
