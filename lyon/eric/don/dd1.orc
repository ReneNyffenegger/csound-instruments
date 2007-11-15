  sr        =  44100
  kr        =  882
  ksmps     =  50

; hybrid orc

; f1 is sine
; f2 is complex wave
; COOL WAVE FORMS
;f2 0 1024 10 1 .3 0 .1 .5 .02
;f2 0 1024 10 1 1 .2 .1
;f2 0 4096 10 1 .5 .2 .5 1 .5 .25 .125 .06 .125 .25 .5 1

; i1 0 dur s1 s2 s3 s4 s5
; i2 0 dur fmult amp s1 s2 s3 s4 sp1 sp2 sp3 sp4

; src1 = d7.orc
instr 100
  gkfr1     =  0
  gasnd2    =  0
  gasig3    =  0

endin
instr 1 ; frequency control func
  iseed1    =  p4
  iseed2    =  p5
  iseed3    =  p6
  iseed4    =  p7
  iseed5    =  p8

  imin1     =  .25                                ; rate of change for freq speed
  imax1     =  2
  ibase1    =  (imax1-imin1)/2.0
  ibase1a   =  ibase1+imin1
  imin2     =  .2                                 ; freq speed change
  imax2     =  10
  ibase2    =  (imax2-imin2)/2.0
  ibase2a   =  ibase2+imin2
  imin3     =  5                                  ; octave boundaries
  imax3     =  11
  ibase3    =  (imax3-imin3)/2.0
  ibase3a   =  ibase3+imin3
  imin4     =  .01                                ; depth of vibrato
  imax4     =  .05
  ibase4    =  (imax4-imin4)/2.0
  ibase4a   =  ibase4+imin4
  imin5     =  2                                  ; vibrato
  imax5     =  6.
  ibase5    =  (imax5-imin5)/2.0
  ibase5a   =  ibase5+imin5

  ksp       randh     ibase1, .2, iseed1
  ksp       =  ksp + ibase1a
  kspc      randh     ibase2, ksp, iseed2
  kspc      =  kspc + ibase2a
  kfr1      randh     ibase3, kspc, iseed3
  kfr1      =  kfr1 + ibase3a                     ; BASIC FREQ INFO
  kfr1      =  cpsoct(kfr1)
  kindex    randi     ibase4, 1., iseed4
  kindex    =  (kindex + ibase4a)*kfr1
  kvs       randi     ibase5, .11, iseed5
  kvs       =  kvs + ibase5a
  kvib      oscil     kindex, kvs, 1
  gkfr1     =  kfr1 + kvib
endin

instr 2 ; 4 OSCILS WITH MICRO PITCH VAR
  ifmult    =  p4
  igain     =  (p5 * 10000.)/4.0
  iatk      =  .1
  idk       =  .1
  isust     =  p3-(iatk+idk)
  idev      =  p4 *.03
  iseed1    =  p6
  iseed2    =  p7
  iseed3    =  p8
  iseed4    =  p9
  isp1      =  p10
  isp2      =  p11
  isp3      =  p12
  isp4      =  p13
  ihtim     =  .1
  kenv      linseg    0,iatk,igain,isust,igain,idk,0
  kdev1a    randh     idev, isp1, iseed1
  kdev1     port      kdev1a, ihtim
  kdev1     =  1. + kdev1
  kfr1      =  kdev1*gkfr1
  kdev2a    randh     idev, isp2, iseed2
  kdev2     port      kdev2a, ihtim
  kdev2     =  1. + kdev2
  kfr2      =  kdev2*gkfr1
  kdev3a    randh     idev, isp3, iseed3
  kdev3     port      kdev3a, ihtim
  kdev3     =  1. + kdev3
  kfr3      =  kdev3*gkfr1
  kdev4a    randh     idev, isp4, iseed4
  kdev4     port      kdev4a, ihtim
  kdev4     =  1. + kdev4
  kfr4      =  kdev4*gkfr1

  a1        oscil     kenv, kfr1, 2
  a2        oscil     kenv, kfr2, 2
  a3        oscil     kenv, kfr3, 2
  a4        oscil     kenv, kfr4, 2
  gasnd1    =  a1+a2+a3+a4
endin

instr 3
  ifbsp     =  2.
  ifbseed   =  p10
  itsize1   =  p4
  itsize2   =  p5
  itsize3   =  p6

  isd1      =  p7
  isd2      =  p8
  isd3      =  p9

  iminf     =  20.
  imaxf     =  7000.
  ifdif     =  imaxf-iminf
  isine     =  1
  it1       =  3
  it2       =  4
  it3       =  5
  kfeedback randi     .5, ifbsp, ifbseed
  kfeedback =  (kfeedback+.5)*.35 
  kdx       line      0,p3,itsize1
  krspeed   table     kdx, it1
  krnd      randi     .5, krspeed, isd1
  kfr1      =  (krnd+.5)*ifdif + iminf
  asig1     oscil     1, kfr1 + (gasig3*kfr1*kfeedback), 1

  kdx       line      0,p3,itsize2
  krspeed   table     kdx, it2
  krnd      randi     .5, krspeed, isd2
  kfr2      =  (krnd+.5)*ifdif + iminf
  asig2     oscil     1, kfr2 + (asig1*kfr2), 1

  kdx       line      0,p3,itsize3
  krspeed   table     kdx, it3
  krnd      randi     .5, krspeed, isd3
  kfr3      =  (krnd+.5)*ifdif + iminf
  gasig3    oscil     1, kfr3 + (asig2*kfr3), 1
  gasnd2    =  gasig3*10000
endin

instr 4
  ibfac     =  .8

  iseed1    =  p4
  iseed2    =  p5
  ires1a    =  p6
  ires1b    =  p7
  ires1c    =  p8
  ires1d    =  p9
  ires2a    =  p10
  ires2b    =  p11
  ires2c    =  p12
  ires2d    =  p13

  ispeed1   =  p14
  ispeed2   =  p15

  ibw1a     =  ires1a * ibfac
  ibw1b     =  ires1b * ibfac
  ibw1c     =  ires1c * ibfac
  ibw1d     =  ires1d * ibfac
  ibw2a     =  ires2a * ibfac
  ibw2b     =  ires2b * ibfac
  ibw2c     =  ires2c * ibfac
  ibw2d     =  ires2d * ibfac

  kenv1     randh     .5, ispeed1, iseed1
  kenv2     randh     .5, ispeed2, iseed2
  kenv1     =  kenv1 + .5
  kenv2     =  kenv2 + .5
  asnd1     =  gasnd1 * kenv1
  asnd2     =  gasnd2 * kenv2
  ares1     reson     asnd1, ires1a, ibw1a, 1
  ares2     reson     asnd1, ires1b, ibw1b, 1
  ares3     reson     asnd1, ires1c, ibw1c, 1
  ares4     reson     asnd1, ires1d, ibw1d, 1
  ares5     reson     asnd2, ires2a, ibw2a, 1
  ares6     reson     asnd2, ires2b, ibw2b, 1
  ares7     reson     asnd2, ires2c, ibw2c, 1
  ares8     reson     asnd2, ires2d, ibw2d, 1

  amix1     =  ares1 + ares2 + ares3 + ares4
  amix2     =  ares5 + ares6 + ares7 + ares8
            out       amix1+amix2
  gasnd1    =  0
  gasnd2    =  0
endin
