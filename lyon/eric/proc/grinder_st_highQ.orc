  sr        =  44100
  kr        =  4410
  ksmps     =  10
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

  aenv      linseg    0,iup,iamp, isust, iamp, idown,0
  asig      oscili    aenv, iincr, ifunc, iphase
            outs      asig*ileft, asig*iright
endin
