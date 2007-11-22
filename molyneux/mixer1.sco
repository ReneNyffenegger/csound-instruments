;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;         MASTER MIXER AND PANNER SCORE                 ;
;                                                       ;
;         P3 = DURATION                                 ;
;         P4 = AMPLITUDE FACTOR FOR SIGNAL              ;
;      P5 = PANNING FUNCTION FOR SIGNAL      ;
;      P6 = ENVLPX ATTACK FOR SIGNAL         ;
;      P7 = ENVLPX DECAY FOR SIGNAL               ;
;      P8 = SOUNDIN FILE NUMBER              ;
;      P9 = SKIPTIME                    ;
;                                                       ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;         FUNCTIONS
;
;    ALL LEFT
f1  0.0     512   7     1     512   1 
;    ALL RIGHT
f2  0.0     512   7     0     512   0 
;    MIDDLE
f3  0.0     512   7     .5    512   .5
;    LEFT TO RIGHT
f4  0.0     513   7     1     512   0     1     0   
;    RIGHT TO LEFT
f5  0.0     513   7     0     512   1     1     1   
;    LEFT TO RIGHT TO LEFT
f6  0.0     513   7     1     256   0     256   1     1     1   
;    RIGHT TO LEFT TO RIGHT
f7  0.0     513   7     0     256   1     256   0     1     0   
;    ALL OVER THE PLACE
f8  0.0     513   7     .5    63    .95   50    0     50    .3    50    .85   50    .80   50    .03   50    1     50 .12 50 .10 50 .5
;    ALSO ALL OVER THE PLACE
f9  0.0     513   7     .5    63    .95   50    .02   50    .3    50    .85   50    .80   50    .06   50    .98   50 .03 50 .10 50 .5
;    ALL LEFT THEN ALL RIGHT
f10 0.0     513   7     1     256   1     1     0     256   0 
;
;    INSTRUMENT CARDS
;
i1  0.00      3.00   0.50   4      0.010  0.010  5      0.0000
i1  2.00      3.00   0.70   5      0.010  0.010  5      0.1000
i1  5.00      3.00   0.30   8      0.010  0.010  5      0.3000
e
