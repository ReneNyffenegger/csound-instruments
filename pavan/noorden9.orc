  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1

  iamp      =  ampdb(p4)
  ifreq     =  p5
  irate     =  p6
  ifun      =  p7

  krate     oscili    10, 1/p3, 3
  kamp      oscili    iamp, irate + krate, ifun
  kfreq     randh     3174, p6 + krate
  asig1     oscil     kamp, ifreq + kfreq, 1
  asig      butterlp  asig1, 1800
            out       asig
endin
