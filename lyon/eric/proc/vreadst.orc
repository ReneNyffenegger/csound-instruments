  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  2

;i1 0 dur file skip depth1 speed1 depth2 speed2 seed1 seed2 feedback
instr 1
  ifile     =  p4
  iskip     =  p5
  idepth1   =  p6
  ispeed1   =  p7
  idepth2   =  p8
  ispeed2   =  p9
  iseed1    =  p10
  iseed2    =  p11
  ifeedback =  p12
  imax1     =  idepth1*2.01
  imax2     =  idepth2 * 2.01
  idd1      =  idepth1/2.
  iddd1     =  idd1 * .95
  idd2      =  idepth2/2.
  iddd2     =  idd2* .95
  iportfac  =  .5
  a1,a2     soundin   ifile,iskip

  kdull1    randh     iddd1, ispeed1, iseed1
  kdel1     port      kdull1, iportfac
        
  kdel1     =  kdel1 + idd1

  kdull2    randh     iddd2, ispeed2, iseed2
  kdel2     port      kdull2, iportfac
  kdel2     =  kdel2 + idd2

  adump1    delayr    imax1
  atap1     deltapi   kdel1
  a1        =  a1 + (ifeedback*atap1)
            delayw    a1
  adump2    delayr    imax2
  atap2     deltapi   kdel2
  a2        =  a2 + (ifeedback*atap2)
            delayw    a2
            outs      atap1,atap2
endin
; MONO INPUT
;i2 0 dur file skip depth1 speed1 depth2 speed2 seed1 seed2 feedback
instr 2
  ifile     =  p4
  iskip     =  p5
  idepth1   =  p6
  ispeed1   =  p7
  idepth2   =  p8
  ispeed2   =  p9
  iseed1    =  p10
  iseed2    =  p11
  ifeedback =  p12/2.0
  imax1     =  idepth1*2.01
  imax2     =  idepth2 * 2.01
  idd1      =  idepth1/2.
  iddd1     =  idd1 * .95
  idd2      =  idepth2/2.
  iddd2     =  idd2* .95
  iportfac  =  .5
  a1        soundin   ifile,iskip

  kdull1    randh     iddd1, ispeed1, iseed1
  kdel1     port      kdull1, iportfac
        
  kdel1     =  kdel1 + idd1

  kdull2    randh     iddd2, ispeed2, iseed2
  kdel2     port      kdull2, iportfac
  kdel2     =  kdel2 + idd2

  adump1    delayr    imax1
  atap1     deltapi   kdel1
  atap2     deltapi   kdel2
  a1        =  a1 + (ifeedback*atap1)+(ifeedback*atap2)
            delayw    a1
            outs      atap1,atap2
endin
