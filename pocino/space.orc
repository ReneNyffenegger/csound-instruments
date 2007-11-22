  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2



; A FAIRLY BASIC 2D SPATIALIZATION MODEL, WHICH WILL SIMULATE THE DOPPLER EFFECT 
; AND ATTENUATION OF DIRECT AND REVERBERATED SOUND DUE TO DISTANCE. 
; IT WILL ALSO SIMULATE ITD AND IID.


; kr needS TO BE HIGH IF THE SOUND IS GOING TO GET CLOSE TO THE LISTENER 
; RIGHT NOW IT CAN GET A LITTLE CLOSER THAN ONE METER BEFORE THE DELAY GETS 
; UNHAPPY


instr 1

;
; STUFF TO CONFIGURE FOR DIFFERENT ENVIRONMENTS ;

  irvt      =  2.0                                ; REVERB TIME OF THIS ROOM (s)
  irvl      =  0.2                                ; REVERB LEVEL AT REFERENCE POINT (1 m)
  imaxdist  =  100.0                              ; MAXIMUM DISTANCE OF SOURCE (m)


;
; PHYSICAL CONSTANTS...
;

  imaxdel   =  imaxdist / 343                     ; MAXIMUM DELAY TIME (SAMPLES) 


; A TEST PATH AND INPUT SOUND
  adist     linseg    30, 3, 2, 6, 2, 3, 60
  atheta    linseg    0, 3, 1, 6, 10, 3, 11
  asound1   buzz      10000, 220, 5, 1
  asound    soundin   "speech1.aif"

  adistdel  =  adist/343

; SET MAXIMUM DELAY
  aspam     delayr    imaxdel

; DELAY INPUT TO REVERB SO IT DOESN'T GET THERE BEFORE DIRECT SOUND 
  adirect   deltapi   adistdel

; DELAY DUE TO DISTANCE PLUS INTERAURAL DELAY DUE TO ANGLE FOR EACH EAR 
  aleft     deltapi   adistdel-0.1*sin(atheta)/343 
  aright    deltapi   adistdel+0.1*sin(atheta)/343 

; SCALE DELAY INPUT ACCORDING TO DISTANCE 
            delayw    asound/adist

; REVERBERATED SOUND DOESN'T ATTENUATE AS FAST SO CORRECT FOR IT 
  arevb     reverb    adirect*sqrt(adist)*irvl, irvt 


; SCALE AMPLITUDE FOR EACH EAR DUE TO ANGLE OF SOURCE, PLUS REVERB EVERYWHERE 
  aleftout  =  aleft*(1+sin(atheta))/2 + arevb 
  arightout =  aright*(1-sin(atheta))/2 + arevb 

            outs      aleftout, arightout


endin


