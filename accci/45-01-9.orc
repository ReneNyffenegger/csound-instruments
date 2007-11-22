; ****************************************************************************
; ACCCI:        45-01-9.ORC
; synthesis:    FOF (45)
;               Tutorial FOF(01)
;               decay of successive FOF granules(9)
; coded:        jpg 3/94

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *********************************************************************
  idur      =  p3

  kdec      linseg    .3, idur, .003              ; kdec contour

   ;                            koct                       ifna    idur
   ;          xamp  xfund  xform  kband kris  kdur kdec iolaps ifnb
  a1        fof       15000, 2,    300, 0,  0,  .003, .4,  kdec, 2,  1,19, idur
            out       a1

endin


