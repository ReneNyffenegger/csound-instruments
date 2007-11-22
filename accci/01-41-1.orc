; ************************************************************************
; ACCCI:        01-41-1.ORC
; synthesis:    simple(01)
;               basic instrument with continuous pitch control function
;               (LFO) and RANDI instead of envelope(41)
; source:       #511  Glissandi with constant frequency differences
;               between voices, Risset(1969)
; coded:        jpg 9/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  iampr     =  p4
  ifqr      =  p5
  iamp1     =  p6                                 ; f33 and iamp1 point to instantaneous frequency
  irate     =  p7

  a1        randi     iampr, ifqr
  a2        oscili    iamp1, irate,  33           ;two octs down
  a2        oscili    a1,   a2,      11           ;sinus
            out       a2*10
endin