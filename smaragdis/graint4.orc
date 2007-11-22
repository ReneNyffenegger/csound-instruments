  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
  kfreqoff  line      0, p3, 1000
  agr       grain     10000, 0, 1000, kfreqoff, 20, .05, 1, 2, 2
            out       agr
endin
