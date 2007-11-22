  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

instr          1                   ; MONO INPUT
  iorig     =  .05
  irev      =  1.-iorig
  igain     =  1.0
  ilpgain   =  1.5
  icgain    =  .1
  ialpgain  =  0.1
  ifile     =  p4
  iskip     =  p5
  ispeed1   =  p6
  ispeed2   =  p7
  ispeed3   =  p8
  ispeed4   =  p9
  idel1     =  p10
  idel2     =  p11
  idel3     =  p12
  idel4     =  p13
  icf1      =  p14
  icf2      =  p15
  icf3      =  p16
  icf4      =  p17
  ifac      =  2
  ibw1      =  icf1/ifac
  ibw2      =  icf2/ifac
  ibw3      =  icf3/ifac
  ibw4      =  icf4/ifac
  aenv1     oscil     igain, ispeed1, 1
  aenv2     oscil     igain, ispeed2, 2
  aenv3     oscil     igain, ispeed3, 3
  aenv4     oscil     igain, ispeed4, 4
  araw      soundin   p4,p5
  ares1     reson     araw,icf1,ibw1,1
  ares2     reson     araw,icf2,ibw2,1
  ares3     reson     araw,icf3,ibw3,1
  ares4     reson     araw,icf4,ibw4,1
  adel1     delay     ares1,idel1
  adel2     delay     ares2,idel2
  adel3     delay     ares3,idel3
  adel4     delay     ares4,idel4
  asum      =  (ares1*aenv1)+(ares2*aenv2)+(ares3*aenv3)+(ares4*aenv4)
  alp       tone      asum,1000
  adright   delay     alp,.178
  adleft    delay     alp,.215
  asumr     =  asum+(adright*ilpgain)
  asuml     =  asum+(adleft*ilpgain)
  acr1      comb      asumr,2,.063
  acr2      comb      acr1+asumr,.5,.026
  acl1      comb      asuml,2,.059
  acl2      comb      acl1+asuml,.5,.031
  acsumr    =  asumr+(acr2*icgain)
  acsuml    =  asuml+(acl2*icgain)
  alpo      alpass    asum,3,.085
  alpol     comb      alpo, 2.8, .526 
  alpor     comb      alpo, 2.8, .746 
  alol      tone      alpol,500
  alor      tone      alpor,500
  alold     delay     alol,.095
  alord     delay     alor,.11
  arevl     =  (alpol*ialpgain)+acsuml+alold
  arevr     =  (alpor*ialpgain)+acsumr+alord
  aorig     =  araw*iorig
            outs      (arevl*irev)+aorig,(arevr*irev)+aorig

endin

;STEREO INPUT
instr          2
  iorig     =  .05
  irev      =  1.-iorig
  igain     =  1.0
  ilpgain   =  1.5
  icgain    =  .1
  ialpgain  =  0.1
  ifile     =  p4
  iskip     =  p5
  ispeed1   =  p6
  ispeed2   =  p7
  ispeed3   =  p8
  ispeed4   =  p9
  idel1     =  p10
  idel2     =  p11
  idel3     =  p12
  idel4     =  p13
  icf1      =  p14
  icf2      =  p15
  icf3      =  p16
  icf4      =  p17
  ifac      =  2
  ibw1      =  icf1/ifac
  ibw2      =  icf2/ifac
  ibw3      =  icf3/ifac
  ibw4      =  icf4/ifac
  aenv1     oscil     igain, ispeed1, 1
  aenv2     oscil     igain, ispeed2, 2
  aenv3     oscil     igain, ispeed3, 3
  aenv4     oscil     igain, ispeed4, 4
  ain1,ain2 soundin   p4,p5
  ares1     reson     ain1,icf1,ibw1,1
  ares2     reson     ain2,icf2,ibw2,1
  ares3     reson     ain1,icf3,ibw3,1
  ares4     reson     ain2,icf4,ibw4,1
  adel1     delay     ares1,idel1
  adel2     delay     ares2,idel2
  adel3     delay     ares3,idel3
  adel4     delay     ares4,idel4
  asum1     =  (ares1*aenv1)+(ares3*aenv3)
  asum2     =  (ares2*aenv2)+(ares4*aenv4)
  alp1      tone      asum1,1000
  alp2      tone      asum2,1000
  adright   delay     alp1,.178
  adleft    delay     alp2,.215
  asumr     =  asum1+(adright*ilpgain)
  asuml     =  asum2+(adleft*ilpgain)
  acr1      comb      asumr,2,.063
  acr2      comb      acr1+asumr,.5,.026
  acl1      comb      asuml,2,.059
  acl2      comb      acl1+asuml,.5,.031
  acsumr    =  asumr+(acr2*icgain)
  acsuml    =  asuml+(acl2*icgain)
  alpo1     alpass    asum1,3,.085
  alpo2     alpass    asum2,3,.085
  alpol     comb      alpo1, 2.8, .526 
  alpor     comb      alpo2, 2.8, .746 
  alol      tone      alpol,500
  alor      tone      alpor,500
  alold     delay     alol,.095
  alord     delay     alor,.11
  arevl     =  (alpol*ialpgain)+acsuml+alold
  arevr     =  (alpor*ialpgain)+acsumr+alord
  aorig1    =  ain1*iorig
  aorig2    =  ain2*iorig
            outs      (arevl*irev)+aorig1,(arevr*irev)+aorig2

endin
