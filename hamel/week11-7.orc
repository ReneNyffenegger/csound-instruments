; ORQUESTRA FILE
 
  sr        =  44100
  kr        =  4410
  ksmps     =  10.0



instr 1

  ipitch    =  cpspch(p5)                         ; convert the pitch
  kenv      linseg    0, .05, 1.2, .03, 1, p3-.08, 2.4 ; a two part envelope
  kenv1     linseg    0, .05, 1.2, .03, 1, p3-.08, 2.4 ; a two part envelope
  kenv2     linseg    0, .045, 1.2, .032, 1, p3-.077, 2.4 
  kenv3     linseg    0, .052, 1.2, .032, 1, p3-.084, 2.4 
  kmult     expseg    1, .08, 1, p3 -.08, .0001 
  kenv1     =  kenv1 * kmult
  kenv2     =  kenv2 * kmult
  kenv3     =  kenv3 * kmult

  kline1    linseg    .08, .07, .0109, p3-.07, .006 ; line for rand1
  kline2    linseg    .09, .07, .0095, p3-.07, .0055 ; line for rand2
  kline3    linseg    .1, .07, .0086, p3-.07, .0035 ; line for rand3
  kline4    linseg    .1, .07, .0086, p3-.07, .0055 ; line for rand speed
  kline4    =  kline4 * ipitch                    ; set rand speed
  krand1    randi     ipitch * kline1, kline4, .1 ; randi with seed
  krand2    randi     ipitch * kline2, kline4+1, .2 ; randi with seed
  krand3    randi     ipitch * kline3, kline4-1, .3 ; randi with seed

  asig1     foscili   kenv1 * p4, ipitch+krand1, 1, 1.005, 1, 1 
  asig2     foscili   kenv2 * p4, ipitch+krand2, 1, 1.002, 1, 1 
  asig3     foscili   kenv3 * p4, ipitch+krand3, 1, 1.009, 1, 1 

  knenv     linseg    .032, .06, .022, p3-.06, .022 ; bandwidth multiplier
  knoise    randi     knenv*ipitch, kr            ; generate rand freq
  anoise    oscili    kenv*p4, knoise+ipitch, 1   ; generate noise

  ga1       =  0
  asig      =  (asig1 + asig2 + asig3 + anoise) / 4 ; balance outputs
  ga1       =  ga1 + asig                         ; send to global reverb
            out       asig
endin

instr 2 ; REVERB
  ga1       init      0
  asig      reverb    ga1, 0.8
            out       asig
  ga1       =  0
endin

