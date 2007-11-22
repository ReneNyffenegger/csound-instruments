; ************************************************************************
; ACCCI:     03-01-2A.ORC
; timbre:    pitched drum instrument
; synthesis: additive different units(03)
;            units: noise/inharm/fundamental(01)
; source:    risset2.orc  MIT(1993)
; coded:     jpg 8/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1


instr 1; *****************************************************************
  idur      =  p3
  iamp7     =  p4
  ifq1      =  p5
  iamp2     =  p4 * .8
  ifq3      =  p5 * .1
  iamp4     =  p4 * .3

  a5        randi     iamp7, 1500
  a5        oscili    a5, 1/idur, 52
  a5        oscili    a5, 4000, 1

  a3        oscili    iamp4, 1/idur, 52
  a3        oscili    a3, ifq3, 11

  a1        oscili    iamp2, 1/idur, 51
  a1        oscili    a1,    ifq1, 1

            out       a1+a3+a5
endin
