; *****************************************************************************
; ACCCI:        45-01-6C.ORC
; synthesis:    FOF (45)
;               Tutorial FOF(01)
;               FM of formant frequency(6C)
;               ifmode = 1.
; coded:        jpg 3/94

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1; **********************************************************************
  idur      =  p3
  ifqm      =  400
  imax      =  2

  aform     line      400, idur, 800              ; contour of formant
  amod      oscili    imax*ifqm, ifqm, 1          ; FM modulator stable at 400 Hz

   ;                            koct                       ifna  idur ifmode
   ;          xamp  xfund  xform  kband kris kdur kdec iolaps ifnb  iphs
  a1        fof       15000, 5,aform+amod,0, 1, .003, .5,  .1,  3,  1,19,idur,0, 1
            out       a1

endin


