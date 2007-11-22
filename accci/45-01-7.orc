; ************************************************************************
; ACCCI:        45-01-7.ORC
; synthesis:    FOF (45)
;               Tutorial FOF(01)
;               rise of successive FOF granules(7)
; coded:        jpg 3/94

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  idur      =  p3

  kris      line      .003, idur, .1              ; kris contour

   ;                            koct                        ifna    idur
   ;          xamp  xfund  xform  kband kris  kdur kdec iolaps  ifnb
  a1        fof       15000, 2,    300,  0,  0, kris, .5,  .1,   2,  1, 19, idur
            out       a1

endin


