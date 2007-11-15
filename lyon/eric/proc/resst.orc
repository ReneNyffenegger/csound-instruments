  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2
;i1 0 dur file skip
;i2 0 dur gain cf1 bw1 cf2 bw2; cf1 = left chnl
instr 1
  ga1,ga2   soundin   p4,p5
endin
instr 3
  ga1       soundin   p4,p5
endin

instr 2
  iamp      =  p4
  icf1      =  p5
  ibw1      =  p6*p5
  icf2      =  p7
  ibw2      =  p8*p7
  iatk      =  .03
  idk       =  .03
  isust     =  p3-(iatk+idk)
  kenv      linseg    0,iatk,iamp,isust,iamp,idk,0
  a1        reson     ga1,icf1,ibw1,1
  a2        reson     ga2,icf2,ibw2,1
            outs      a1*kenv,a2*kenv
endin

instr 4
  iamp      =  p4
  icf1      =  p5
  ibw1      =  p6*p5
  icf2      =  p7
  ibw2      =  p8*p7
  iatk      =  .03
  idk       =  .03
  isust     =  p3-(iatk+idk)
  kenv      linseg    0,iatk,iamp,isust,iamp,idk,0
  a1        reson     ga1,icf1,ibw1,1
  a2        reson     ga1,icf2,ibw2,1
            outs      a1*kenv,a2*kenv
endin

;p4 = filenumber p5 = skip p6 = reson point p7 = gain
