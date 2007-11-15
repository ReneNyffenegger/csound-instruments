  sr        =  44100
  kr        =  4410
  ksmps     =  10
; double resonated noise

instr 1
endin

;i1 0 dur res1 res2 amp seed
instr 2
  ires1     =  p4
  ires2     =  p5
  ibf       =  .02
  iamp      =  p6*32767 * 5
  iseed     =  p7
  ibw       =  p4*ibf
  kenv      linseg    0,p3/2,iamp,p3/2,0
  anoise    randi     1.0, 13000, iseed
  ares      reson     anoise,ires1,ibw,1
  ares1     reson     ares,ires2,ibw,1
            out       ares1*kenv
endin

