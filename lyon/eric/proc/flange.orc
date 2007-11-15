  sr        =  44100
  kr        =  22050
  ksmps     =  2

instr 100
endin
;i3 0 dur file skip maxfreq minfreq gain speed seed

instr 1 ; simple flange
;file skip delay1 delay2
  idstart   =  p6
  idend     =  p7
  igain     =  p8
  idmax     =  idstart+idend
  araw      soundin   p4,p5
  kdel      line      idstart,p3,idend
  adline    delayr    idmax
  atap1     deltapi   kdel
            delayw    araw
  asum      =  (araw+atap1)*igain
            out       asum
endin

instr 2 ; double flange
;file skip delay1 delay2
;i2 0 dur file skip delay1 delay2
  igain     =  .7
  idstart   =  p6
  idend     =  p7
  idmax     =  idstart+idend
  araw      soundin   p4,p5
  kdel      line      idstart,p3,idend
  adline1   delayr    idmax
  atap1     deltapi   kdel
            delayw    araw
  asum1     =  atap1+araw
  adline2   delayr    idmax
  atap2     deltapi   kdel
            delayw    asum1
  asum      =  (araw+atap2)*igain
            out       asum
endin
instr 3 ; random flange
  idmin     =  1./p7
  idmax     =  1./p6
  iddif     =  ((idmax-idmin)/2)*.95
  igain     =  p8
  ispeed    =  p9
  iseed     =  p10
  idmax     =  idmax*2
  araw      soundin   p4,p5
  kdel      randi     iddif,ispeed,iseed
  kdel      =  kdel+iddif+idmin
  adline    delayr    idmax
  atap1     deltapi   kdel
            delayw    araw
  asum      =  (araw+atap1)*igain
            out       asum
endin

instr 4 ; big flange
;i4 0 dur file skip maxdel1 speed1 seed1
  ibase1    =  (p5/2)
  ibase2    =  ibase1
  idev1     =  (ibase1/2)*.95
  idev2     =  idev1
  isp1      =  p6
  isp2      =  isp1
  iseed1    =  p7
  iseed2    =  .123
  imax1     =  .5

  araw      soundin   p4,p5
  kdel1     randi     idev1,isp1,iseed1
  kdel1     =  kdel1 + ibase1
  kdel2     randi     idev2,isp2,iseed2
  kdel2     =  kdel2 + ibase2
  addl1     delayr    imax1
  atap1     deltapi   kdel1
  atap2     deltapi   kdel2
            delayw    araw
  asum1     =  araw+atap1
  asum2     =  araw+atap2
            out       asum1+asum2
endin

instr 5 ; random flange with feedback
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

instr 6 ; linear flange with feedback
; file skip minres maxres gain speed seed feedback
  idmin     =  1./p7
  idmax     =  1./p6
  iddif     =  ((idmax-idmin)/2)*.95
  igain     =  p8
  ispeed    =  p9
  iseed     =  p10
  ifeed     =  p11
  idmax     =  idmax*2
; variable opcode [parameters]
  araw      soundin   p4,p5
  kdel      line      idmin, p3, idmax
  kdel      =  kdel+iddif+idmin
  adline    delayr    idmax
  atap1     deltapi   kdel
  araw      =  araw + (atap1*ifeed)
            delayw    araw
  asum      =  (araw+atap1)*igain
            out       asum
endin
