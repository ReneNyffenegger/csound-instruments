  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

  giampadj  =  1.0
  gipio2    =  1.570796
instr 1
  iamp      =  p4 * giampadj
  ifunc     =  p6
  iincr     =  (sr/ftlen(ifunc))*p5
  iphase    =  p7
  iloc      =  p8 * gipio2
  ileft     =  cos( iloc )
  iright    =  sin( iloc )
  iatk      =  .01
  idk       =  .05
  isust     =  p3 -(iatk+idk)
  aenv      linseg    0,iatk,iamp,isust,iamp,idk,0
  asig      oscili    aenv, iincr, ifunc, iphase
            outs      asig*ileft, asig*iright
endin

; for new program version specifying atk and dk
instr 2
  iamp      =  p4 * giampadj
  ifunc     =  p6
  iincr     =  (sr/ftlen(ifunc))*p5
  iphase    =  p7
  iloc      =  p8 * gipio2
  ileft     =  cos( iloc )
  iright    =  sin( iloc )
  iatk      =  p9
  idk       =  p10
  isust     =  p3 -(iatk+idk)
  kenv      linseg    0,iatk,iamp,isust,iamp,idk,0
  asig      oscili    kenv, iincr, ifunc, iphase
            outs      asig*ileft, asig*iright
endin
