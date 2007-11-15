  sr        =  44100
  kr        =  882
  ksmps     =  50

; TONE
; ring mod pulse waves with gliss deviation
; f1 0 1024 11 12 1 .8 ; 12 harmonics, 1 is lowest, .8 is up gain
instr 1 
  ifr1      =  p4
  ifr2      =  p5
  isp1      =  p6
  isp2      =  p7
  idev1     =  (p8 * ifr1)/2.
  idev2     =  (p9 * ifr2)/2.
  iseed1    =  p10
  iseed2    =  p11
   
  iatk      =  .1
  idk       =  .1
  isust     =  p3-(iatk+idk)
  iamp      =  20000.
  kf1       randi     idev1, isp1, iseed1
  kf1       =  kf1 + idev1
  kf2       randi     idev2, isp2, iseed2
  kf2       =  kf2 + idev1
  kf1       =  kf1 + ifr1
  kf2       =  kf2 + ifr2
  kenv      linseg    0,iatk,iamp,isust,iamp,idk,0
  a1        oscil     1., kf1, 1
  a2        oscil     1., kf2, 1
  aout      =  a1 * a2 * kenv
            out       aout
endin
