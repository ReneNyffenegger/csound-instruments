; ************************************************************************
; ACCCI:      03-40-1.ORC
; timbre:     chaotic sinusoid field
; synthesis:  additive with different units:
;             units: various continuous pitch control functions applied
;             to sinus or complex wave.
; source:     #510   Siren-like Glissandi, Risset(1969)
; coded:      jpg 9/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  iamp1     =  p4                                 ; unit 1
  ifq1      =  p5
  irate1    =  p6
  iampr     =  p7                                 ; unit 2
  ifqr      =  p8
  ifq2      =  p9
  irate2    =  p10
  iamp3     =  p11                                ; unit 3
  ifq3      =  p12
  irate3    =  p13
  iamp4     =  p14                                ; unit 4
  ifq4      =  p15
  irate4    =  p16

  a1        oscili    ifq1, irate1, 31            ; unit 1
  a1        oscili    iamp1, a1, 11

  a99       randi     iampr, ifqr                 ; unit 2
  a2        oscili    ifq2, irate2, 32
  a2        oscili    a99, a2, 11

  a3        oscili    ifq3, irate3, 33            ; unit 3
  a3        oscili    iamp3, a3, 12

  a4        oscili    ifq4, irate4, 34            ; unit 4
  a4        oscili    iamp4, a4, 11

  a5        =  a1+a2+a3+a4
            out       a5*10
endin

