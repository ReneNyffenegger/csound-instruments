; ************************************************************************
; ACCCI:        45-01-3.ORC
; synthesis:    FOF (45)
;               Tutorial FOF(01)
;               exaggerated freq. vibrato(3)
; coded:        jpg 3/94

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; *****************************************************************
  idur      =  p3
  ifq       =  p4

  avib      oscil     20, 5, 1

   ;                            koct                        ifna    idur
   ;          xamp  xfund  xform  kband kris  kdur kdec iolaps ifnb
  a1        fof       15000, ifq+avib,650,0,40, .003, .02, .007,  5, 1, 19, idur
            out       a1

endin


