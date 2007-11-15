  sr        =  44100
  kr        =  2205
  ksmps     =  20
  nchnls    =  1

  gircosfunc   =      1
instr 1
  iamp      =  p4 * 5000
  ia        =  .25
  id        =  .25
  is        =  p3-(ia+id)
  isp1a     =  p9
  isp1b     =  p10
  isp2a     =  p11
  isp2b     =  p12
;ifr1 = cpspch( p5 )
;ifr2 = ifr1 * p6
;ifr3 = ifr1 * p7
;ifr4 = ifr1 * p8
  idev      =  .45
  ifr1      =  p5
  ifr2      =  p6
  ifr3      =  p7
  ifr4      =  p8
  ibase     =  (1. - idev)+(idev/2)
  idevamp   =  idev/2
;f1 0 2048 10 1
;f2 0 2048 10 1 .2 .05
;f3 0 2048 10 .5 .2 1.0 .5 .3 .1 .04
;f4 0 2048 10 1 .1 .05 .15
;f5 0 2048 10 .1 .5 .7 .2 .1 .8 .1
  aenvout   linseg    0, ia, iamp, is, iamp, id, 0
  kenv1     oscil     idevamp, isp1a, 1
  kenv2     oscil     idevamp, isp1b, 1
  kenv3     oscil     idevamp, isp2a, 1
  kenv4     oscil     idevamp, isp2b, 1
  kenv1     =  kenv1 + ibase
  kenv2     =  kenv2 + ibase
  kenv3     =  kenv3 + ibase
  kenv4     =  kenv4 + ibase
  asig1a    oscil     kenv1, ifr1, 2
  asig1b    oscil     kenv2, ifr2, 3
  asig2a    oscil     kenv3, ifr3, 4
  asig2b    oscil     kenv4, ifr4, 5
  asum1     =  asig1a+asig1b
  asum2     =  asig2a+asig2b
  arm       =  asum1*asum2*aenvout
            out       arm
endin
