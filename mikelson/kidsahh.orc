;**********************************************************************
; VOICES
; synthesis:    FOF(45)
;               Summed FOF generators(33)
; coded:        3/27/96 Hans Mikelson 

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  1

instr 1
; Male Aaaaah
  idur      =  p3
  ifq       =  p4
  k1        oscil     2, 4, 1                     ; vibrato
  k2        linseg    0, idur*.9, 0, idur*.1, 1   ; octaviation coefficient

;                           koct                      iolaps  ifnb
;          xamp  xfund  xform    kband kris  kdur  kdec    ifna    idur
;  Base amplitude of 20000

  a1        fof       10000,ifq+k1,  1030, k2, 200, .003, .017, .005,  10, 1,19, idur, 0, 1
  a2        fof       6845,ifq+k1, 1370, k2, 200, .003, .017, .005, 20, 1,19, idur, 0, 1
  a3        fof       1845,ifq+k1, 3170, k2, 200, .003, .017, .005, 20, 1,19, idur, 0, 1
  a4        fof       1726,ifq+k1, 3797, k2, 200, .003, .017, .005,  30, 1,19, idur, 0, 1
  a5        fof       1250,ifq+k1, 4177, k2, 200, .003, .017, .005, 30, 1,19, idur, 0, 1
  a6        fof       5833,ifq+k1,  428, k2, 200, .003, .017, .005, 10, 1,19, idur, 0, 1

  a7        =  (a1 + a2 + a3 + a4 + a5 + a6) * p5 / 10

  a8        tone      a7, 5000
            out       a7

endin

instr 2
; Wolf Howl
  idur      =  p3
  ifq       =  p4
  k4        oscil     2, 4, 1                     ; vibrato
  k2        linseg    0, idur*.9, 0, idur*.1, 1   ; octaviation coefficient
  k3        linseg    -10, idur*.1, 0, idur*.9, -5
  k1        =  k3 + k4

  kfo1      linseg    684, idur*.3,  684, idur*.5, 494, idur*.2,  500
  kfo2      linseg    1178, idur*.2, 1180, idur*.5, 1007, idur*.3, 1000
  kfo3      linseg    2471, idur*.5, 2528, idur*.5, 2500
  kfo4      linseg    3497, idur*.3, 3500, idur*.4, 3060, idur*.3, 3060
  kfo5      linseg    3877, idur*.4, 3535, idur*.6, 3500

;                           koct                      iolaps  ifnb
;          xamp  xfund  xform    kband kris  kdur  kdec    ifna    idur

  a1        fof       2300,ifq+k1,  kfo1, k2, 400, .003, .007, .005, 10, 1,19, idur, 0, 1
  a2        fof       660,ifq+k1,  kfo2, k2, 400, .003, .007, .005, 10, 1,19, idur, 0, 1
  a3        fof       1050,ifq+k1, 1501, k2, 400, .003, .007, .005,  2, 1,19, idur, 0, 1
  a4        fof       500,ifq+k1, 2033, k2, 400, .003, .007, .005, 10, 1,19, idur, 0, 1
  a5        fof       590,ifq+k1, kfo3, k2, 400, .003, .007, .005, 10, 1,19, idur, 0, 1
  a6        fof       210,ifq+k1, kfo4, k2, 400, .003, .007, .005,  2, 1,19, idur, 0, 1
  a7        fof       170,ifq+k1, kfo5, k2, 400, .003, .007, .005, 10, 1,19, idur, 0, 1
  a8        fof       190,ifq+k1, 3535, k2, 400, .003, .007, .005, 10, 1,19, idur, 0, 1

  a5        =  (a1 + a2 + a3 + a4 + a5 + a6 + a7 + a8) * p5 / 5

  a6        tone      a5, 5000

            out       a6

endin

instr 3
; Male Ooooo
  idur      =  p3
  ifq       =  p4
  k1        oscil     2, 4, 1                     ; vibrato
  k2        linseg    0, idur*.9, 0, idur*.1, 1   ; octaviation coefficient

;                           koct                      iolaps  ifnb
;          xamp  xfund  xform    kband kris  kdur  kdec    ifna    idur

  a1        fof       10000,ifq+k1,  350, k2, 120, .003, .017, .005,  2, 1,19, idur, 0, 1
  a2        fof       4000,ifq+k1,  640, k2, 120, .003, .017, .005, 10, 1,19, idur, 0, 1
  a3        fof       2000,ifq+k1, 2550, k2, 120, .003, .017, .005, 10, 1,19, idur, 0, 1

  a5        =  a1 + a2 + a3

            out       a5 * p5 / 10

endin

instr 4
; Male Ohhhh
  idur      =  p3
  ifq       =  p4
  k1        oscil     2, 4, 1                     ; vibrato
  k2        linseg    0, idur*.9, 0, idur*.1, 1   ; octaviation coefficient

;                           koct                      iolaps  ifnb
;          xamp  xfund  xform    kband kris  kdur  kdec    ifna    idur

  a1        fof       10000,ifq+k1,  456, k2, 120, .003, .017, .005,  2, 1,19, idur, 0, 1
  a2        fof       4000,ifq+k1,  2471, k2, 120, .003, .017, .005, 10, 1,19, idur, 0, 1
  a3        fof       1650,ifq+k1,  2813, k2, 120, .003, .017, .005, 10, 1,19, idur, 0, 1
  a4        fof       1347,ifq+k1,  3839, k2, 120, .003, .017, .005, 10, 1,19, idur, 0, 1

  a5        =  (a1 + a2 + a3 + a4) * p5/10

            out       a5

endin
