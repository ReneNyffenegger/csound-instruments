  sr        =  44100
  kr        =  882
  ksmps     =  50
  nchnls    =  2
instr 100
  gkfr1     =  0.
  gasound   =  0.
endin
; f1 is sine
; f2 is complex wave
; COOL WAVE FORMS
;f2 0 1024 10 1 .3 0 .1 .5 .02
;f2 0 1024 10 1 1 .2 .1
;f2 0 4096 10 1 .5 .2 .5 1 .5 .25 .125 .06 .125 .25 .5 1

; i1 0 dur s1 s2 s3 s4 s5
; i2 0 dur fmult amp s1 s2 s3 s4 sp1 sp2 sp3 sp4
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
  imin3     =  2                                  ; octave boundaries
  imax3     =  12
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
  aout1     =  a1+(a2*.5)+(a3*.1)
  aout2     =  a4+(a3*.5)+(a2*.1)
            outs      aout1, aout2
endin
