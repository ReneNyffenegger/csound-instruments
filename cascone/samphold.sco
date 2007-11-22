;============
;SAMPHOLD.SCO
;============
f10 0 512   7     0     50    1     50    .5    300   .5    112   0 ;ADSR
f11 0 2048  10    1                     ;SINEWAVE HI-RES
f14 0 512   7     1     17    1     0     0     495 ;PULSE FOR S&H CLK OSC
f17 0 1024  7     .5    256   1     256   .5    256   0     256   .5 ;TRIANGLE WITH OFFSET
;----------------------------------------------------------------------

;======
;REVERB
;======
;INST STRT DUR DLTIME
i99 0  20     2.6    .6 

;=============
;SAMPLE & HOLD
;=============
;  STRT DUR ISEED AMP  CLK
i4  0  3      .3     2.5    7  
i4  5  5      .456   9      8.5  
i4  11 6      .334   7      10   
i4  18 10     .625   2      7    


