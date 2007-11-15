  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2
  gidepthfac   =      .75
;1in 1out choruser
;f1 0 8192 10 1
;i1 0 dur file skip depth speed1 sp2 phs1 phs2 gain 
;gain

instr 1;        chorus  
  idepth    =  p6
  imax      =  p6 * 2
  id2       =  (idepth/2)*gidepthfac
  ispeed1   =  p7/2.0
  ispeed2   =  p8/2.0
  iphs1     =  p9
  iphs2     =  p10
  igain     =  p11
  idk       =  .05                                ;
  isust     =  p3 - idk                           ;

  a1        soundin   p4, p5
  aenv      linseg    igain, isust, igain, idk, .00000001
  kfr1      oscil     id2,ispeed1, 1, iphs1
  kfr1      =  kfr1 + idepth
  kfr2      oscil     id2,ispeed2, 1, iphs2
  kfr2      =  kfr2 + idepth

  adel1     delayr    imax 
  acho1     deltapi   kfr1
  acho2     deltapi   kfr2
            delayw    a1


  amono     =  a1 * .707
  aleft     =  acho1 + amono
  aright    =  acho2 + amono
        
            outs      aleft*aenv, aright*aenv

endin
instr 100
endin
