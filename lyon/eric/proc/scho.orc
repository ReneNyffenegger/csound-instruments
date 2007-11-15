  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2
;2in 2out choruser
;i1 0 dur file skip depth speed1 sp2 sp3 sp4 phs1 phs2 phs3 phs4 
;gain
  gieffect  =  .2                                 ; value for depth of effect

instr 1;        chorus  
  idepth    =  p6                                 ; depth of vibrato
  imax      =  p6 * 2
  id2       =  (idepth/2)*gieffect
  ispeed1   =  p7/4
  ispeed2   =  p8/4
  ispeed3   =  p9/4
  ispeed4   =  p10/4
  iphs1     =  p11
  iphs2     =  p12
  iphs3     =  p13
  iphs4     =  p14
  igain     =  p15

  a1,a2     soundin   p4, p5
  a1        =  a1 * igain
  a2        =  a2 * igain
  kfr1      oscil     id2,ispeed1, 1, iphs1
  kfr1      =  kfr1 + idepth
  adel1     delayr    imax 
  acho1     deltapi   kfr1
            delayw    a1

  kfr2      oscil     id2,ispeed2, 1, iphs2
  kfr2      =  kfr2 + idepth
  adel2     delayr    imax 
  acho2     deltapi   kfr2
            delayw    a1

  amix1     =  a1+acho1+acho2

  kfr3      oscil     id2,ispeed3, 1, iphs3
  kfr3      =  kfr3 + idepth
  adel3     delayr    imax 
  acho3     deltapi   kfr3
            delayw    a2

  kfr4      oscil     id2,ispeed4, 1, iphs4
  kfr4      =  kfr4 + idepth
  adel4     delayr    imax 
  acho4     deltapi   kfr4
            delayw    a2

  amix2     =  a2+acho3+acho4


        ;afinmix1 = amix1 * igain
        ;afinmix2 = amix2 * igain
  aout1     atone     amix1, 45
  aout2     atone     amix2, 45
            outs      aout1, aout2

                ;outs (amix1*igain),(amix2*igain);  all process  
endin
instr 100
endin
