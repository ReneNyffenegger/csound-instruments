; ************************************************************************
; ACCCI:        43-01-3.ORC
; synthesis:    (g)buzz(43)
;               basic instrument(01)
;               EXPSEG envelope(3)
; coded:        jpg 10/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4
  ifqc      =  p5
  inmh      =  p6

  aenv      expseg    .1, 1/10*idur,iamp, 9/10*idur, .1
  asrc      buzz      aenv, ifqc, inmh, 1
            out       asrc
endin


