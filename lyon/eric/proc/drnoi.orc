  sr        =  44100
  kr        =  4410
  ksmps     =  10
; double resonated soundfile


instr 1
  gasrc     soundin   p4,p5
        ;gasrc randi 25000., 20000, .666 
endin
;i1 0 dur file skip
;i2 0 dur res1 res2 amp seed
instr 2
  ires1     =  p4
  ires2     =  p5
  ibf       =  .02
;ibf = .9
  iamp      =  p6* 5
;iamp = p6 *.5
  iseed     =  p7
  ibw       =  p4*ibf
  kenv      linseg    0,p3/2,iamp,p3/2,0
  ares      reson     gasrc,ires1,ibw,1
  ares1     reson     ares,ires2,ibw,1
            out       ares1*kenv
endin
