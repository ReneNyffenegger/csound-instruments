  sr        =  44100
  kr        =  44100
  ksmps     =  1
  nchnls    =  2
;2in 2out choruser
;f1 0 8192 10 1
;f2 0 8192 -1 50 0 ;for instr 2 only
;i1 0 dur file skip depth speed1 speed2
;i2 0 dur file skip speed1 speed2

instr 1;        chorus  
  idepth    =  p6
  imax      =  idepth*2.5
  id2       =  (idepth/2)*.95
;ispeed1 = 2.188/2.0
;ispeed2 = 1.57/2.0
  ispeed1   =  p7/2.
  ispeed2   =  p8/2.
  iphs1     =  .1
  iphs2     =  .666
  igain     =  1.0

  a1,a2     soundin   p4, p5
  afr1      oscil     id2,ispeed1, 1, iphs1
  afr1      =  afr1 + idepth
  adel1     delayr    imax 
  acho1     deltapi   afr1
            delayw    a1

  afr2      oscil     id2,ispeed2, 1, iphs2
  afr2      =  afr2 + idepth
  adel2     delayr    imax 
  acho2     deltapi   afr2
            delayw    a2

            outs      acho1,acho2
endin

instr 2;        function control        
  idur      =  1/p3
  imax      =  1.0
  ispeed1   =  p6/2.
  ispeed2   =  p7/2.
  iphs1     =  .1
  iphs2     =  .666
  igain     =  1.0

  a1,a2     soundin   p4, p5
  adepth    oscili    1.0, idur, 2
  ad2       =  (adepth/2.0)*.49

  afr1      oscil     ad2,ispeed1, 1, iphs1
  afr1      =  afr1 + adepth
  afr2      oscil     ad2,ispeed2, 1, iphs2
  afr2      =  afr2 + adepth

  adel1     delayr    imax 
  acho1     deltapi   afr1
            delayw    a1
  adel2     delayr    imax 
  acho2     deltapi   afr2
            delayw    a2

            outs      acho1,acho2
endin
instr 100
endin
