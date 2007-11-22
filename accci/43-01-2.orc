; ************************************************************************
; ACCCI:        43-01-2.ORC
; synthesis:    (g)buzz(43)
;               basic instrument(01)
;               EXPON envelope(2)
; coded:        jpg 10/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4
  ifqc      =  p5
  inmh      =  int(sr/2/ifqc)

  aenv      expon     iamp, idur, .0001
  asrc      buzz      aenv, ifqc, inmh, 1
            out       asrc
endin

