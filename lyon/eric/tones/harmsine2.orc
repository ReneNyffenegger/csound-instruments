  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2
  gipo      =  1.570796

instr 2
  igain     =  1.0
  iatk      =  .02
  idk       =  .02
  isust     =  p3-(iatk+idk)
  gaenv     linseg    0,iatk,igain,isust,igain,idk,0
endin
instr 1
  iamp      =  20000
  ifreq     =  p4 * .357
  idepth    =  ifreq * .05
  ifunc     =  p5
  ivib      =  p6/2.
  ipos      =  p7
  iphase    =  p8
  ileft     =  (cos(gipo*ipos))*iamp
  iright    =  (sin(gipo*ipos))*iamp
  kdex      oscil     idepth, 1/p3, 5             ; 5 is intense func
  kadd      oscil     kdex, ivib, 6, iphase       ; 6 is sine
  kfreq     =  ifreq + kadd
  asig      oscili    gaenv,kfreq,ifunc
  asig1     oscili    gaenv,kfreq*1.5,ifunc
  asig      =  asig + asig1
  asig      atone     asig,100.
            outs      asig*ileft,asig*iright
endin
