  sr        =  44100
  kr        =  4410
  ksmps     =  10
;cheesy FM

;f1 0 4096 10 1
;i1 0 dur freq amp

instr 1 ; accent
  icar      =  1.0
  imod      =  2.01
  iatk      =  .01
  idk1      =  .01
  idk2      =  p3-(iatk+idk1)
  iamp      =  10000 * p5
  iamp2     =  iamp*.4
  ifreq2    =  cpspch( p4 )
  ifreq1    =  ifreq2*.95
  ifatk     =  .03
  ifsust    =  p3-ifatk
  idx1      =  .015
  idx2      =  .025
  idx3      =  p3-(idx1+idx2)
  isdk      =  .05
  issust    =  p3 - isdk
  irvt      =  .2
  ilpt      =  1/cpspch(p4)
  aenv1     linseg    0,iatk, iamp, idk1, iamp2, idk2, 0
  ksafenv   linseg    1,issust,1,isdk,0
  kcps      linseg    ifreq1,ifatk,ifreq2,ifsust,ifreq2
  kndex     linseg    .5, idx1, 4.5, idx2, .25, idx3, 1
  afm       foscil    aenv1, kcps, icar, imod, kndex, 1 ; sine
  aout      comb      afm, irvt, ilpt
            out       aout*ksafenv
endin
instr 2 ; norm
  icar      =  1.0
  imod      =  1.01
  iatk      =  .02
  idk1      =  .02
  idk2      =  p3-(iatk+idk1)
  iamp      =  7000
  iamp2     =  iamp*.6
  ifreq2    =  p4
  ifreq1    =  p4*1.03
  ifatk     =  .05
  ifsust    =  p3-ifatk
  idx1      =  .03
  idx2      =  .025
  idx3      =  p3-(idx1+idx2)
  isdk      =  .05
  issust    =  p3 - isdk
  irvt      =  .2
  ilpt      =  1/p4
  aenv1     linseg    0,iatk, iamp, idk1, iamp2, idk2, 0
  ksafenv   linseg    1,issust,1,isdk,0
  kcps      linseg    ifreq1,ifatk,ifreq2,ifsust,ifreq2
  kndex     linseg    1, idx1, 3.3, idx2, .25, idx3, 1
  afm       foscil    aenv1, kcps, icar, imod, kndex, 1 ; sine
  aout      comb      afm, irvt, ilpt
            out       aout*ksafenv
endin
