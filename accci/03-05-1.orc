; ************************************************************************
; ACCCI:     03-05-1.ORC
; timbre:    drum, metallic
; synthesis: additive different units(03)
;            units: noise/inharm/inharm(05)
; source:    #410 Percussive Drum-like Sounds, Risset(1969)
; coded:     jpg 9/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4/3
  ifq       =  p5
  if1       =  p6
  if2       =  p7

  a3        oscili    iamp, 1/idur, 52
  a3        rand      a3, 400
  a3        oscili    a3, 500, 11

  a2        oscili    iamp, 1/idur, 52
  a2        oscili    a2, ifq, if2

  a1        oscili    iamp, 1/idur, 51
  a1        oscili    a1, ifq, if1

            out       (a1+a2+a3) * 6

endin
