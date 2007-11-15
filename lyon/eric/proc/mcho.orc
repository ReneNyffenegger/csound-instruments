  sr        =  44100
  kr        =  4410
  ksmps     =  10
;1in 1out choruser
;i1 0 dur file skip depth speed1 sp2 sp3 sp4 phs1 phs2 phs3 phs4 
;gain

instr 1;        chorus  
  idepth    =  p6
  imax      =  p6 * 2
  id2       =  (idepth/2)*.3
  ispeed1   =  p7
  ispeed2   =  p8
  ispeed3   =  p9
  ispeed4   =  p10
  iphs1     =  p11
  iphs2     =  p12
  iphs3     =  p13
  iphs4     =  p14
  igain     =  p15

  a1        soundin   p4, p5
  a1        =  a1 * igain
  kfr1      oscil     id2,ispeed1, 1, iphs1
  kfr1      =  kfr1 + idepth
  kfr2      oscil     id2,ispeed2, 1, iphs2
  kfr2      =  kfr2 + idepth
  kfr3      oscil     id2,ispeed3, 1, iphs3
  kfr3      =  kfr3 + idepth
  kfr4      oscil     id2,ispeed4, 1, iphs4
  kfr4      =  kfr4 + idepth

  adel1     delayr    imax 
  acho1     deltapi   kfr1
  acho2     deltapi   kfr2
  acho3     deltapi   kfr3
  acho4     deltapi   kfr4
            delayw    a1


  amix      =  acho1+acho2+acho3+acho4
  aout      atone     amix, 35
        
            out       aout

endin
instr 100
endin
