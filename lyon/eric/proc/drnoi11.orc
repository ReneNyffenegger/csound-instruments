  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

; stereo in -> stereo out
instr 1
  ga1,ga2   soundin   p4,p5
endin
;i1 0 dur file skip
;i2 0 dur res amp bandfac pos
instr 2
  ires1     =  p4
  ires2     =  p5
  ilpt1     =  1.0/ires1
  ilpt2     =  1.0/ires2
  iamp      =  p6 * .1
  irvt      =  p7
  ibf       =  p8

  ibw       =  ires1*ibf 

  kenv      linseg    0,p3/4,iamp,p3/2,iamp,p3/4,0
  acomb1    comb      ga1, irvt, ilpt1
  acomb2    comb      ga2, irvt, ilpt2
  ares1     reson     acomb1, ires1, ibw, 1
  ares2     reson     acomb2, ires2, ibw, 1
            outs      ares1*kenv,ares2*kenv
endin
