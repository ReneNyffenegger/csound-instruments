; ************************************************************************
; ACCCI:     01-01-2C.ORC
; timbre:    reed-like: choral effect
; synthesis: simple(01),
;            basic instrument(01), chorus(2C)
; source:    #250 Reedy Tones, Choral Effect Risset(1969)
; coded:     jpg 8/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4
  ifq1      =  p5
  if2       =  p6

  a2        oscili    iamp, 1/idur, if2
  a1        oscili    a2,   ifq1,   11            ; 11 = weighted complex
            out       a1
endin
