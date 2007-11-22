; ************************************************************************
; ACCCI:        43-21-1.ORC
; timbre:       various controlled noise spectra
; synthesis:    (g)buzz(43)
;               kratio envelope(21)
;               LINEN envelope(1)
; coded:        jpg 10/93


  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2 

instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4
  ifqc      =  p5
  inmh      =  int(sr/2/ifqc)
  ilh       =  1
  ifn       =  5                                  ; stored cosine function

  aenv      linen     iamp, .2, idur, .2          ; amp envelope
  kratio    linseg    1, idur/2, 0, idur/4, 0.8, idur/4, 0.6 ; kratio envelope

  asrc      gbuzz     aenv,ifqc,inmh,ilh,kratio,ifn
            outs      asrc, asrc

endin
