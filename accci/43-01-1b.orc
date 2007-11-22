; ************************************************************************
; ACCCI:        43-01-1B.ORC
; synthesis:    (g)buzz(43)
;               basic instrument(01)
;               LINEN envelope, constant inh(1B)
; coded:        jpg 10/93


  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1


instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4
  ifqc      =  p5
  inmh      =  10

  aenv      linen     iamp, .2, idur, .2
  asrc      buzz      aenv, ifqc, inmh, 1
            out       asrc
endin


