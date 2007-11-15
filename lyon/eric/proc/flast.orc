  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2
  gipio2    =  1.570796

instr 1 ; big flange
;i1 0 dur file skip maxdel1 speed1 seed1
  igain     =  .2
  imax      =  .5
  il3       =  cos( gipio2 * .333 )*igain
  ir3       =  sin( gipio2 * .333 )*igain
  il4       =  cos( gipio2 * .9 )*igain
  ir4       =  sin( gipio2 * .9 )*igain
  il5       =  cos( gipio2 * .666 )*igain
  ir5       =  sin( gipio2 * .666 )*igain
  il6       =  cos( gipio2 * .1 )*igain
  ir6       =  sin( gipio2 * .1 )*igain
  ibase1    =  (p5/2)
  idev1     =  (ibase1/2)*.95
  isp1      =  p6
  iseed1    =  p7
  ibase2    =  (p8/2)
  idev2     =  (ibase2/2)*.95
  isp2      =  p9
  iseed2    =  p10
  ibase3    =  (p11/2)
  idev3     =  (ibase3/2)*.95
  isp3      =  p12
  iseed3    =  p13
  ibase4    =  (p14/2)
  idev4     =  (ibase4/2)*.95
  isp4      =  p15
  iseed4    =  p16
  ibase5    =  (p17/2)
  idev5     =  (ibase5/2)*.95
  isp5      =  p18
  iseed5    =  p19
  ibase6    =  (p20/2)
  idev6     =  (ibase6/2)*.95
  isp6      =  p21
  iseed6    =  p22
  araw      soundin   p4,0
  kdel1     randi     idev1,isp1,iseed1
  kdel1     =  kdel1 + ibase1
  kdel2     randi     idev2,isp2,iseed2
  kdel2     =  kdel2 + ibase2
  addl1     delayr    imax
  atap1     deltapi   kdel1
  atap2     deltapi   kdel2
            delayw    araw
  asum1     =  araw+atap1
  asum2     =  araw+atap2
        
  kdel3     randi     idev3,isp3,iseed3
  kdel3     =  kdel3 + ibase3
  kdel4     randi     idev4,isp4,iseed4
  kdel4     =  kdel4 + ibase4

  addl2     delayr    imax
  atap3     deltapi   kdel3
  atap4     deltapi   kdel4
            delayw    asum1
  kdel5     randi     idev5,isp5,iseed5
  kdel5     =  kdel5 + ibase5
  kdel6     randi     idev6,isp6,iseed6
  kdel6     =  kdel6 + ibase6

  addl3     delayr    imax
  atap5     deltapi   kdel5
  atap6     deltapi   kdel6
            delayw    asum2
  aleft     =  (atap3*il3)+(atap4*il4)+(atap5*il5)+(atap6*il6)
  aright    =  (atap3*ir3)+(atap4*ir4)+(atap5*ir5)+(atap6*ir6)
            outs      aleft, aright
endin

