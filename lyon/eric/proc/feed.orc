#include "head"
instr 99
  garead    =  0
endin
;i2 0 dur file skip gain seed seed
;i1 0 dur file skip gain
;i2 0 dur seed1 seed2 feedback
instr 2
  igain     =  p6
  iatk      =  .02
  idk       =  .02
  isust     =  p3-(iatk+idk)
  kenv      linseg    0,iatk,igain,isust,igain,idk,0
  aread     soundin   p4,p5
  garead    =  aread*kenv
endin
instr 1
  iseed1    =  p4
  iseed2    =  p5
  imax1     =  .05
  id1       =  imax1*.9
  idd1      =  id1/2
  iddd1     =  idd1*.45
  ispeed1   =  2.7
  imax2     =  .1
  id2       =  imax2*.9
  idd2      =  id2/2
  iddd2     =  idd2*.45
  ispeed2   =  1.7
  ifeed     =  p6
  asrc      =  garead
  adelay    randi     iddd1,ispeed1,iseed1
  adelay    =  adelay+idd1
  addl1     delayr    imax1
  atap      deltapi   adelay
  asrc      =  asrc + (atap*ifeed)
            delayw    asrc
  asrc2     =  asrc
  adelay2   randi     iddd2,ispeed2,iseed2
  adelay2   =  adelay+idd2
  addl2     delayr    imax2
  atap2     deltapi   adelay
  asrc2     =  asrc2 + (atap2*ifeed)
            delayw    asrc2
            out       atap2
endin
instr 100
endin
