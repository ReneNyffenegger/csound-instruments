; THIS PATCH GENERATES THE SOUND OF A DIDJERIDO 
; BY MEANS OF WAVE SHAPING....

;       MICHEL PETERS
; UTRECHT SCHOOL OF THE ARTS
; DEP. MUSICTECHNOLOGY
; COURSE YEAR MT-T-1  94/95

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  2

            massign   1,1

instr          1

  knote     cpsmidib  
  iveloc    ampmidi   1
  kgate     linenr    iveloc,0,1,.01

;=======ENVELOPES====================================================
  kenv1     linseg    0,      .1*5,  1,      .8*5,  1,      5*.1,  0 ;/--\(FADE IN/OUT)      

;=======LFO'S========================================================
  klfo1     randi     .02,    20,                             .123                                                                    
  klfo2     randi     .02,    10,                             .23
  klfo3     randi     500,    5,                              .67
;=======SIGNAL-PROCESSING============================================
  anoise    rand      .05                         ;NOISE
  asin1     oscili    .3+klfo2,       knote+klfo1,               1 ;FREQ+LFO'S
  awave1    tablei    asin1,          2,              1,              .5 ;WAVESHAPING/SQA.+RES.
  afilter   reson     awave1+anoise,1000,     1000+klfo3
  abal      balance   afilter,awave1
;=======OUTPUT=======================================================
            outs      (abal*kenv1*7000)*kgate,(abal*kenv1*7000)*kgate
  ga1       =  (abal*kenv1*29000)*kgate
endin
