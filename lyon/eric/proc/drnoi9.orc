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
  iamp      =  p6 * 5
  ibf       =  p7 * .02
  ibf2      =  ibf * 10

  ibw       =  ires1*ibf 
  ibw2      =  ires1 * ibf2
  kenv      linseg    0,p3/4,iamp,p3/2,iamp,p3/4,0
  ares1     reson     ga1, ires1, ibw, 1
  ares2     reson     ga2, ires2, ibw, 1
  ares1a    reson     ares1, ires1, ibw2, 1
  ares2a    reson     ares2, ires2, ibw2, 1
            outs      ares1a*kenv,ares2a*kenv
endin
