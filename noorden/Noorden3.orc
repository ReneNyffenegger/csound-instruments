  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr     1
                               
  iamp      =  ampdb(p4)
  ifreq     =  p5
  irate     =  p6
  ifun      =  p7

  kamp      oscili    iamp, irate, ifun
  asig      oscil     kamp, ifreq, 1
            out       asig
endin
