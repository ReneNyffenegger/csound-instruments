; ************************************************************************
; ACCCI:     01-01-1.ORC
; synthesis: simple(01),
;            basic instrument(01)
;            general purpose(1)
; coded:     jpg 8/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1


instr  1; ****************************************************************
  idur      =  p3
  iamp      =  p4
  ifq1      =  p5
  if1       =  p6                                 ; free choice of envelope
  if2       =  p7                                 ; and waveform

  a2        oscili    iamp, 1/idur, if2
  a1        oscili    a2, ifq1, if1
            out       a1
endin
