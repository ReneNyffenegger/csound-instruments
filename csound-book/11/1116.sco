;1116.SCO     CREATES A GRANULAR CLOUD
;                (C) RAJMIL FISCHMAN, 1997
;-----------------------------------------
;GRAIN WAVEFORM: SINEWAVE 
f 1 0 8192  10    1  
;OVERALL AMPLITUDE: HALF SINE 
f 2 0 1024  9     0.5   1     0   
;GRAIN DURATION
f 3 0 2048  7     1     996   0     64    0.3   64    0     256   0.3   256   0.7   512   0.52
;GRAIN ENVELOPE: HALF SINE 
f 4 0 1024  9     0.5   1     0   
;LOWER BAND LIMIT
f 5 0 2048  7     1     1024  0.2   256   1     512   0     256   0.9
;UPPER BAND LIMIT
f 6 0 2048  7     0     1024  0.8   256   0.5   512   1     256   0.8
;C/M RATIO
f 7 0 2048  7     0     128   1     128   0.16  128   0.637 512   0.23  128   0.24  256   0.8   256   0.3
;FM INDEX
f 8 0 2048  7     0     256   0.1   256   0.25  256   0.55  128   0.42  128   0.8   256   1     512   0.4   256   0.7
;PAN
f 9 0 2048  9     0.5   0.3   90    0.7   0.5   90    1.6   0.7   90    2.3   0.9   90    7.8   1     90  
;SCATTER
f 10  0     2048  10    1     1   
;--------------------------------------------------------------------
;       p3  p4    p5  p6  p7  p8 p9  p10 p11  p12  p13 p14  p15  p16
;           CLOUD    |GRAIN             |CLOUD FREQUENCY BAND       |
;       DUR MAX   ENV|DURATION   WFM ENV|LOWER LIMIT  |UPPER LIMIT  |
;       SEC AMP   FN | (MSEC)    FN  FN |MIN  MAX     |MIN  MAX     |
;                    |MIN MAX FN        |FREQ FREQ FN |FREQ FREQ FN |
;--------------------------------------------------------------------
i 1116 0      20     10000  2      10     30     3      1      4      1000   2500   5      2500   4670   6 

;-------------------------------------------------
;     p17 p18 p19 p20 p21 p22 p23 p24 p25 p26 p27
;     FM PARAMETERS          |SPATIALIZATION
;     C/M        |INDEX      |PAN    |SCATTER
;     MIN MAX FN |MIN MAX FN |MAX FN |MAX FN  SEED
;-------------------------------------------------
                        1       4       7       1       8       8       1.5     9       1       10      0.5  
e


