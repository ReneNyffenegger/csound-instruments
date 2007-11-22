;HOWARD FREDRICS
;3:13PM  4/03/1989
;MUS329J
;
;====================================================================;
;                       FINAL GRANULAR SYNTHESIS SCORE V.2                         ;
;====================================================================;
;
;  tempo in beats/min
t0      60      
; simple sine function
f01 0 512   10    1  
; ramp down
f02 0 513   -7    1     512   .64
;delay env
f03 0 513   -7    .4    64    .5    128   1     128   .5    192   0      
; pyramid
f11 0 513   7     0     256   1     256   0 
; wave 1 function
f13 0 65536 1     222   0     0     0   
; wave 2 function
f14 0 65536 1     222   0     0     0   
; grain env function
f15 0 128   7     0     26    1     76    1     26    0  
;=========================================================================;
;p1     p2      p3      p4      p5      p6      p7      p8      p9      p10      p11     p12     p13     p14     p15     p16     p17            p18     p19
;ins    strt    dur    wave1    wave2   pit     amp     att     dec     mixfreq  grfr    vibrat  vibwid  rvtim   dry/wet tblsize delaytime      loopst  loopend
i1  0  5      13     14     0      90000  .01    .05    32     23     7      .01    1.1    90     65536  12     0 65535
e








