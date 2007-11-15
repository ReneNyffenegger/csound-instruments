  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2
;i1 0 dur file1 skip1  file2 skip2 func#_chan1 func#_chan2 ; raw read
;raw readin
instr 1
  ifile1    =  p4
  iskip1    =  p5
  ifile2    =  p6
  iskip2    =  p7

  ifunc1    =  p8
  ifunc2    =  p9
  iamp      =  p10

  iatk      =  .01
  idk       =  .01
  isust     =  p3-(iatk+idk)
  a1left, a1right     soundin                     ifile1,iskip1
  a2left, a2right     soundin                     ifile2,iskip2
        
  ach1      oscili    1.0, 1/p3, ifunc1
  ach2      oscili    1.0, 1/p3, ifunc2
  ach1a     =  1.0 - ach1
  ach2a     =  1.0 - ach2
        
  aleft     =  (a1left*ach1)+(a2left*ach1a)
  aright    =  (a1right*ach2)+(a2right*ach2a)
  aenv      linseg    0,iatk,1,isust,1,idk,0
            outs      aenv*aleft, aenv*aright
endin
