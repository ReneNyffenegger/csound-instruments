; ************************************************************************
; ACCCI:      01-01-4.ORC
; synthesis:  simple(01)
;             basic instrument(01),
;             envelope through LINEN unit generator(4)
; coded:      jpg 10/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4
  ifq       =  p5
  if1       =  p6
  irise     =  p7
  idec      =  p8

  a2        linen     iamp, irise, idur, idec
  a1        oscili    a2, ifq, if1
            out       a1
endin

