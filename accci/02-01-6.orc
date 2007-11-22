; ************************************************************************
; ACCCI:     02-01-6.ORC
; timbre:    bell
; synthesis: additive with same units(02)
;            basic instrument(01)
;            additive bell by Risset(6)
; source:    #430  3 approximations to a Bell-like Sound, Risset(1969)
;            also: risset3.orc  M.I.T.(1993)
; coded:     jpg 8/93


  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************

  idur1     =  p3
  idur2     =  p3*.9
  idur3     =  p3*.65
  idur4     =  p3*.55                             ; Durations of the partials are a function of
  idur5     =  p3*.325                            ; the duration of the lowest partial
  idur6     =  p3*.35
  idur7     =  p3*.25
  idur8     =  p3*.2
  idur9     =  p3*.15
  idur10    =  p3*.1
  idur11    =  p3*.075

  iamp1     =  p4
  iamp2     =  p4*0.67
  iamp3     =  p4*1.35
  iamp4     =  p4*1.80
  iamp5     =  p4*2.67
  iamp6     =  p4*1.67
  iamp7     =  p4*1.46
  iamp8     =  p4*1.33                            ; Peak amps of the partials
  iamp9     =  p4*1.33                            ; are a function of the amp
  iamp10    =  p4*0.75                            ; of the lowest partial
  iamp11    =  p4*1.33

  ifq1      =  p5*.56
  ifq2      =  (p5*.56)+1
  ifq3      =  p5*.92                             ; Frequencies of the partials are a function of
  ifq4      =  (p5*.92)+1.7                       ; the frequency of the fundamental
  ifq5      =  p5*1.19
  ifq6      =  p5*1.7
  ifq7      =  p5*2
  ifq8      =  p5*2.74
  ifq9      =  p5*3
  ifq10     =  p5*3.75
  ifq11     =  p5*4.07

; The instrument consists of pairs of oscil1i/oscili
; where oscil1i provides the envelope of the partial
; and oscili the partial itself

  k1        oscil1i   0, iamp1, idur1, 51
  a1        oscili    k1, ifq1, 11

  k2        oscil1i   0, iamp2, idur2, 51
  a2        oscili    k2, ifq2, 11

  k3        oscil1i   0, iamp3, idur3, 51
  a3        oscili    k3, ifq3, 11

  k4        oscil1i   0, iamp4, idur4, 51
  a4        oscili    k4, ifq4, 11

  k5        oscil1i   0, iamp5, idur5, 51
  a5        oscili    k5, ifq5, 11

  k6        oscil1i   0, iamp6, idur6, 51
  a6        oscili    k6, ifq6, 11

  k7        oscil1i   0, iamp7, idur7, 51
  a7        oscili    k7, ifq7, 11

  k8        oscil1i   0, iamp8, idur8, 51
  a8        oscili    k8, ifq8, 11

  k9        oscil1i   0, iamp9, idur9, 51
  a9        oscili    k9, ifq9, 11

  k10       oscil1i   0, iamp10, idur10, 51
  a10       oscili    k10, ifq10, 11

  k11       oscil1i   0, iamp11, idur11, 51
  a11       oscili    k11, ifq11, 11

            out       a1+a2+a3+a4+a5+a6+a7+a8+a9+a10+a11
endin

