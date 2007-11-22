;         BASIC KOTO SCORE FILE                                  ;
;                    GARTH MOLYNEUX                              ;
;                                                                ;
;   THIS KOTO INSTRUMENT ALLOWS FOR PITCH BEND IN EITHER         ;
;  DIRECTION AT THE END OF THE NOTE.                             ;
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
;       EXPONENTIAL RISE
f4  0.0     513   5     .001  513   1 
;       EXPONENTIAL RISE
f5  0.0     513   5     1     513   .001 
f0  30
