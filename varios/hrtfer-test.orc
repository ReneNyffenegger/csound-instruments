;*********************************
;* test file for our hrtfer u.g.s (breder)
;*********************************

  sr        =  44100
  kr        =  441
  ksmps     =  100
  nchnls    =  2


instr 1
  iaz       =  p4
  ielev     =  p5        

  asrc      soundin   "allofmestereo.aif"         ; 1.4 sec.
  asrc2     foscili   20000, 220, 1, 2, 10, 1
  aleft,aright hrtfer   asrc, iaz, ielev, "HRTFcompact"
  aleftscale   =      aleft * 250
  arightscale  =      aright * 250                  
            outs      aleftscale, arightscale
endin 

instr 2
  iaz       =  p4
  ielev     =  p5        

  asrc      soundin   "allofme.aif"               ;1.6 sec
  asrc2     foscili   20000, 220, 1, 2, 10, 1
  aleft,aright hrtfer   asrc, iaz, ielev, "HRTFcompact"
  aleftscale   =      aleft * 200
  arightscale  =      aright * 200

            outs      aleftscale, arightscale
endin 
