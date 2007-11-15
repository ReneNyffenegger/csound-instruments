  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  2

;i1 0 dur file skip depth1 speed1 depth2 speed2 
instr 1
  ifile     =  p4
  iskip     =  p5
  idepth1   =  p6
  ispeed1   =  p7
  idepth2   =  p8
  ispeed2   =  p9
  imax1     =  idepth1*2.01
  imax2     =  idepth2 * 2.01
  idd1      =  idepth1/2.
  iddd1     =  idd1 * .95
  idd2      =  idepth2/2.
  iddd2     =  idd2* .95
  iportfac  =  .5
  a1,a2     soundin   ifile,iskip

  kdull1    oscili    iddd1, ispeed1, 1
  kdel1     =  kdull1 + idd1

  kdull2    oscili    iddd2, ispeed2, 1
  kdel2     =  kdull2 + idd2

  adump1    delayr    imax1
  atap1     deltapi   kdel1
        ;a1 = a1 + (ifeedback*atap1)
            delayw    a1
  adump2    delayr    imax2
  atap2     deltapi   kdel2
        ;a2 = a2 + (ifeedback*atap2)
            delayw    a2
            outs      atap1,atap2
endin
