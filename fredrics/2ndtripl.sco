;2NDTRIPLET.SCO
;FOR TESTING SECOND TRIPLET (INSTR2, 12, 22)

;=====================================================================
;CONTROL FUNCTIONS
;DURATION (THE LARGER, THE MORE SPARSE, E.G. >50 MSEC.)
;f11 0 512 -7 20 256 50  256 20                   ;[see p4 of instr1]
f21 0 512   -7    10    256   100   256   10
;DELAY (THE SMALLER, THE MORE FUSED, DETACHED WHEN >50 MSEC.)
;f12 0 512 -7 10  256 10 256 10                   ;[see p5]
f22 0 512   -7    50    256   10    256   50
;*******************
;DURATION DEVIATION (DURATIONAL IRREGULARITY)
;f13 0 512 -7 10 512 5                            ;[see p6]
;f13 0 512 -7 20 512 1
;FINIT ERROR IN INSTR1 WHEN 100 IN P6: NEGATIVE TIME PERIOD, BUT SOUNDS O.K.
;f13 0 512 -7 100 256 1 256 100
;ERROR MESSAGES WHEN 200 IN P6, MUST BE INIT VALUE = 100
;f13 0 512 -7 100 256 200 50
f23 0 512   -7    50    512   1 
;********************
;RISE TIME
f24 0 512   -7    2     512   2         ;[SEE P7]
;FREQUENCY
;f15 0 512 -7 50  256 100 256 150                 ;[see p8]
f25 0 512   -7    30    256   300   256   50 ;p8=30
;FREQUENCY DEVIATION
;f16 0 512 -7 100 256 200 256 400                 ;[see p9]
f26 0 512   -7    50    100   100   412   400 ;QUICKLY TO 100 HZ, THEN MORE SLOWLY TO 400 HZ
;PHASE
f27 0 512   -7    0     512   0         ;[see p10]
;GLOBAL ENVELOPE
f28 0 512   7     0     64    1     384   1     64    0 ;[see p11]
;SMOOTHING FUNCTION ;SAME FUNCTION AS IN TRIPLET #1
;WHEN THIS FUNCTION IS ADJUSTED TO 29, 39, CHANGE TABLEI IN THE ORCHESTRA
f19 0 1025  8     0     256   0.1   256   0.5   256   0.9   257   1 

;WAVEFORMS DETERMINE SOUND COLOR!
;f1 0 1024  10 1                                  ;the usual
f2  0 1024  10    1     .5    .3    .1  ;"sine2". a little dull
;f1 0 1024 10 0 .01 1 0 5 0                       ;"sine3", [strong 3rd & 5th partial], silvery
;f1 0 1024 9 .25 1 90                             ;cosine, interesting dense sound

;SCORE PROPER

;p1 p2  p3   p4     p5     p6     p7     p8     p9     p10    p11    
;         dur    del    rndd   prt    rndf   freq   phas   ifun   
;i2  0   1    50    10     10      2     50    100     0      1
i2  0  3      100    50     50     2      30     50     0      2    
;---------------------------------------------------------------------
;         dur_f  del_f  rndd_f prt_f    rndf_f    freq_f phas_f amp_f
i12 0  3      21     22     23     24     25     26     27     28  
;---------------------------------------------------------------------
;AMPSCALE FOR SINE
i22 0  3      24000
;FOR COSINE
;i22 0 3 16000
e
