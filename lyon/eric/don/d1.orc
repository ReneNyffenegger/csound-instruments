  sr        =  44100
  kr        =  441
  ksmps     =  100

; f1 0 8192 10 1 ; sine
; f2 0 8192 -9 .5 1.0 0 ; raised cosine [0-1]
instr 1 ; FUNCTION GENERATOR
  ispeed1   =  p4                                 ; speed of sine change
  itrspeed  =  p5                                 ; speed of transp
  iminf     =  p6
  imaxf     =  p7 
  iseed1    =  p8
  iseed2    =  p9   
  iseed3    =  p10
   
  iminspeed =  .5
  imaxspeed =  6.
  ibasef    =  (imaxf-iminf)
  ibasef2   =  ibasef/2.
  iaddamp   =  imaxspeed-iminspeed
  iminmult  =  .9
  imaxmult  =  1./iminmult
  ibasem    =  imaxmult-iminmult
  ibasem2   =  ibasem/2.
  imintr    =  .5
  imaxtr    =  1./imintr
  ibasetr   =  imaxtr - imintr
  ibasetr2  =  ibasetr/2.
   
  k1        oscil     iaddamp, ispeed1, 2
  k1        =  k1 + iminspeed
  k2        randh     ibasef2, k1, iseed2
  k2        =  k2 + ibasef + iminf
  k3        randi     ibasem2, k1, iseed3
  k3        =  k3 + ibasem + iminmult
  k4        =  k3 * k2
  k5        randh     ibasetr2, itrspeed, iseed1
  gkf1      =  k4 * k5
endin

instr 2 ; fm instrument
  iatk      =  .1
  idk       =  .1
  imini     =  .5
  imaxi     =  3.
  ibase     =  imaxi - imini
  ispeed    =  5.3                                ; parameter
  iamp      =  20000.0
  icmc      =  p4
  isust     =  p3-(iatk+idk)
  kenv      linseg    0,iatk,iamp,isust,iamp,idk,0
  kindex    oscil     ibase, ispeed, 2
  kindex    =  kindex + imini
  asig      foscil    kenv, gkf1, 1.0, icmc, kindex, 1
            out       asig
endin
instr 3 ; fm instrument w/ tritone addition
  iatk      =  .1
  idk       =  .1
  imini     =  .5
  imaxi     =  3.
  ibase     =  imaxi - imini
  ispeed    =  5.3                                ; parameter
  iamp      =  10000.0
  icmc1     =  p4
  icmc2     =  icmc1 * p5
  isust     =  p3-(iatk+idk)
  kenv      linseg    0,iatk,iamp,isust,iamp,idk,0
  kindex    oscil     ibase, ispeed, 2
  kindex    =  kindex + imini
  asig1     foscil    kenv, gkf1, 1.0, icmc1, kindex, 1
  asig2     foscil    kenv, gkf1, 1.0, icmc2, kindex, 1
  asig      =  asig1+asig2
            out       asig
endin