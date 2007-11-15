  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2


instr 1
  ga1,ga2   soundin   p4,p5
endin
;i1 0 dur file skip
;i2 0 dur res1 res2 amp seed
instr 2
  ires1     =  p4
  ires2     =  p5
  ires3     =  ires1*2.
  ires4     =  ires2*2.
  ibf       =  .02
  iamp      =  p6* 100
  iseed     =  p7
  ibw1      =  p4*ibf
  ibw2      =  ibw1*2.
  kenv      linseg    0,p3/2,iamp,p3/2,0
  ares1a    reson     ga1,ires1,ibw1,1
  ares1     reson     ares1a,ires4,ibw2,1
  ares2a    reson     ga2,ires2,ibw1,1
  ares2     reson     ares2a,ires3,ibw2,1
            outs      ares1*kenv,ares2*kenv
endin
