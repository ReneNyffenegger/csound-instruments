; ************************************************************************
; ACCCI:     20-01-1.ORC
; synthesis: FM(20),
;            simple FM (01), basic design(1)
; source:    Chowning (1973)
; coded:     jpg 8/92

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1
instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4
  ifq1      =  p5
  if1       =  1
  imax      =  p6
  ifq2      =  p7
  if2       =  1
  amod      oscili    imax*ifq2, ifq2, if2        ; modulator
  aenv      linen     iamp, .1, idur, .1          ; prevent clicks
  a1        oscili    aenv, ifq1+amod, if1        ; carrier
            out       a1
endin
