  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2

instr 1; 
  idur      =  p3
  iamp      =  p4
  ifenv     =  51
  ifdyn     =  31
  ifq1      =  cpspch(p5)*16
  if1       =  1
  ifq2      =  cpspch(p5)*11
  if2       =  1
  imax      =  25

  aenv      oscili    iamp, 1/idur, ifenv         ; envelope

  adyn      oscili    ifq2*imax, 1/idur, ifdyn    ; dynamic
  amod      oscili    adyn, ifq2, if2             ; modulator

  a1        oscili    aenv, ifq1+amod, if1        ; carrier
            outs      a1*p6,a1*p7
endin
