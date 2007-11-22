; ************************************************************************
; ACCCI:        45-01-2.ORC
; synthesis:    FOF (45)
;               Tutorial FOF(01)
;               LINSEG envelope(2)
; coded:        jpg 3/94

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  idur      =  p3
  ifq       =  p4

  aenv      linseg    0, idur*.3, 20000, idur*.4, 15000, idur*.3, 0

   ;                            koct                       ifna     idur
   ;          xamp  xfund  xform  kband kris  kdur kdec iolaps ifnb
  a1        fof       aenv,  ifq,  650, 0,  40, .003, .02, .007,  5, 1, 19, idur
            out       a1

endin


