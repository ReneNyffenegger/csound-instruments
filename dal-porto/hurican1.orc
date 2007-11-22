; HURICAN1.ORC
; BY MARK DAL PORTO (7/31/95)

;=========================================================================;
;   HERE IS A CSOUND MONO INSTRUMENT USED TO DRIVE A CSOUND SCORE         ;
; CONTAINING OVER 2000 OSCILLATORS!  THE 2004 SINE WAVE OSCILLATORS ARE   ;
; USED AS BI-DIRECTIONAL "SOUND-MASS" GLISSANDI (OR "ALIEN WINDS" IF YOU  ;
; PREFER).  DON'T EXPECT TO BE ABLE TO SYNTHESIZE THIS ORCHESTRA AND      ;
; SCORE FILE IN REAL-TIME!  WITH THIS MANY OSCILLATORS, COMPUTATION WILL  ; 
; DEFINITELY TAKE A WHILE.  IT MAY BE BEST TO PUT THIS JOB IN OVER LUNCH! ;
;=========================================================================;

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr          1

;-------------------------------------------------------------------------;
; THE FOLLOWING 4 "EXPSEG'S" CREATE THE GLISSANDI                         ;
;-------------------------------------------------------------------------;

  kgliss1   expseg    p4,p3/4,p5,p3/4,p4,p3/4,p5,p3/4,p4
  kgliss2   expseg    p5,p3/6,p4,p3/6,p5,p3/6,p4,p3/6,p5,p3/6,p4,p3/6,p5
  kgliss3   expseg    p6,p3/5,p7,p3/5,p6,p3/5,p7,p3/5,p6,p3/5,p7
  kgliss4   expseg    p7,p3/7,p6,p3/7,p7,p3/7,p6,p3/7,p7,p3/7,p6,p3/7,p7,p3/7,p6
; P3=DURATION  P4 & P6=TOP PITCHES OF GLISS  P5 & P7=BOTTOM PITCHES OF GLISS

;-------------------------------------------------------------------------;
; THE FOLLOWING "EXPSEG" IS THE ENVELOPE SHAPE FOR ALL 2004 OSCILLATORS   ;
;-------------------------------------------------------------------------;

  kamp      expseg    .01, .1, 875, 27.9-(p2), 875, 2, 1

;-------------------------------------------------------------------------;
; THE FOLLOWING "OSCILI'S" CREATE THE 2004 AUDIO OSCILLATORS THAT PLAY    ;
; THE GLISSANDI (501 EACH!)                                               ;
;-------------------------------------------------------------------------;

  agliss1   oscili    kamp*.25, kgliss1, 1
  agliss2   oscili    kamp*.25, kgliss2, 1
  agliss3   oscili    kamp*.25, kgliss3, 1
  agliss4   oscili    kamp*.25, kgliss4, 1

;-------------------------------------------------------------------------;
; THEN WE NEED TO SEND THE OUTPUT OF ALL 2004 OSCILLATORS TO CHANNEL 1    ;
;-------------------------------------------------------------------------;

            out       agliss1 + agliss2 + agliss3 + agliss4

endin     ; END OF INSTRUMENT AND ORCHESTRA
