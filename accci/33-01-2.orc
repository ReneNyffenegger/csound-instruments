; ************************************************************************
; ACCCI:     33-01-2.ORC
; timbre:    gong
; synthesis: Amplitude Modulation(33)
;            ring modulation, multiplier(01)
;            sinus and block(2)
; source:    #550  Ring-modulation Chord with Gong-like Resonance
;            Risset(1969)
; coded:     jpg 9/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  idur      =  p3                                 ; ring modulation chord
  iamp      =  p4
  irise     =  p5
  idec      =  p6
  ifqc      =  p7
  ifqm      =  p8

  a1        envlpx    iamp, irise, 1/idur, idec, 51, 1, .01
  a1        oscili    a1, ifqc, 11                ; sinus
  a2        oscili    1, ifqm, 31                 ; block
            out       a1*a2                       ; ring
endin

instr 2; *****************************************************************
  idur      =  p3                                 ; gong resonance
  iamp      =  p4
  ifq       =  p5

  a1        oscili    iamp, 1/idur, 52
  a1        oscili    a1, ifq, 11
            out       a1
endin
