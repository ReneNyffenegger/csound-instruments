  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr 1
;f1 0 8192 11 8 0 .7
;f2 0 8192 10 .7 .3 .2 .01 .6 .1 .8 0 0 .1
;i1 0 dur amp freq(pch)
  iseg1     =  .001
  iseg2     =  .003
  iseg3     =  .006
  iseg4     =  .03
  iseg5     =  .01
  iseg6     =  p3-(iseg1+iseg2+iseg3+iseg4+iseg5)
  igain     =  p4 * 7000.
  iamp1     =  0.
  iamp2     =  .1 * igain
  iamp3     =  .4 * igain
  iamp4     =  igain
  iamp5     =  .7 * igain
  iamp6     =  .25 * igain
  iamp7     =  0.0
  ifreq1    =  cpspch( p5 )
  ifreq2    =  ifreq1 * 1.005
  ibuzzfunc =  1
  iwavefunc =  2
  isinefunc =  3
  aenvnote  linseg    iamp1,iseg1,iamp2,iseg2,iamp3,iseg3,iamp4,iseg4,iamp5,iseg5,iamp6,iseg6,iamp7
  ablpenv   line      1,p3,0
  ablp      oscili    ablpenv,ifreq1,ibuzzfunc
  awave1    oscili    1.0, ifreq1, iwavefunc
  awaveenv  line      0.,p3,1.
  awave2    oscili    awaveenv, ifreq2, iwavefunc
  asum      =  (ablp+awave1+awave2)*aenvnote
  amod      oscili    ablpenv, ifreq1, isinefunc
  achiff    =  asum * amod
            out       asum+achiff
endin
