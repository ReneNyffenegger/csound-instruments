; ************************************************************************
; ACCCI:        10-01-1.ORC
; timbre:       various controlled noise spectra
; synthesis:    Random Number Generation(10)
;               RAND(01)
;               LINEN envelope(1)
; coded:        jpg 10/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4
  irise     =  .4
  idec      =  .4

  k1        linen     iamp, irise, idur, idec
  a1        rand      k1
            out       a1
endin
