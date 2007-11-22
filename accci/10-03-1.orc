; ************************************************************************
; ACCCI:        10-03-1.ORC
; timbre:       various controlled noise spectra
; synthesis:    Random Number Generation(10)
;               RANDH(03)
;               LINEN envelope(1)
; notes:        serves to produce input files for PLUCK
; coded:        jpg 10/93

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  idur      =  p3
  iamp      =  p4
  ifr       =  p5
  irise     =  .4
  idec      =  .4

  k1        linen     iamp, irise, idur, idec
  a1        randh     k1, ifr
            out       a1
endin
