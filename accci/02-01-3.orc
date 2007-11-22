; ************************************************************************
; ACCCI:     02-01-3.ORC
; timbre:    gong
; synthesis: additive same units(02)
;            basic instrument(01)
; source:    #420  Gong-like Sounds, Risset(1969)
; coded:     jpg 8/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2 

instr 1; *****************************************************************
  idur      =  p3
  ifq1      =  p4
  iamp      =  p5

  a2        oscili    iamp, 1/idur, 51
  a1        oscili    a2, ifq1, 11
            outs      a1, a1
endin


