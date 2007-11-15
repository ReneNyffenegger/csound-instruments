  sr        =  44100
  kr        =  4410
  ksmps     =  10
; filter sweeps


instr 1
  gasrc     soundin   p4,p5
endin
;f1 0 8192 9 1 .5 270 0 .5 270
;i1 0 dur file skip
;i2 0 dur bw amp lofreq hifreq speed phase
instr 2
  iatk      =  .01
  idk       =  .05
  isust     =  p3 -(iatk+idk)
  ircos     =  1
  ibf       =  p4
  iamp      =  p5
  imin      =  p6
  imax      =  p7
  ispeed    =  p8
  iphase    =  p9

  aenv      linseg    0,iatk,iamp,isust,iamp,idk,0
  kres      oscili    .5, ispeed, ircos, iphase
  kres      =  kres + .5
  kres      =  (kres * (imax-imin))+imin
  kres      =  cpsoct( kres )
  kbw       =  kres * ibf
  ares      reson     gasrc,kres,kbw,1
            out       ares*aenv
endin
instr 3 ; weird failed used of pitch conversion
  iatk      =  .01
  idk       =  .05
  isust     =  p3 -(iatk+idk)
  ircos     =  1
  ibf       =  p4
  iamp      =  p5
  imin      =  p6
  imax      =  p7
  ispeed    =  p8
  iphase    =  p9

  aenv      linseg    0,iatk,iamp,isust,iamp,idk,0
  kres      oscili    .5, ispeed, ircos, iphase
  kres      =  kres + .5
  kres      =  (kres * (imax-imin))+imin
  kres      =  cpspch( kres )
  kbw       =  kres * ibf
  ares      reson     gasrc,kres,kbw,1
            out       ares*aenv
endin
