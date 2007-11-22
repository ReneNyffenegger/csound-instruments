; ************************************************************************
; ACCCI:     20-10-3.ORC
; synthesis: FM(20),
;            FM with dynamic spectral evolution (10)
;            brass settings(3)
; coded:     jpg 8/92

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4
  ifenv     =  31                                 ; brass settings:
  ifdyn     =  31                                 ; amp and index envelope see flow chart
  ifq1      =  cpspch(p5)                         ; N1:N2 is 1:1, imax=5
  if1       =  1                                  ; duration ca. .6 sec
  ifq2      =  cpspch(p5)
  if2       =  1
  imax      =  5

  aenv      oscili    iamp, 1/idur, ifenv         ; envelope

  adyn      oscili    ifq2*imax, 1/idur, ifdyn    ; dynamic
  amod      oscili    adyn, ifq2, if2             ; modulator

  a1        oscili    aenv, ifq1+amod, if1        ; carrier
            out       a1
endin
