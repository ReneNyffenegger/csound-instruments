; ************************************************************************
; ACCCI:     20-10-4.ORC
; synthesis: FM(20),
;            FM with dynamic spectral evolution (10)
;            clarinet settings(3)
; source:    Chowning (1973)
; coded:     jpg 8/92

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4
  ifenv     =  51                                 ; clarinet settings:
  ifdyn     =  52                                 ; amp and index envelope see flow chart
  ifq1      =  cpspch(p5)*3                       ; N1:N2 is 3:2, imax=5
  if1       =  1                                  ; duration ca. .5 sec
  ifq2      =  cpspch(p5)*2
  if2       =  1
  imax      =  p6
  imin      =  2

  aenv      oscili    iamp, 1/idur, ifenv         ; envelope

  adyn      oscili    ifq2*(imax-imin), 1/idur, ifdyn ; index
  adyn      =  (ifq2*imin)+adyn                   ; add minimum value
  amod      oscili    adyn, ifq2, if2             ; modulator

  a1        oscili    aenv, ifq1+amod, if1        ; carrier
            out       a1
endin

