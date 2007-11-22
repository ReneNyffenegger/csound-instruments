; ALIENS2.ORC
; BY MARK DAL PORTO (7/31/95)

;=========================================================================;
;   HERE IS A CSOUND INSTRUMENT USED TO DRIVE A CSOUND SCORE CONTAINING   ;
; OVER 500 OSCILLATORS!  THE 501 SINE WAVE OSCILLATORS ARE USED AS A      ;
; SIMPLE "SOUND-MASS" GLISSANDO (OR "ALIEN ABDUCTION" IF YOU PREFER).     ;
; THE FIRST HALF FEATURES AN UPWARD GLISSANDO (OR ALIEN ABDUCTION) AND    ;
; THE SECOND HALF A DOWNWARD GLISSANDO (OR ALIEN LANDING).                ;
;   DON'T EXPECT TO BE ABLE TO SYNTHESIZE THIS ORCHESTRA AND SCORE FILE   ;
; IN REAL-TIME!  WITH THIS MANY OSCILLATORS, COMPUTATION MAY TAKE A       ;
; WHILE.  IT MAY BE BEST TO PUT THIS JOB IN WHILE YOU'RE OUT TO LUNCH!    ;
;=========================================================================;

  sr        =  44100
  kr        =  4410
  ksmps     =  10
  nchnls    =  1

instr          1

;-------------------------------------------------------------------------;
; THE FOLLOWING "EXPSEG" CREATES THE GLISSANDO                            ;
;-------------------------------------------------------------------------;

  kgliss    expseg    p4, p3/2, p5, p3/2, p4
; P3=DURATION  P4=BOTTOM PITCH OF GLISS  P5=TOP PITCH OF GLISS

;-------------------------------------------------------------------------;
; THE FOLLOWING "EXPSEG" IS THE ENVELOPE SHAPE FOR ALL 501 OSCILLATORS    ;
;-------------------------------------------------------------------------;

  kamp      expseg    .01, .1, 400, 27.9-(p2), 400, 2, 1

;-------------------------------------------------------------------------;
; THE FOLLOWING "OSCILI" IS THE AUDIO OSCILLATOR THAT PLAYS THE GLISSANDO ;
; FOR ALL 501 OSCILLATORS                                                 ;
;-------------------------------------------------------------------------;

  agliss    oscili    kamp, kgliss, 1
            out       agliss                      ; SEND AUDIO SIGNAL TO CHANNEL 1
endin                    ; END OF INSTRUMENT AND ORCHESTRA
