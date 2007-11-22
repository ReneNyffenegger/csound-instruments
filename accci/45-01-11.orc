; ****************************************************************************
; ACCCI:        45-01-11.ORC
; synthesis:    FOF (45)
;               Tutorial FOF(01)
;               bandwidth and skirtwidth of successive FOF granules(11)
; coded:        jpg 3/94

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *********************************************************************
  idur      =  p3

  kband     linseg    100, idur/4, 0, idur/4, 100, idur/2, 100
  kris      linseg    .003, idur/2, .003, idur/4, .01, idur/4, .003

   ;                            koct                       ifna     idur
   ;          xamp  xfund  xform  kband kris  kdur kdec iolaps ifnb
  a1        fof       14000, 100,  440, 0,kband,kris, .02, .007, 3,  1, 19, idur
            out       a1

endin
