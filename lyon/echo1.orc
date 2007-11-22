  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

  gilp1     =  1/10
  gilp2     =  1/23
  gilp3     =  1/41


instr 1
  iroll     =  600
  igain     =  p5
  iecho     =  p4
  isp1      =  .237
  isp2      =  .1892
  idev      =  .005
  ibase     =  idev*2.0
  idk       =  .015

  aclean    linseg    1,p3-idk,1,idk,0
  ain1      soundin   p6,p7
  ain1      =  ain1 * igain
  alop      tone      ain1, iroll
  adel      delay     ain1, iecho
  amix      =  alop+adel
  adel1     oscili    idev, isp1, 1
  adel2     oscili    idev, isp2, 1
  adel1     =  adel1 + ibase
  adel2     =  adel2 + ibase
  addl1     delayr    .5
  atap1     deltapi   adel1
  atap2     deltapi   adel2
            delayw    amix
  amid      =  amix * .7
  aleft     =  atap1 + amid
  aright    =  atap2 + amid
            outs      aleft*aclean, aright*aclean
endin
