  sr        =  44100
  kr        =  4410
  ksmps     =  10

instr 1 ; random flange with feedback
; file skip minres maxres gain speed seed feedback
  idmin     =  1./p7
  idmax     =  1./p6
  iddif     =  ((idmax-idmin)/2)*.95
  igain     =  p8
  ispeed    =  p9
  iseed     =  p10
  ifeed     =  p11
  idmax     =  idmax*2
  araw      soundin   p4,p5
  kdel      randi     iddif,ispeed,iseed
  kdel      =  kdel+iddif+idmin
  adline    delayr    idmax
  atap1     deltapi   kdel
  araw      =  araw + (atap1*ifeed)
            delayw    araw
  asum      =  (araw+atap1)*igain
            out       asum
endin
