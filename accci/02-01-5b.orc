; ************************************************************************
; ACCCI:      02-01-5B.ORC
; synthesis:  additive same units(02)
;             basic instrument(01) 
; source:     #501   Spectral Analysis of a Chord, Risset(1969)
; coded:      jpg 9/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2

instr 1; *****************************************************************
  idur      =  p3
  ifq       =  p4
  iamp      =  p5

  a2        oscili    iamp, 1/idur, 51            ; left channel
  a1        oscili    a2, ifq, 11
            outs1     a1
endin

instr 2; *****************************************************************
  idur      =  p3
  ifq       =  p4
  iamp      =  p5

  a2        oscili    iamp, 1/idur, 51            ; right channel
  a1        oscili    a2, ifq, 11
            outs2     a1
endin 

