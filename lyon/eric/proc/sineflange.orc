  sr        =  44100
  kr        =  4410
  ksmps     =  10


;f1 0 8192 -9 .5 1.0 0 ; 1/2 [0-1]
;f1 0 8192 -9 1 -.5 90  0 .5 90 ; raised cosine
instr 1 ; linear flange with feedback and filter
; file skip minres maxres gain speed bandfac feedback phase
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
  araw      soundin   p4,p5
  kres      oscili    imaxres-iminres, ispeed, 1, iphase
  kres      =  kres + iminres
  kres      =  cpsoct(kres)
  kdel      =  1.0/kres
  kbw       =  kres * ibfac
  adline    delayr    idmax
  atap1     deltapi   kdel
  araw      =  araw + (atap1*ifeed)
            delayw    araw
  asum      =  (araw+atap1)*igain
  ares      reson     asum,kres,kbw,1
            out       ares
endin

instr 2 ; linear flange with feedback no filtering
; file skip minres maxres gain speed bfac feedback phase
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
  araw      soundin   p4,p5
  kres      oscili    imaxres-iminres, ispeed, 1, iphase
  kres      =  kres + iminres
  kres      =  cpsoct(kres)
  kdel      =  1.0/kres
  adline    delayr    idmax
  atap1     deltapi   kdel
  araw      =  araw + (atap1*ifeed)
            delayw    araw
  asum      =  (araw+atap1)*igain
            out       asum
endin
