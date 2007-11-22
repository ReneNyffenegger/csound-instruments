;***************************************************************;
;    SCORE FOR KREIGERESQUE ORCHESTRA NO. 1            ;
;    P3  =  OVERALL DURATION                      ;
;    P4  =  AMPLITUDE                        ;
;    P5  =  BASE FREQUENCY IN PCH                 ;
;    P6  =  BASE TRILL RATE                       ;
;    P7  =  FASTEST TRILL RATE                    ;
;    P8  =  FUNCTION NUMBER FOR  RATE OF TRILL CHANGE  ;
;    P9  =   MODULATOR RATIO                      ;
;    P10  =  MAX INDEX                       ;
;    P11 = FUNCTION NUMBER FOR INDEX SHAPE             ;
;    P12 = STRETCH FACTOR FOR PLUCK                    ;
;    P13 = DECAY TIME FACTOR OF OVERALL ENVELOPE       ;
;***************************************************************;
;       SINE WAVE
f1  0.0     512   10    1  
;       LINEAR RISE
f2  0.0     513   7     0     513   1 
;       LINEAR FALL
f3  0.0     513   7     1     513   0 
;       EXPONENTIAL RISE
f4  0.0     513   5     .001  513   1 
;       EXPONENTIAL FALL
f5  0.0     513   5     1     513   .001
;    ANGLED SQUARE WAVE
f6  0.0     513   7     0     26    1     260   1     26    0     261   0 
;    FUNCTION FOR INDEX CHANGE
f7  0.0     513   5     .05   256   .87   128   .23   129   1 
;
;       INSTRUMENT CARDS
i1  0.00      5.70   45000  12.07  6.0    18.0   2      1.001  4      2      0.001  .04
i1  2.50      6.50   34000  11.01  7.9    32.0   4      3.444  9      7      0.001  .04
i1  4.50      5.70   36000  11.09  6.5    8.0    2      1.325  4      2      0.001  .04
i1  5.30      6.50   34000  9.03   7.5    108.0  4      3.720  9      7      2.111  .04
i1  6.13      4.20   35000  9.05   6.5    32.0   3      1.098  6      4      0.080  .04
i1  6.50      6.00   34000  13.04  4.1    49.0   4      9.737  9      3      8.791  .04
i1  9.00      9.00   44000  12.11  6.5    9.0    2      1.000  3      2      0.001  .60
e
