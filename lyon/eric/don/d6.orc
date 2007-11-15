  sr        =  44100
  kr        =  882
  ksmps     =  50

instr 100
  gkfr1     =  0.
  gasound   =  0.
endin
; f1 is sine
; f2 is complex wave
instr 1 ; frequency control func
  iseed1    =  p4
  iseed2    =  p5
  iseed3    =  p6
  iseed4    =  p7
  iseed5    =  p8

  imin1     =  .25                                ; rate of change for freq speed
  imax1     =  3.
  ibase1    =  (imax1-imin1)/2.0
  ibase1a   =  ibase1+imin1
  imin2     =  .25                                ; freq speed change
  imax2     =  13
  ibase2    =  (imax2-imin2)/2.0
  ibase2a   =  ibase2+imin2
  imin3     =  5                                  ; octave boundaries
  imax3     =  7
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

instr 2 ; ADD TONE TO OUTPUT BLOCK
  ifmult    =  p4
  igain     =  p5 * 10000.
  iatk      =  .1
  idk       =  .1
  isust     =  p3-(iatk+idk)

  kenv      linseg    0,iatk,igain,isust,igain,idk,0
  asig      oscil     kenv, ifmult*gkfr1, 2
  gasound   =  gasound + asig
endin

instr 3 ; MIX IN DELAYED COPY
  igain     =  .7
  idel      =  p4
  ifade     =  .1
  iatk      =  ifade
  idk       =  ifade
  isust     =  p3-(iatk+idk)
  isust2    =  (p3-(iatk+idk))-(ifade*2.)
  kenv      linseg    0,iatk,igain,isust,igain,idk,0
   ; IMPROVE BY AVOIDING UNNEEDED MULTS
  killenv   linseg    1,iatk,1,ifade,0.,isust2,0,ifade,1.,idk,1.
  ain       =  gasound*kenv
  adel      delay     ain, idel
  adelsound =  (adel+ain)*kenv
  gasound   =  adelsound+(killenv*gasound)
endin

instr 4 ; PUMP OUT SAMPLES
            out       gasound
  gasound   =  0.
endin