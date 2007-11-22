  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

;gen4 -L2K 0 0 3 .1 1 -3 .2 .4 -3 1 0 >/snd/eric/soundin.50
;gen4 -L2K 0 0 -3 .05 1 -3 .15 .25 -3 .6 0 0 1.0 0 >/snd/eric/soundin.51
;gen4 -L2K 0 0 3 .2 1 -3 .45 .5 -4 .5 0 0 1 0 >/snd/eric/soundin.52
;gen4 -L2K 0 0 -3 .7 1 -3 1 0 >/snd/eric/soundin.53
;f1 0 2048 -1 50 0
;f2 0 2048 -1 51 0
;f3 0 2048 -1 52 0
;f4 0 2048 -1 53 0
;i1 0 dur file skip
instr          1
  iorig     =  .05
  irev      =  1.-iorig
  igain     =  1.0
  ilpgain   =  1.5
  icgain    =  .1
  ialpgain  =  0.1
  ifile     =  p4
  iskip     =  p5
  ispeed1   =  .4
  ispeed2   =  .67
  ispeed3   =  1.4
  ispeed4   =  .88
  idel1     =  .037
  idel2     =  .086
  idel3     =  .117
  idel4     =  .148
  icf1      =  3000
  icf2      =  1000
  icf3      =  250
  icf4      =  50
  ifac      =  2
  ibw1      =  icf1/ifac
  ibw2      =  icf2/ifac
  ibw3      =  icf3/ifac
  ibw4      =  icf4/ifac
  ifag      =  .25
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
