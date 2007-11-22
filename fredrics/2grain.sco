;2GRAIN.SCO
;FOR 2 TRULY INDEPENDENT VOICES OF GRANULAR SYNTHESIS
;P3=3 SEC.
;NOTE: ORCH NEED NOT BE CHANGED, EXCEPT IF SMOOTHING FUNCTION (F19)
;FOR TABLEI (INSTR1,2,3,.....) IS DIFFERENT FOR ADDITIONAL TRIPLETS
;ALL CRUCIAL CHANGES BETWEEN TRIPLETS [EXCEPT FOR F19]
;TAKE PLACE IN THE MAIN INSTRUMENT [INSTR1,2,3] FOR EACH TRIPLET.

;=====================================================================
;CONTROL FUNCTIONS
;EACH TRIPLET HAS 1 SET OF FUNCTIONS CORRESPONDING TO THE P-FIELDS
;OF THE CORRESPONDING INSTRUMENT: F11-18 [#1], 21-28 [#2],....
;THERE WILL BE AN FINIT ERROR IF THEY ARE NOT ALIGNED
;
;DURATION (THE LARGER, THE MORE SPARSE, E.G. >50 MSEC.)
f11 0 512   -7    20    256   50    256   20    « ;[see p4 of instr1]
;f11 0 512 -7 10 256 100 256 10
f21 0 512   -7    10    256   100   256   10
;DELAY (THE SMALLER, THE MORE FUSED, DETACHED WHEN >50 MSEC.)
;f12 0 512 -7 10  256 10 256 10                   ;[see p5]
f12 0 512   -7    10    256   10    256   10
f22 0 512   -7    50    256   10    256   50
;*******************
;DURATION DEVIATION (durational irregularity)
;f13 0 512 -7 10 512 5                            ;[see p6]
;f13 0 512 -7 20 512 1
;f13 0 512 -7 100 256 1 256 100
;f13 0 512 -7 100 256 200 50
f13 0 512   -7    10    512   5 
f23 0 512   -7    50    512   1 
;********************
;RISE/DECAY time
f14 0 512   -7    2     512   2         ;[see p7]
f24 0 512   -7    5     512   5 
;CENTER FREQUENCY
f15 0 512   -7    50    256   100   256   150 ;[see p8]
;f15 0 512 -7 30 256 300 256 50 ;p8=30
;f25 0 512 -7 30 256 300 256 50
f25 0 512   -7    30    256   100   256   30
;DEVIATION FROM CENTER FREQUENCY
f16 0 512   -7    100   256   200   256   400 ;[see p9]
;f26 0 512 -7 50 100 100 412 400                  ;QUICKLY TO 100 HZ, THEN MORE SLOWLY TO 400 HZ
f26 0 512   -7    50    100   100   412   50
;PHASE
f17 0 512   -7    0     512   0         ;[see p10]
f27 0 512   -7    180   512   180
;GLOBAL ENVELOPE
f18 0 512   7     0     64    1     384   1     64    0 ;[see p11]
f28 0 512   7     0     128   .5    256   1     128   0 
;SMOOTHING FUNCTION
f19 0 1025  8     0     256   0.1   256   0.5   256   0.9   257   1 ;CAN BE USED IN BOTH TRIPLETS
;NOT A SUCCESS WHEN COMBINED WITH f19 ...
;f29 0 1025 8  1 256 .75 256 .9 256 .45 257 .1
;
;WAVEFORMS DETERMINE SOUND COLOR!
f1  0 1024  10    1                     ;the usual
;f1 0 1024  10 0 1
;f1 0 1024 10 1 .5 .3 .1                          ;"SINE2". A LITTLE DULL
;f2 0 1024 10 0 .01 1 0 5 0                       ;"SINE3", [STRONG 3RD & 5TH PARTIAL], SILVERY
;f2 0 1024 9 .25 1 90                             ;COSINE, INTERESTING DENSE SOUND; REDUCE AMPSCALE
f2  0 1024  10    .7    .353  .54   .22   0 ;30% OF THE WAY BETWEEN SINE2/SINE3

;SCORE FOR 2 TRIPLETS (1-2, 11-12, 21-22)
;DIFFERENT WAVEFORMS UNDER P11, SAME SMOOTHING F19
;
;p1 p2  p3   p4     p5     p6     p7     p8     p9     p10    p11    
;            dur    del    rndd   prt    rndf   freq   phas   ifun
;            dur    del    durdev rise   cf     cfdev         waveform
i1  0  3      50     10     10     2      50     100    0      1 ;ALTERED SINE
;I2 IS MORE SPARSE, MORE DETACHED, HAS A LARGER DURATION DEVIATION,
;A LOWER FREQUENCY BOTTOM, A DIFFERENT FREQ. DEVIATION, AND DIFFERENT PHASE,
;AS WELL AS A DIFFERENT WAVEFORM
i2  0  3      100    50     50     2      30     50     180    2 ;HYBRID SINE2/3
;---------------------------------------------------------------------
;functions 11-18 belong to i1 (first triplet), 21-28 to i2 (second triplet)
;
;         dur_f  del_f  rndd_f prt_f    rndf_f    freq_f phas_f amp_f
;            dur_f  del_f  dev_f  ris_f cf_f    dev_f  phas_f amp_f
i11 0  3      11     12     13     14     15     16     17     18  
i12 0  3      21     22     23     24     25     26     27     28  
;---------------------------------------------------------------------
;
;AMPSCALE [DEPENDS ON WAVEFORM;
;MAY EXCEED 24K FOR ALL TRIPLETS,--EXPERIMENT!]

;FIRST TRIPLET
i21 0  3      16000
;COSINE  USES LOWER AMPSCALE TO AVOID SAMPLES OUT OF RANGE
;i21 0   3    16000
;SECOND TRIPLET [COSINE]
i22 0  3      16000
e
