; CREATED BY:PER BYRNE VILLEZ  1997  hbyrne@pavilion.co.uk
; OVERBLOWN  JUICE BOTTLE

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2

instr 1
 
; JITTER
  k50       randi     .6,200,  .8135
  k60       randi     .6,190,  .3111
  k70       randi     .6,210,  .6711

  kjitter   =  (k50 + k60 + k70) * p4

; FROM ONE SHOT TO FUNDAMENTAL
  ksing     linseg    1, p3*.02, 1, p3*.02, p4, p3*.96,p4

; kdur CHANGE (DETERMINES OVERLAPS!!!)
  kdur      linseg    1, p3*.02, 1, p3*.02, .5, p3*.96, .5

  kdec      linseg    1, p3*.02, 1, p3*.02, .5, p3*.96, .5 ; kdec CHANGE
  kenv      linseg    10000, p3*.02, 10000, p3*.02, 2000, p3*.96, 500 ; LEVEL COMPENSATOR

  kf0       =  ksing+kjitter

  ktwist    linseg    2.1, p3, 1.0

  ktwist2   linseg    2.2, p3, 1.1                ; ADD SLIDE ON RIGHT CHANNEL 
                                   
  a1        fof       kenv, kf0, ktwist, 0, 0, .003, kdur, kdec, 170, 1, 19, p3,0, 1
  a2        fof       kenv, kf0, ktwist2, 0, 0, .003, kdur, kdec, 170, 2, 19, p3,0, 1 
 
            outs      a1,a2

endin
