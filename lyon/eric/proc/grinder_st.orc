  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2
  gipo      =  1.570796
  giampadj  =  1 

instr 1
  iamp      =  (ampdb( p4 )) * giampadj
  ifunc     =  p6
  iincr     =  (sr/ftlen(ifunc))*p5
  iphase    =  p7
  is        =  p8
  iup       =  .04
  idown     =  .04
  isust     =  p3-(iup+idown)
  ileft     =  (cos(gipo*is))*iamp
  iright    =  (sin(gipo*is))*iamp

  kenv      linseg    0,iup,iamp, isust, iamp, idown,0
  asig      oscili    kenv, iincr, ifunc, iphase
            outs      asig*ileft, asig*iright
endin

instr 2
  iamp      =  (ampdb( p4 )) * giampadj
  ifunc     =  p6
  iincr     =  (sr/ftlen(ifunc))*p5
  iphase    =  p7
  is        =  p8
  iup       =  p3 * .95
  idown     =  p3 - iup
  isust     =  p3-(iup+idown)
  ileft     =  (cos(gipo*is))*iamp
  iright    =  (sin(gipo*is))*iamp

  kenv      linseg    0,iup,iamp, idown,0
  asig      oscili    kenv, iincr, ifunc, iphase
            outs      asig*ileft, asig*iright
endin

instr 3
  iamp      =  (ampdb( p4 )) * giampadj
  ifunc     =  p6
  iincr     =  (sr/ftlen(ifunc))*p5
  iphase    =  p7
  is        =  p8
  iup       =  p3 * .05
  idown     =  p3 - iup
  isust     =  p3-(iup+idown)
  ileft     =  (cos(gipo*is))*iamp
  iright    =  (sin(gipo*is))*iamp

  kenv      linseg    0,iup,iamp, idown,0
  asig      oscili    kenv, iincr, ifunc, iphase
            outs      asig*ileft, asig*iright
endin

instr 4
  iamp      =  (ampdb( p4 )) * giampadj
  ifunc     =  p6
  iincr     =  (sr/ftlen(ifunc))*p5
  iphase    =  p7
  is        =  p8
  iup       =  p3 * .5
  idown     =  p3 - iup
  isust     =  p3-(iup+idown)
  ileft     =  (cos(gipo*is))*iamp
  iright    =  (sin(gipo*is))*iamp

  kenv      linseg    0,iup,iamp, idown,0
  asig      oscili    kenv, iincr, ifunc, iphase
            outs      asig*ileft, asig*iright
endin
