  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

  gilp1     =  1/10
  gilp2     =  1/23
  gilp3     =  1/41
; f1 0 8192 10 1
; i1 0 dur echotime gain file skip
instr          1
  iroll     =  600
  igain     =  p5
  iecho     =  p4
  isp1      =  .237
  isp2      =  .1892
  idev      =  .005
  ibase     =  idev*2.0
  idk       =  .015

  aclean    linseg    1,p3-idk,1,idk,0
  ain1,ain2 soundin   p6,p7
  ain1      =  ain1 * igain
  ain2      =  ain2 * igain
  alop1     tone      ain1, iroll
  alop2     tone      ain2, iroll
  adel1     delay     ain1, iecho
  adel2     delay     ain2, iecho
  amix1     =  alop1+adel1
  amix2     =  alop2+adel2
  adel1     oscili    idev, isp1, 1
  adel2     oscili    idev, isp2, 1
  adel1     =  adel1 + ibase
  adel2     =  adel2 + ibase
  addl1     delayr    .5
  atap1     deltapi   adel1
            delayw    amix1
  addl2     delayr    .5
  atap2     deltapi   adel2
            delayw    amix2

  aleft     =  atap1 + amix1
  aright    =  atap2 + amix2
            outs      aleft*aclean, aright*aclean
endin
