
  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  2

instr 1
  iamp      =  ampdb(p4)
  ifreq1    =  p5
  ifreq2    =  p6
  ifun      =  p7
  kamp      oscili    iamp, 1/p3, ifun
  asig1     oscil     kamp, cpspch(p5), 1
  asig2     oscil     kamp, cpspch(p6), 1
            outs      asig1, asig2
endin
