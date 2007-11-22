; ************************************************************************
; ACCCI:      33-01-1.ORC
; synthesis:  Amplitude Modulation(33)
;             ring modulation, multiplier(01)
; coded:      jpg 10/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4
  ifqc      =  p5
  ifc       =  p6
  ifqm      =  p7
  ifm       =  p8
  ife       =  31

  kenv      oscili    iamp, 1/idur, ife           ; envelope
  a1        oscili    kenv, ifqc, ifc             ; carrier is sinus or complex

  a2        oscili    1, ifqm, ifm                ; modulator

            out       a1*a2                       ; multiplier as ring modulator
endin
