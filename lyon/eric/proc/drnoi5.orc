  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

;quite similar to drnoi4
instr 1
  ga1,ga2   soundin   p4,p5
endin
;i1 0 dur file skip
;i2 0 dur res1 res2 amp seed
instr 2
  ires1     =  p4
  ires2     =  p4 * 2
  ires3     =  p4 * 3
  ires4     =  p4 * 4
  ires5     =  p4 * 5
  ires6     =  p4 * 6
  ibf       =  .01
;ibf = .9
  iamp      =  p6 * 2
;iamp = p6 *.2
  iseed     =  p7
  ibw1      =  ires1*ibf
  ibw2      =  ires2*ibf
  ibw3      =  ires3*ibf
  ibw4      =  ires4*ibf
  ibw5      =  ires5*ibf
  ibw6      =  ires6*ibf
  kenv      linseg    0,p3/2,iamp,p3/2,0
  ares1     reson     ga1,ires1,ibw1,1
  ares2     reson     ga1,ires2,ibw2,1
  ares3     reson     ga1,ires3,ibw3,1
  ares4     reson     ga2,ires4,ibw4,1
  ares5     reson     ga2,ires5,ibw5,1
  ares6     reson     ga2,ires6,ibw6,1
  aleft     =  ares1+ares5+ares5
  aright    =  ares2+ares4+ares6
            outs      aleft*kenv, aright*kenv
endin
