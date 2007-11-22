; ************************************************************************
; ACCCI:        45-01-4.ORC
; synthesis:    FOF (45)
;               Tutorial FOF(01)
;               granular to timbre(4)
; coded:        jpg 3/94

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2 

instr 1; *****************************************************************
  idur      =  p3

  afq       expseg    5, idur*.8, 200, idur*.2, 150 ; fund. frequency contour

   ;                            koct                        ifna    idur
   ;          xamp  xfund  xform  kband kris  kdur kdec iolaps ifnb
  a1        fof       15000, afq,  650, 0,  40, .003, .02, .007,  5, 1, 19, idur
            outs      a1,a1

endin


