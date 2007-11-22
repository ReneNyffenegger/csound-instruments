; ***********************************************************************
; ACCCI:     02-01-4.ORC
; timbre:    bell
; synthesis: additive same units(02)
;            basic instrument(01)
; source:    #410  Percussive Drum-like and Bell-like Sounds,
;            Risset(1969)
; coded:     jpg 8/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; ****************************************************************
  idur      =  p3
  iamp      =  p4
  ifq1      =  p5 * p6

  a2        oscili    iamp, 1/idur, 51
  a1        oscili    a2, ifq1, 11
            out       a1
endin