instr 2 ; too far gone flange
  igain     =  .1
  imax      =  .5
  il1       =  cos( gipio2 * .7 )*igain
  ir1       =  sin( gipio2 * .7 )*igain
  il2       =  cos( gipio2 * .6 )*igain
  ir2       =  sin( gipio2 * .6 )*igain
  il3       =  cos( gipio2 * .8 )*igain
  ir3       =  sin( gipio2 * .8 )*igain
  il4       =  cos( gipio2 * .1 )*igain
  ir4       =  sin( gipio2 * .1 )*igain
  il5       =  cos( gipio2 * .9 )*igain
  ir5       =  sin( gipio2 * .9 )*igain
  il6       =  cos( gipio2 * .2 )*igain
  ir6       =  sin( gipio2 * .2 )*igain
  il7       =  cos( gipio2 * .4 )*igain
  ir7       =  sin( gipio2 * .4 )*igain
  il8       =  cos( gipio2 * .3 )*igain
  ir8       =  sin( gipio2 * .3 )*igain
  ibase1    =  (p5/2)
  idev1     =  (ibase1/2)*.95
  isp1      =  p6
  iseed1    =  p7
  ibase2    =  (p8/2)
  idev2     =  (ibase2/2)*.95
  isp2      =  p9
  iseed2    =  p10
  ibase3    =  (p11/2)
  idev3     =  (ibase3/2)*.95
  isp3      =  p12
  iseed3    =  p13
  ibase4    =  (p14/2)
  idev4     =  (ibase4/2)*.95
  isp4      =  p15
  iseed4    =  p16
  ibase5    =  (p17/2)
  idev5     =  (ibase5/2)*.95
  isp5      =  p18
  iseed5    =  p19
  ibase6    =  (p20/2)
  idev6     =  (ibase6/2)*.95
  isp6      =  p21
  iseed6    =  p22
  ibase7    =  (p23/2)
  idev7     =  (ibase7/2)*.95
  isp7      =  p24
  iseed7    =  p25
  ibase8    =  (p26/2)
  idev8     =  (ibase8/2)*.95
  isp8      =  p27
  iseed8    =  p28
  ibase9    =  (p29/2)
  idev9     =  (ibase9/2)*.95
  isp9      =  p30
  iseed9    =  p31
  ibase10   =  (p32/2)
  idev10    =  (ibase10/2)*.95
  isp10     =  p33
  iseed10   =  p34
  ibase11   =  (p35/2)
  idev11    =  (ibase11/2)*.95
  isp11     =  p36
  iseed11   =  p37
  ibase12   =  (p38/2)
  idev12    =  (ibase12/2)*.95
  isp12     =  p39
  iseed12   =  p40
  ibase13   =  (p41/2)
  idev13    =  (ibase13/2)*.95
  isp13     =  p42
  iseed13   =  p43
  ibase14   =  (p44/2)
  idev14    =  (ibase14/2)*.95
  isp14     =  p45
  iseed14   =  p46
  araw      soundin   p4,0
  kdel1     randi     idev1,isp1,iseed1
  kdel1     =  kdel1 + ibase1
  kdel2     randi     idev2,isp2,iseed2
  kdel2     =  kdel2 + ibase2

  addl1     delayr    imax
  atap1     deltapi   kdel1
  atap2     deltapi   kdel2
            delayw    araw

  asum1     =  araw+atap1
  asum2     =  araw+atap2
        
  kdel3     randi     idev3,isp3,iseed3
  kdel3     =  kdel3 + ibase3
  kdel4     randi     idev4,isp4,iseed4
  kdel4     =  kdel4 + ibase4

  addl2     delayr    imax
  atap3     deltapi   kdel3
  atap4     deltapi   kdel4
            delayw    asum1
  kdel5     randi     idev5,isp5,iseed5
  kdel5     =  kdel5 + ibase5
  kdel6     randi     idev6,isp6,iseed6
  kdel6     =  kdel6 + ibase6

  addl3     delayr    imax
  atap5     deltapi   kdel5
  atap6     deltapi   kdel6
            delayw    asum2

  asum3     =  asum1+atap3     
  asum4     =  asum1+atap4     
  asum5     =  asum2+atap5
  asum6     =  asum2+atap6

  kdel7     randi     idev7,isp7,iseed7
  kdel7     =  kdel7 + ibase7
  kdel8     randi     idev8,isp8,iseed8
  kdel8     =  kdel8 + ibase8
  addl4     delayr    imax
  atap7     deltapi   kdel7
  atap8     deltapi   kdel8
            delayw    asum3
  asum7     =  asum3+atap7
  asum8     =  asum3+atap8

  kdel9     randi     idev9,isp9,iseed9
  kdel9     =  kdel9 + ibase9
  kdel10    randi     idev10,isp10,iseed10
  kdel10    =  kdel10 + ibase10
  addl5     delayr    imax
  atap9     deltapi   kdel9
  atap10    deltapi   kdel10
            delayw    asum4
  asum9     =  asum4+atap9
  asum10    =  asum4+atap10
        
  kdel11    randi     idev11,isp11,iseed11
  kdel11    =  kdel11 + ibase11
  kdel12    randi     idev12,isp12,iseed12
  kdel12    =  kdel12 + ibase12
  addl6     delayr    imax
  atap11    deltapi   kdel11
  atap12    deltapi   kdel12
            delayw    asum5
  asum11    =  asum5+atap11
  asum12    =  asum5+atap12

  kdel13    randi     idev13,isp13,iseed13
  kdel13    =  kdel13 + ibase13
  kdel14    randi     idev14,isp14,iseed14
  kdel14    =  kdel14 + ibase14
  addl7     delayr    imax
  atap13    deltapi   kdel13
  atap14    deltapi   kdel14
            delayw    asum6
  asum13    =  asum6+atap13
  asum14    =  asum6+atap14
  al1       =  asum1 * il1
  al2       =  asum2 * il2
  al3       =  asum3 * il3
  al4       =  asum4 * il4
  al5       =  asum5 * il5
  al6       =  asum6 * il6
  al7       =  asum7 * il7
  al8       =  asum8 * il8
  ar1       =  asum1 * ir1
  ar2       =  asum2 * ir2
  ar3       =  asum3 * ir3
  ar4       =  asum4 * ir4
  ar5       =  asum5 * ir5
  ar6       =  asum6 * ir6
  ar7       =  asum7 * ir7
  ar8       =  asum8 * ir8
  aleft     =  al1+al2+al3+al4+al5+al6+al7+al8
  aright    =  ar1+ar2+ar3+ar4+ar5+ar6+ar7+ar8
        
            outs      aleft, aright
endin

