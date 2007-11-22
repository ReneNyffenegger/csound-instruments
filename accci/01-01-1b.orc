; ************************************************************************
; ACCCI:     01-01-1B.ORC
; timbre:    electronic piano-like
; synthesis: additive with same units(02)
;            basic instrument(01) 
; source:    #301 Piano-like Excerpt, Risset(1969)
; coded:     jpg 8/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  idur      =  p3
  ifq1      =  p4
  if1       =  p5
  iamp      =  p6
  if2       =  p7

  a2        oscili    iamp, 1/idur, if2           ; envelope varies with note length
  a1        oscili    a2, ifq1, if1               ; & harmonic richness with pitch
            out       a1
endin

