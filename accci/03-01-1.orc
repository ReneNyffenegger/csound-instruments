; ************************************************************************
; ACCCI:     03-01-1.ORC
; timbre:    drum and snare drum
; synthesis: additive different units(03)
;            units: noise/inharm/fundamental (01)
; source:    #400  Drum and Snare-drum like Sounds, Risset(1969)
; coded:     jpg 8/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1


instr 1; *****************************************************************
  idur      =  p3
  iamp7     =  p4
  ifq1      =  p5
  iamp2     =  p6
  iamp4     =  p7
  ifq5      =  p8
  ifq7      =  p9

  a5        rand      iamp7, ifq7
  a5        oscili    a5, 1/idur, 52
  a5        oscili    a5, ifq5, 11

  a3        oscili    iamp4, 1/idur, 52
  a3        oscili    a3, ifq1, 13

  a1        oscili    iamp2, 1/idur, 51
  a1        oscili    a1, ifq1, 12

            out       (a1+a3+a5) * 12
endin

