;timbre4.orc
  sr        =  44100
  kr        =  2100
  ksmps     =  21
  nchnls    =  1

;PANNING INSTRUMENT BASED ON CHOWNING MODEL QUOTED IN DODGE (PG.249)
instr          1
  iprv      =  .25                                ;BASIC REVERB LEVEL
  kdist     linseg    1 ,p3*.25 ,1 ,p3*.5 ,5 ,p3*.25 ,5 ;DISTANCE
  apan      linseg    .25 ,p3*.3 ,.25 ,p3*.3 ,5 ,p3*.3 ,.25 ,p3*.1 ,.25 ;SPEED OF PANNING
  asig      oscili    10000 ,440 ,2               ;SOUND TO BE PANNED (USUALLY A SOUNDFILE)
  apan      phasor    apan ,0                     ;PHASE FOR PANNING
  a1        tablei    apan ,1 ,1 ,0 ,1            ;CHANS 1->8
  a2        tablei    apan ,1 ,1 ,.125 ,1
  a3        tablei    apan ,1 ,1 ,.25 ,1
  a4        tablei    apan ,1 ,1 ,.325 ,1
  a5        tablei    apan ,1 ,1 ,.5 ,1
  a6        tablei    apan ,1 ,1 ,.625 ,1
  a7        tablei    apan ,1 ,1 ,.75 ,1
  a8        tablei    apan ,1 ,1 ,.875 ,1
  a9        =  asig/kdist
  a11       =  a1*a9                              ;DIRECT SIGNAL
  a12       =  a2*a9
  a13       =  a3*a9
  a14       =  a4*a9
  a15       =  a5*a9
  a16       =  a6*a9
  a17       =  a7*a9
  a18       =  a8*a9
  a10       =  (asig/sqrt(kdist))*iprv 
  a20       =  a10/kdist                          ;GLOBAL REVERB LEVEL
  a30       =  a10*(1-1/kdist)
  a31       =  (a1*a30)+a20                       ;LOCAL REVERB LEVEL 1->8
  a32       =  (a2*a30)+a20
  a33       =  (a3*a30)+a20
  a34       =  (a4*a30)+a20
  a35       =  (a5*a30)+a20
  a36       =  (a6*a30)+a20
  a37       =  (a7*a30)+a20
  a38       =  (a8*a30)+a20
  a21       reverb    a31 ,1                      ;REVERB APPLIED
  a22       reverb    a32 ,.95
  a23       reverb    a33 ,.9
  a24       reverb    a34 ,.85
  a25       reverb    a35 ,.8
  a26       reverb    a36 ,.825
  a27       reverb    a37 ,.925
  a28       reverb    a38 ,.975
  a21       =  a21+a11                            ;SUMMATION, CHANS 1->8
  a22       =  a22+a12
  a23       =  a23+a13
  a24       =  a24+a14
  a25       =  a25+a15
  a26       =  a26+a16
  a27       =  a27+a17
  a28       =  a28+a18

            out       a21                         ;(FOR TIM(BR)E EACH CHANNEL WAS OUTPUT AS A SEPARATE
               ;out a22                                               ;MONO SOUNDFILEAND THEN MIXED AS 8-TRACKS
               ;out a23                                               ;USING PROTOOLS)
               ;out a24 
               ;out a25 
               ;out a26 
               ;out a27 
               ;out a28 

endin
