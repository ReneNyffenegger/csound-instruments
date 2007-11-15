#include "head"

instr 1
  ifreq     =  2000
  inoi1     =  10000
  inoi2     =  7000
  inatk     =  .2
  indk1     =  .1
  insust    =  p3-(inatk+indk1)
  inamp     =  30000
  inamp2    =  inamp*.1
  ikbsust   =  p3 - .3
  anoienv   linseg    0,inatk,inamp,indk1,inamp2,insust,0
  kcf       linseg    inoi1,p3,inoi2
  kbw       linseg    inoi2/40.0,.2,inoi2/30.0,ikbsust,inoi2/50.0,.1,inoi2/20.0
  anoi      randi     anoienv,13000,.545
  anf       reson     anoi,kcf,kbw,1
            out       anf
endin
instr 2
  iamp      =  6000
  icar      =  2000
  icar2     =  icar*.98
  idk       =  .2
  ia        =  .3
  isust     =  p3-(ia+idk)
  aenv      linseg    0,ia,iamp,isust,iamp,idk,0
  kindex    linseg    .6,.4, 1.0,.1, .05,p3-.5, .25
  kindex    =  kindex*icar
  kfm       linseg    icar*1.02,.23,icar*1.0,p3-.23,icar*1.05
  kcar      linseg    icar*.98,.3,icar,p3-.6,icar*1.005,.3,icar*.99
  kcar2     linseg    icar2*.99,.3,icar2,p3-.6,icar2*1.007,.3,icar2*.98
  assin     oscili    kindex,kfm,2
  afreq     =  kcar + assin
  afreq2    =  kcar2 + assin
  amod1     oscili    aenv,afreq,1
  amod2     oscili    aenv,afreq2,1
            out       amod1+amod2
endin
