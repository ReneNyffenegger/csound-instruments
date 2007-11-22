;HOWARD FREDRICS
;3:13PM  4/03/1989
;MUS329J
;
;====================================================================;
;                       FINAL GRANULAR SYNTHESIS SCORE V.2                         ;
;====================================================================;
;
;  TEMPO IN BEATS/MIN
t0      60      
; SIMPLE SINE FUNCTION
f01 0 512   10    1  
; RAMP DOWN
f02 0 513   -7    1     512   .64
;DELAY ENV
f03 0 513   -7    .4    64    .5    128   1     128   .5    192   0      
; PYRAMID
f11 0 513   7     0     256   1     256   0 
; WAVE 1 FUNCTION
f13 0 8192  1     "soundin.101"     0     0     0   
; WAVE 2 FUNCTION
f14 0 8192  1     "soundin.101"     0     0     0   
; GRAIN ENV FUNCTION
f15 0 128   7     0     26    1     76    1     26    0  
;=========================================================================;
;p1     p2      p3      p4      p5      p6      p7      p8      p9      p10      p11     p12     p13     p14     p15     p16     p17            p18     p19
;ins    strt    dur    wave1    wave2   pit     amp     att     dec     mixfreq  grfr    vibrat  vibwid  rvtim   dry/wet tblsize delaytime      loopst  loopend
i1  0  20     13     14     -4     90000  .01    .05    32     42     7      .01    0.0    100    65536  50     1 65536
e








