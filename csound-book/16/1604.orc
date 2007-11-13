  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1


instr     1604 
  idur      =  p3   
  iamp      =  p4   
  ifenv     =  2                                  ; BELL SETTINGS:
  ifdyn     =  3                                  ; AMP AND INDEX ENV ARE EXPONENTIAL
  ifq1      =  cpsoct(p5)*5                       ; DECREASING, N1:N2 IS 5:7, imax=10
  if1       =  1                                  ; DURATION = 15 sec
  ifq2      =  cpsoct(p5)*7   
  if2       =  1    
  imax      =  10   
  aenv      oscili    iamp, 1/idur, ifenv         ; ENVELOPE
  adyn      oscili    ifq2*imax, 1/idur, ifdyn    ; DYNAMIC
  anoise    rand      100  
  amod      oscili    adyn+anoise, ifq2, if2      ; MODULATOR
  acar      oscili    aenv, ifq1+amod, if1        ; CARRIER
            timout    0.5, idur, noisend
  knenv     linseg    iamp, 0.2, iamp, 0.3, 0
  anoise3   rand      knenv
  anoise4   butterbp  anoise3, iamp, 100
  anoise5   balance   anoise4, anoise3
noisend:       
  arvb      nreverb   acar, 2, 0.1
  amix      =  acar+anoise5+arvb
            out       amix
endin
