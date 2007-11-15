  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

;f1 0 8192 -9 .5 1.0 0 ; raised cosine [0-1]
;f1 0 8192 -9 1 -.5 90  0 .5 90 ; raised cosine
instr 1 ; linear flange with feedback and filter
; i1 0 dur file skip minres maxres gain speed bandfac feedback phase
; i2 0 dur file skip minres maxres gain speed phase feedback
  iminres   =  p6
  imaxres   =  p7
  idmin     =  1./imaxres
  idmax     =  1./iminres
  iminres   =  octcps(p6)
  imaxres   =  octcps(p7)
  iddif     =  ((idmax-idmin)/2)*.95
  igain     =  p8
  ispeed    =  p9
  ibfac     =  p10
  ifeed     =  p11
  iphase    =  p12
  idmax     =  idmax*2
  araw1, araw2 soundin  p4,p5
  kres      oscili    imaxres-iminres, ispeed, 1, iphase
  kres      =  kres + iminres
  kres      =  cpsoct(kres)
  kdel      =  1.0/kres
  kbw       =  kres * ibfac
  adline1   delayr    idmax
  atap1     deltapi   kdel
  araw1     =  araw1 + (atap1*ifeed)
            delayw    araw1
  asum1     =  (araw1+atap1)*igain
  ares1     reson     asum1,kres,kbw,1
  adline2   delayr    idmax
  atap2     deltapi   kdel
  araw2     =  araw2 + (atap2*ifeed)
            delayw    araw2
  asum2     =  (araw2+atap2)*igain
  ares2     reson     asum2,kres,kbw,1

            outs      ares1, ares2
endin

instr 2 ; linear flange with feedback no filtering
  iminres   =  p6
  imaxres   =  p7
  idmin     =  1./imaxres
  idmax     =  1./iminres
  iminres   =  octcps(p6)
  imaxres   =  octcps(p7)
  iddif     =  ((idmax-idmin)/2)*.95
  igain     =  p8
  ispeed    =  p9
  iphase    =  p10
  ifeed     =  p11
  idmax     =  idmax*2
  araw1, araw2 soundin  p4,p5
  kres      oscili    imaxres-iminres, ispeed, 1, iphase
  kres      =  kres + iminres
  kres      =  cpsoct(kres)
  kdel      =  1.0/kres
  adline1   delayr    idmax
  atap1     deltapi   kdel
  araw1     =  araw1 + (atap1*ifeed)
            delayw    araw1
  asum1     =  (araw1+atap1)*igain
  adline2   delayr    idmax
  atap2     deltapi   kdel
  araw2     =  araw2 + (atap2*ifeed)
            delayw    araw2
  asum2     =  (araw2+atap2)*igain

            outs      asum1, asum2
endin
