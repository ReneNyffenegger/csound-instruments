; ************************************************************************
; ACCCI:        43-01-1.ORC
; synthesis:    (g)buzz(43)
;               basic instrument(01)
;               LINEN envelope(1)
; coded:        jpg 10/93
; note:
; shows how buzz reacts to different frequencies...
; very low range... buzzy indeed
; stems from the fact that all amps are 1 ...

; some octaves buzz with linen

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4
  ifqc      =  p5
  inmh      =  int (sr/2/ifqc)

  aenv      linen     iamp, .2, idur, .2
  asrc      buzz      aenv,ifqc,inmh,1
            out       asrc

endin


