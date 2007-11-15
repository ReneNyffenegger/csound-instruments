  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

  giampadj  =  1.0

instr 1
  iamp      =  (ampdb( p4 )) * giampadj
  ifunc     =  p6
  iincr     =  (sr/ftlen(ifunc))*p5
  iphase    =  p7
  iup       =  p3*.1
  idown     =  p3-iup
  kenv      linseg    0,iup,iamp,idown,0
  asig      oscili    kenv, iincr, ifunc, iphase
            out       asig
endin
instr 2
  iamp      =  (ampdb( p4 )) * giampadj
  ifunc     =  p6
  iincr     =  (sr/ftlen(ifunc))*p5
  iphase    =  p7
  iup       =  p3*.9
  idown     =  p3-iup
  kenv      linseg    0,iup,iamp,idown,0
  asig      oscili    kenv, iincr, ifunc, iphase
            out       asig
endin
instr 3
  iamp      =  (ampdb( p4 )) * giampadj
  ifunc     =  p6
  iincr     =  (sr/ftlen(ifunc))*p5
  iphase    =  p7
  iatk      =  .01
  idk       =  .01
  isust     =  p3 -(iatk+idk)
  kenv      linseg    0,iatk,iamp,isust,iamp,idk,0
  asig      oscili    kenv, iincr, ifunc, iphase
            out       asig
endin

instr 4
  iamp      =  p4
  ifunc     =  p6
  iincr     =  (sr/ftlen(ifunc))*p5
  iphase    =  p7
  iatk      =  p8
  idk       =  p9
  isust     =  p3 -(iatk+idk)
  kenv      linseg    0,iatk,iamp,isust,iamp,idk,0
  asig      oscili    kenv, iincr, ifunc, iphase
            out       asig
endin
