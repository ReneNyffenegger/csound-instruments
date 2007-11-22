  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2
  gipo      =  1.570796

instr               1
            massign   1,1
  knote     cpsmidib  
  inote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc,0,.2,.01
  ifreq     =  inote
  ires      =  ifreq*1.826692
  ipanspeed =  3.869687
  itremspeed   =      23.914413
  icenter   =  0.381354
  ileft     =  0.355625
  iright    =  0.786218
  iseed1    =  0.021070
  iseed2    =  0.512205
  iamp      =  80000
  itremfunc =  1
  iwavefunc =  2
  iatk      =  .05
  idk       =  .05
  isust     =  8.827958-(iatk+idk)
  inoisebw  =  ifreq*.1
  iresbw    =  ifreq*.25
  ipanmax1  =  iright-icenter
  ipanmax2  =  icenter-ileft
  ip2max1   =  ipanmax1/2.0
  ip2max2   =  ipanmax2/2.0

  kenv      linseg    0,iatk,iamp,isust,iamp,idk,0
  kpan1     randi     ip2max1,ipanspeed,iseed1
  kpan2     randi     ip2max2,ipanspeed,iseed2
  kpan1     =  kpan1+ip2max1
  kpan2     =  kpan2-ip2max2
  kcenter   =  icenter+kpan1+kpan2
  kleft     =  cos(gipo*kcenter)
  kright    =  sin(gipo*kcenter)
  asig      soundin   5,0
  ares      reson     asig,ires,iresbw,1
            outs      (ares*kleft)*kgate,(ares*kright)*kgate
endin
