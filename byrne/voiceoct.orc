; VOICEOCT.ORC
; CREATED BY PER BYRNE VILLEZ 1997 hbyrne@pavilion.co.uk

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2

instr 1
  ifq       =  p4
                                             
; JITTER
  k50       randi     .01,1/.05, .8135            ; RANDOM JITTER
  k60       randi     .01,1/.111, .3111
  k70       randi     .01,1/1.219, .6711
  kjitter   =  (k50 + k60 + k70) * ifq

; THIS LINE SUBSTITUTES  THE LINE kfund IN EXAMPLE VoiceGlide1.orc
  koct      linseg    7 ,p3*.04 ,7 ,p3*.3 ,0 ,p3*.66 ,0

  kdur      linseg    1 ,p3*.02 ,1 ,p3*.02 ,.5 ,p3*.96 ,.5 ; CHANGES SIZE OF kdur
  kdec      linseg    1 ,p3*.02 ,1 ,p3*.02 ,.5 ,p3*.96 ,.5 ; CHANGES SIZES OF kdec

  kenv      linseg    10000 ,p3*.02 ,10000 ,p3*.02 ,2000 ,p3*.96 ,500 ; LEVEL ENVELOPE

  kf0       =  ifq+kjitter
  kforms    linseg    1 ,p3, 2
 
  a1        fof       kenv, kf0, kforms, koct, 0, .003, kdur, kdec, 150, 1, 19, p3,0 ,1
  a2        fof       kenv, kf0, kforms, koct, 0, .003, kdur, kdec, 150, 2, 19, p3,0 ,1 
            outs      a1 ,a2
endin
