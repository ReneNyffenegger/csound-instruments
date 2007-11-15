; ORQUESTRA FILE
 
  sr        =  44100
  kr        =  4410
  ksmps     =  10.0



instr 1

  ipitch    =  cpspch(p5)                         ; convert the pitch
  kenv      linseg    0, .05, 1.2, .03, 1, p3-.08, 2.4 ; a two part envelope
  kmult     expseg    1, .08, 1, p3 -.08, .0001  
  kenv      =  kenv * kmult
  krand1    randi     ipitch *.007, 8, .1         ; randi with seed
  krand2    randi     ipitch *.008, 9, .2         ; randi with seed
  krand3    randi     ipitch *.009, 6, .3         ; randi with seed

  asig1     foscili   kenv * p4, ipitch+krand1, 1, 1.005, 1, 1 
  asig2     foscili   kenv * p4, ipitch+krand2, 1, 1.002, 1, 1 
  asig3     foscili   kenv * p4, ipitch+krand3, 1, 1.009, 1, 1 

  knenv     linseg    .032, .06, .022, p3-.06, .022 ; bandwidth multiplier
  knoise    randi     knenv*ipitch, kr            ; generate rand freq
  anoise    oscili    kenv*p4, knoise+ipitch, 1   ; generate noise

  asig      =  (asig1 + asig2 + asig3 + anoise) / 4 ; balance outputs
            out       asig

endin


