  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


instr     1

  ifreq     =  cpspch(p4)                         ;p4 = note
  ifreq1    =  ifreq * p5                         ;p5,p6,p7 = carrier ratio
  ifreq2    =  ifreq * p6
  ifreq3    =  ifreq * p7

  kc1eg     oscil     p11, 1 / p3, 2              ;p11-p16 = op amplitude
  kc2eg     oscil     p12, 1 / p3, 4
  kc3eg     oscil     p13, 1 / p3, 6
     
  km1eg     oscil     p14, 1 / p3, 3
  km2eg     oscil     p15, 1 / p3, 5
  km3eg     oscil     p16, 1 / p3, 7
     
  am1       oscil     km1eg,    p8 * ifreq1, 1    ;p8,p9,p10 = c:m ratio
  am2       oscil     km2eg,    p9 * ifreq2, 1
  am3       oscil     km3eg,    p10 * ifreq3, 1
     
  ac1       oscil     kc1eg,    ifreq1 + am1, 1
  ac2       oscil     kc2eg,    ifreq2 + am2, 1
  ac3       oscil     kc3eg,    ifreq3 + am3, 1
     
            out       ac1 + ac2 + ac3
endin
