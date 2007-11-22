; Juice Bottle.orc
; CREATED BY PER BYRNE VILLEZ 1997 HBYRNE@PAVILION.CO.UK
  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2

instr     1
  ifq       =  p4   
; JITTER
  k50       randi     .01, 20 , .8135
  k60       randi     .01, 9 , .3111
  k70       randi     .01, .8 , .6711

  kjitter   =  (k50 + k60 + k70) * p4

; FROM ONE SHOT TO GRANULATION FUNDAMENTAL
  ksing     linseg    1 ,p3*.02 ,1 ,p3*.02 ,ifq ,p3*.96 ,ifq

; kdur CHANGE (DETERMINES OVERLAPS!!!)
  kdur      linseg    1 ,p3*.02 ,1 ,p3*.02 ,.5 ,p3*.96 ,.5

  kdec      linseg    1 ,p3*.02 ,1 ,p3*.02 ,.5 ,p3*.96 ,.5 ; kdec CHANGE

  kenv      linseg    10000 ,p3*.02 ,10000 ,p3*.02 ,2000 ,p3*.96 ,500 ;LEVEL COMPENSATOR
                                        
  kf0       =  ksing+kjitter
  ktwist    linseg    1 ,p3 ,1.2                  ; ADD MOVEMENT BY SLIDING THE FORMANT FREQ SLIGHTLY
  ktwist2   linseg    1 ,p3 ,1.1                  ; SLIGHTLY DIFFERENT ON OTHER CHANNEL

; SEE CSOUND  MANUAL FOR FOF ARGUMENT DESCRIPTIONS
  a1        fof       kenv, kf0, ktwist, 0, 0, .003, kdur, kdec, 150, 1, 19, p3,0 ,1
  a2        fof       kenv, kf0, ktwist2, 0, 0, .003, kdur, kdec, 150, 2, 19, p3,0 ,1 
            outs      a1,a2

endin
