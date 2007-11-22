; ************************************************************************
; ACCCI:        10-02-2.ORC
; timbre:       noise spectra, control bandwidth(ifqr), center freq(ifq1)
; synthesis:    Random Number Generation(10)
;               RANDI(02)
;               LINEN envelope on RANDI ring modulates an oscillator (2)
; source:       Dodge(1985), p.92
; coded:        jpg 8/92

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4
  ifq1      =  p5
  if1       =  p6
  ifqr      =  p7
  irise     =  .2
  idec      =  .3

  kenv      linen     iamp, irise, idur, idec     ; envelope
  kran      randi     kenv, ifqr                  ; random numbers
  a1        oscili    kran, ifq1, if1             ; applied to amplitude slot
            out       a1

endin

