  sr        =  44100
  kr        =  44100
  ksmps     =  1

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
  a1        soundin   ifile,iskip

  kdull1    randh     iddd1, ispeed1, iseed1
  kdel1     port      kdull1, iportfac
        
  kdel1     =  kdel1 + idd1


  adump1    delayr    imax1
  atap1     deltapi   kdel1
  a1        =  a1 + (ifeedback*atap1)
            delayw    a1
            out       atap1
endin
