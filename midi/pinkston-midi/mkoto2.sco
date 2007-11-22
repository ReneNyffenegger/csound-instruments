;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;         BASIC KOTO2 SCORE FILE                                 ;
;               GARTH MOLYNEUX                                   ;
;   SPECIAL VERSION OF THE KOTO INSTRUMENT.  ONLY DIFFERENCE     ;
;   IS WITH THE RISE AND DECAY TIME OF THE DYNAMIC ENVELOPE.     ;
;                                                                ;
;         P3 = DURATION        P4 = AMPLITUDE                    ;
;         P5 = PITCH IN PCH    P6 = PITCH BEND IN OCT.DECIMAL    ;
;                                                                ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;       SINE WAVE
f1  0.0     512   10    1  
;       LINEAR RISE
f2  0.0     513   7     0     513   1 
;       LINEAR FALL
f3  0.0     513   7     1     513   0 
;       ATTACK FUNCTION FOR VIBAMP
f4  0.0     513   7     0     400   1     113   .8 
;       ATTACK FUNCTION FOR VIBAMP
f5  0.0     513   7     0     200   .56   250   1     63    .85 
;       INDEX RISE FUNCTION
f6  0.0     513   5     .001  62    .95   61    .55   200   1     190   .86
;       ATTACK FUNCTION
f7  0.0     513   5     .001  200   .95   156   .7    157   1 
;
f0  30
