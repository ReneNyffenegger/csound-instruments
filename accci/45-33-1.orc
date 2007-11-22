; ************************************************************************
; ACCCI:        45-33-1.ORC
; synthesis:    FOF(45)
;               Summed FOF generators(33)
;               aaaah.. (1)
; coded:        jpg 3/94 

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2 

instr 1; *****************************************************************
  idur      =  p3
  ifq       =  p4

  k1        oscil     2, 4, 1                     ; vibrato
  k2        linseg    0, idur/2, 0, idur/2, 1     ; octaviation coefficient

   ;                           koct                      iolaps  ifnb
   ;          xamp  xfund  xform    kband kris  kdur  kdec    ifna    idur

  a1        fof       10000,ifq+k1,  500,k2, 120, .003, .017, .005,  2, 1,19, idur
  a2        fof       8000,ifq+k1,  850,k2, 120, .003, .017, .005, 10, 1,19, idur
  a3        fof       6000,ifq+k1, 2500,k2, 120, .003, .017, .005, 10, 1,19, idur
  a4        fof       4000,ifq+k1, 3500,k2, 120, .003, .017, .005, 10, 1,19, idur
  a5        =  a1 + a2 + a3 + a4

            display   a5, .1
            outs      a5, a5
endin
