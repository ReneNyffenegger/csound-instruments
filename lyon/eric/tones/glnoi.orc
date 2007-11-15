  sr        =  44100
  kr        =  4410
  ksmps     =  10
; double resonated noise


;i1 0 dur res1 res1a res2 amp seed
instr 1
  ires1     =  p4
  ires1a    =  p5
  ires2     =  p6
  ibf       =  .5
  iamp      =  p7*32767 * 5
  iseed     =  p8
  ibw       =  p4*ibf
  kenv      linseg    0,p3/2,iamp,p3/2,0
  anoise    randi     1.0, 13000, iseed
  kres1     linseg    ires1, p3, ires1a
  kbw       =  kres1 * ibf
  ares      reson     anoise,ires1,ibw,1
  aresmove  reson     anoise,kres1,kbw,1
  aresmix   =  ares + aresmove
  ares1     reson     aresmix,ires2,ibw,1
            out       ares1*kenv
endin

;i1 0 dur res1 amp seed
instr 2
  ires1     =  p4
  ibf       =  .05
  iamp      =  p5*32767 * 2.5
  iseed     =  p6
  ibw       =  p4*ibf
  kenv      linseg    0,p3/2,iamp,p3/2,0
  anoise    randi     1.0, 13000, iseed
  ares1     reson     anoise,ires1,ibw,1
  ares2     reson     ares1,ires1,ibw,1
            out       ares2*kenv
endin

