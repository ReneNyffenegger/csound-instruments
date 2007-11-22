  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr     1

  iamp      =  ampdb(p4)
  ifreq     =  p5
  irate     =  p6
  ifun      =  p7
  ifun2     =  p8

  kamp      oscili    iamp, irate, ifun
  kglis     oscili    1200, 1/p3, ifun2
  asig      oscil     kamp, ifreq + kglis, 1
            outs      asig, asig
endin
