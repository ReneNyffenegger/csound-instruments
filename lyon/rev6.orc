  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

;i1 0 8 1 .4 2.2 35 36 37.173 39.766 1.1 .077 .0631 .85 .15
;1 in 2 out ambient
;i1 0 dur file skip rvt1 res1 res2 res3 res4
;echo_rvt echolpt1 echolpt2 iorig iecho

instr          1
  igain     =  p16
  ifile     =  p4
  iskip     =  p5
  irvt1     =  p6                                 ; AUDIO COMB REVERB LENGTH
  ilpt1     =  1/p7                               ; AUDIO COMB RESONANCES
  ilpt2     =  1/p8
  ilpt3     =  1/p9
  ilpt4     =  1/p10
  iechot    =  p11                                ;ECHO LENGTH
  ilpt5     =  p12                                ; ECHO LOOPTIMES
  ilpt6     =  p13
  iorig     =  p14
  iecho     =  p15
  irev      =  1.-iorig
  ialpt     =  0.07
  ijuice    =  .6
  iroll     =  2000
  ipres     =  5000
  ipbw      =  1000
  iatk      =  0.01
  idk       =  .05
  isust     =  p3-(iatk+idk)
  aenv      linseg    0,iatk,igain,isust,igain,idk,0
  araw      soundin   ifile,iskip
  acmb1     comb      araw,irvt1,ilpt1
  acmb2     comb      araw,irvt1,ilpt2
  acmb3     comb      araw,irvt1,ilpt3
  acmb4     comb      araw,irvt1,ilpt4
  acmbmix1  =  acmb1+acmb2*.5+acmb3*.25+acmb4*.125
  acmbmix2  =  acmb4+acmb3*.5+acmb2*.25+acmb1*.125
  aecho1    comb      acmbmix1,ilpt5,iechot
  aecho2    comb      acmbmix2,ilpt5,iechot
  aecmix1   =  (acmbmix1*ijuice)+(aecho1*iecho)
  aecmix2   =  (acmbmix2*ijuice)+(aecho2*iecho)
  alp1      alpass    aecmix2,ialpt,.06
  alp2      alpass    aecmix1,ialpt,.063
  apres1    reson     alp1,ipres,ipbw,1
  apres2    reson     alp2,ipres,ipbw,1
  arevraw1  =  aecmix1+alp1
  arevraw2  =  aecmix2+alp2
  alpf1     tone      arevraw1,iroll
  alpf2     tone      arevraw2,iroll
  ao        =  araw*iorig
  aout1     =  ao+(alpf1+apres1)*irev
  aout2     =  ao+(alpf2+apres2)*irev
            outs      aout1*aenv,aout2*aenv
endin
