  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr     1
  iamp      =  ampdb(p4)
  ifreq     =  p5
  ifun      =  p6
  kamp      oscili    iamp, 1/p3, ifun
  asig      oscil     kamp, ifreq, 1
            out       asig
endin
