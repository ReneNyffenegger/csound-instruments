; ************************************************************************
; ACCCI:     50-51-1.ORC
; synthesis: subtractive synthesis(50)
;            spectrum proportional to amplitude(51)
; source:    Dodge (1985)
; coded:     jpg 11/93


  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1


instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4
  ifq       =  cpspch(p5)
  irise     =  .2
  idec      =  .2
  inmh      =  sr/2/ifq
  iscale    =  .1

  kenv      linen     iamp, irise, idur, idec
  abuzz     gbuzz     kenv, ifq, inmh, 1, .9, 5
  a1        reson     abuzz, 0, kenv * iscale, 2
            out       a1

endin

