; VOICEGLIDE.ORC
; CREATED BY:PER BYRNE VILLEZ hbyrne@pavilion.co.uk
  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2

instr 1
  idur      =  p3
  ifq       =  p4 
      
; JITTER
  k50       randi     .01,  1/.05,   .8135
  k60       randi     .01,  1/.111,  .3111
  k70       randi     .01,  1/1.219, .6711

  kjitter   =  (k50 + k60 + k70) * ifq

  kfund     linseg    1 ,p3*.04 ,1 ,p3*.3 ,ifq ,p3*.66 ,ifq ; GLIDES FROM 1Hz TO ifq
  kdur      linseg    1 ,p3*.02 ,1 ,p3*.02 ,.5 ,p3*.96 ,.5 ; CHANGES SIZE OF kdur
  kdec      linseg    1 ,p3*.02 ,1 ,p3*.02 ,.5 ,p3*.96 ,.5 ; CHANGES SIZES OF kdec

; OVERALL LEVEL ENVELOPE
  kenv      linseg    10000 ,p3*.02 ,10000 ,p3*.02 ,2000 ,p3*.96 ,500

  kf0       =  kfund+kjitter
  kforms    linseg    1 ,p3, 2
 

  a1        fof       kenv, kf0, kforms, 0, 0, .003, kdur, kdec, 150, 1, 19, idur,0 ,1
  a2        fof       kenv, kf0, kforms, 0, 0, .003, kdur, kdec, 150, 2, 19, idur,0 ,1
 
            outs      a1 ,a2
endin
