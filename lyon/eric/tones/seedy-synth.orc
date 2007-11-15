  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2
  gipo      =  1.570796

;i1 0 dur freq amp atk dk
instr 1
  ifreq     =  p4
  ires      =  ifreq * p5
  ipanspeed =  p6
  itremspeed   =      p7
  icenter   =  p8
  ileft     =  p9
  iright    =  p10
  iseed1    =  p11
  iseed2    =  p12
  iamp      =  p13 * 20000
;
  itremfunc =  1
  iwavefunc =  2
  iatk      =  .05
  idk       =  .05
  isust     =  p3-(iatk+idk)
  inoisebw  =  ifreq*.1
  iresbw    =  ifreq * .25
  ipanmax1  =  iright - icenter
  ipanmax2  =  icenter - ileft
  ip2max1   =  ipanmax1/2.0
  ip2max2   =  ipanmax2/2.0

;irbw = ircf/50
  kenv      linseg    0, iatk, iamp, isust, iamp, idk, 0
  kpan1     randi     ip2max1, ipanspeed, iseed1
  kpan2     randi     ip2max2, ipanspeed, iseed2
  kpan1     =  kpan1 + ip2max1
  kpan2     =  kpan2 - ip2max2
  kcenter   =  icenter + kpan1 + kpan2
  kleft     =  cos(gipo*kcenter)
  kright    =  sin(gipo*kcenter)
  atrem     oscil     kenv, itremspeed, itremfunc
  anoise    randi     atrem,inoisebw,iseed1
  asig      oscili    anoise, ifreq, iwavefunc
  ares      reson     asig, ires, iresbw, 1
            outs      ares*kleft, ares*kright
endin

instr 2
  ifreq     =  p4
  ires      =  ifreq * p5
  ipanspeed =  p6
  itremspeed   =      p7
  icenter   =  p8
  ileft     =  p9
  iright    =  p10
  iseed1    =  p11
  iseed2    =  p12
  iamp      =  p13 * 20000
;
  itremfunc =  1
  iwavefunc =  2
  iatk      =  .05
  idk       =  .05
  isust     =  p3-(iatk+idk)
  inoisebw  =  ifreq*.1
  iresbw    =  ifreq * .25
  ipanmax1  =  iright - icenter
  ipanmax2  =  icenter - ileft
  ip2max1   =  ipanmax1/2.0
  ip2max2   =  ipanmax2/2.0

;irbw = ircf/50
  kenv      linseg    0, iatk, iamp, isust, iamp, idk, 0
  kpan1     randi     ip2max1, ipanspeed, iseed1
  kpan2     randi     ip2max2, ipanspeed, iseed2
  kpan1     =  kpan1 + ip2max1
  kpan2     =  kpan2 - ip2max2
  kcenter   =  icenter + kpan1 + kpan2
  kleft     =  cos(gipo*kcenter)
  kright    =  sin(gipo*kcenter)
  asig      soundin   1,p2
  ares      reson     asig, ires, iresbw, 1
            outs      ares*kleft, ares*kright
endin
