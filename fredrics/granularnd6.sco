;Howard Fredrics
;3:13PM  4/03/1989
;mus329J
;
;====================================================================;
;                       Final Granular Synthesis Score v.2                         ;
;====================================================================;
;
;  Tempo in beats/min
t0      60      
; Simple Sine Function
f01 0 512   10    1  
; Ramp down
f02 0 513   -7    1     512   .64
;Delay env
f03 0 513   -7    .4    64    .5    128   1     128   .5    192   0      
; pyramid
f11 0 513   7     0     256   1     256   0 
; Wave 1 Function
f13 0 16384 1     "soundin.102"     0     0     0   
; Wave 2 Function
f14 0 16384 1     "soundin.102"     0     0     0   
; Grain Env Function
f15 0 128   7     0     26    1     76    1     26    0  
; Fwd Env Function
f16 0 128   7     0     64    1     64    0     
; win Env Function
f17 0 128   7     0     64    1     64    0       
;=========================================================================;
;p1     p2      p3      p4      p5      p6      p7      p8      p9      p10      p11     p12     p13     p14     p15     p16     p17            p18     p19
;ins    strt    dur    wave1    wave2   pit     amp     att     dec     mixfreq  grfr    vibrat  vibwid  rvtim   dry/wet tblsize delaytime      loopst  loopend
i1  0  5      13     14     0      80000  .2     .2     1      32     7      .01    0.0    100    65536  50     0 65536 16 17




e








