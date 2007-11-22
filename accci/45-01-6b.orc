; *****************************************************************************
; ACCCI:        45-01-6B.ORC
; synthesis:    FOF (45)
;               Tutorial FOF(01)
;               smooth variation of formant(6B)
;               ifmode = 1.
; coded:        jpg 3/94

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; **********************************************************************
  idur      =  p3

  aform     line      400, idur, 800

   ;                            koct                       ifna  idur ifmode
   ;          xamp  xfund  xform  kband kris kdur kdec iolaps ifnb  iphs
  a1        fof       15000,   5,  aform,0,  1, .003, .5,  .1,  3,  1,19,idur,0, 1
            out       a1

endin


