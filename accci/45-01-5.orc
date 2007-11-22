; ************************************************************************
; ACCCI:        45-01-5.ORC
; synthesis:    FOF (45)
;               Tutorial FOF(01)
;               octaviation coefficient(5)
; coded:        jpg 3/94

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  idur      =  p3
  ifq       =  p4

  koct      linseg    0, idur*.1, 0, idur*.8, 6, idur*.1, 6

   ;                            koct                        ifna    idur
   ;          xamp  xfund  xform  kband kris  kdur kdec iolaps ifnb
  a1        fof       15000, ifq,  650, koct,40,.003, .02, .007,  5, 1, 19, idur
            out       a1

endin


