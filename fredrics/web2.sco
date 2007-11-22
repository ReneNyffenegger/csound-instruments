; Webern Score
; Howard Fredrics
; MUS329J
;5:42PM  3/06/1989
; Tempo = 25 beats/min
t00     25  
; Tempo = 50 beats/min
; t00     50
; Simple Sine Function
f01 0 512   10    1  
; Ramp
f02 0 513   7     0     512   1 
; Exponential rise
;f03     0       513     5       .001    512     1
; Quarter Sine Wave in 128 locs + extended guard point
;f04     0       129     9       .25     1       0
; Quarter Cosine
;f05     0       129     9       .25     1       90
; Triangular Wave
;f06     0       512     10      1   0 .111   0  .04    0  .02    0 .012
; Sawtooth Wave
f07 0 512   10    1     .5    .3    .25   .2    .167  .14   .125  .111
; Square Wave
f08 0 512   10    1     0     .3    0     .2    0     .14   0     .111
; Narrow Pulse
f09 0 512   10    1     1     1     1     .7    .5    .3    .1 
; Exponential rise and decay
f10 0 513   5     .1    128   1     384   .01
; Reverse pyramid
;f11     0       513     7       1       256     .01       256     1
; Trill Square
f12 0 513   7     0     1     .01   1     1     254   1     1     .01   2     0   
;Cello Exponential Rise for Amp
f13 0 513   5     .001  51    1     102   .2    359   1 
;Cello Exponential Rise for Index
f14 0 513   5     .001  102   1     102   .6    308   1 
;Cello Inv Exponential Rise for Amp
f15 0 513   5     .001  51    1     308   .2    153   .05
;Bell Exponential Rise for Amp
f16 0 513   5     .001  25    1     77    .6    210   .6    100   .7    100   .4
;Bell Exponential Rise for Amp
f17 0 513   5     .001  25    1     77    .4    210   .4    150   .5    50    .2 

;==========================================================================;
;               Basic FM Instrument with Variable Vibrato                  ;
;                                                                          ;
;  p4=amp       p5=pch(fund)    p6=vibdel       p7=vibrate      p8=vibwth  ;
;  p9=rise     p10=decay       p11=max index   p12=car fac     p13=mod fac ;
; p14=index rise  p15=index decay  p16=left channel factor p17=original p3 p18=vibfn;
;  p20=irisefn p21=inrisefn
;==========================================================================;
;p1     p2      p3   p4      p5   p6 p7 p8   p9  p10 p11 p12 p13 p14 p15 p16 p17  p18 p19  p20  p21

i09 0  2.05   18000  6.03   .2     8      .083   1.9    .1     4      3      1      0      0      .8     np19   12 0 13 14
i09 2  1.4    25000  8.00   .5     5      .005   .15    .2     1      .      .      .      .      .4     np19   1 pp3 2 2
i09 3.34      .76    18000  6.11   .2     6      .02    .6     .1     3      1      1      .25    .3     .7     np19 . . 13 14
i09 4  1.5    16000  6.10   .5     5      .02    .4     .      .      .      .      .      .      .8     np19   . . . .
i09 9  3      20000  8.05   1      4      .015   1.5    1.5    5      3      1      .1     .1     .2     np19   . . 2 14
i09 15 .5     12000  8.09   .1     0      .      .4     .1     1      .      .      .45    .05    .4     np19   . . . .
i09 16.5      1      13500  9.02   .      .      .      .4     .1     1.5    4      1      .      .      .3     np19 . . . .
i09 18 3      12000  10.01  1      5      .005   .08    .5     3      .      .      .1     2.1    .2     3      . . 15 14
;-------------------------------------------------------------------------------------------------
;Piano Soprano Voice
;p1     p2      p3   p4      p5   p6 p7 p8   p9  p10 p11 p12 p13 p14 p15 p16 p17  p18 p19  p20  p21
i10 3.5       2.5    9000   7.02   .1     0      0      1.5    .5     6      1      1.4    .5     1      .2     np19 1 0 16 17
i10 3.5       2.7    10000  6.01   .      .      .      .      .      .      .      .      .      .      .3     np19 . pp3 . .
i10 .  2.9    10500  5.05   .      .      .      .      .      .      .      .      .      .      .      np19   . . . .
i10 8.66      3.33   12000  7.03   .      .      .      2      .3     9      .      .      .      .      .2     np19 . pp3 . .
i10 8.66      3.5    13000  5.04   .      .      .      .      .      .      .      .      .      .      .3     np19 . . . .
i10 13.33     3.66   9000   6.11   .      2      .005   .5     .5     8      .      .      .      .      .2     np19 . . . .
i10 13.33     3.75   9500   6.06   .      .      .      .      .      .      .      .      .      .      .3   
i10 13.33     3.8    10000  6.00   .      .      .      .      .      .      .      .      .      .      .      .    
i10 13.33     3.9    10500  5.10   .      .      .      .      .      .      .      .      .      .      .      3.9 . . . .
;-------------------------------------------------------------------------------------------------
;Piano Lyric Voice
;                 Simple Gating Instrument with Chorus                    ;
;                                                                         ;
; p4=amp      p5=pch1       p6=pch2       p7=risefac      p8=decfac       ;
; p9=ofn1    p10=ofn2      p11=gatefn    p12=beathz      p13=gatehz       ;
;=========================================================================;
;p1     p2      p3      p4      p5      p6      p7  p8 p9 p10 p11 p12 p13
i05 5.66      1.7    16000  7.06   7.06   .2     .3     8      9      10     1      .5   
i05 7.33      .7     18000  6.08   6.08   .1     .5     9      8      .      2      1.3  
i05 8  4      19000  7.07   7.07   .02    .5     8      7      .      4      .25  
e
