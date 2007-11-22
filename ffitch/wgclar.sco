f1  0 8192  10    1  

;idur          =              p3
;iamp          =              p4
;ifrq          =              cpspch(p5)
;istiff        =              p6
;iatk          =              p7
;idec          =              p8
;inoise        =              p9
;ivibfrq       =              p10
;ivibamp       =              p11
;ivibfun       =              p12
;iminfrq       =              p13
;iglis         =              p14
;ifirm         =              p15
;imidnoise     =              p16
;ivibfrq2 =              p17
;ivibamp2 =              p18

;wgclar        iamp,  ifrq, kstiff, iatk, idec, knoise, kvibfrq, kvibdep, ivibfun, iminfrq, iglis, ifirm,  imidnoise
i1  0  5      20000  6.00   -0.9   .5     .5     .4     5.735  .2     1      50   
s
i2  0  10     20000  6.00   -0.9   .5     .5     .1     5.735  .2     1      50     5.00   -.01   .6     16     .8  
s
i1  0  1      20000  8.00   -0.6   .01    .1     .2     5.735  .2     1      110  
i1  +  .      20000  8.02   0.1    .1     .2     .1     5.735  .2     1      110  
i1  .  .      20000  8.04   -0.6   .01    .3     .05    5.735  .2     1      110  
i1  .  4      20000  8.05   0.01   .5     .4     .3     5.735  .2     1      110  
s
i1  0  6      5000   7.00   -0.6   .01    .1     .01    5.735  .2     1      110  
i1  .  .      5000   8.00   0.1    .1     .2     .002   5.735  .2     1      110  
i1  .  .      5000   8.04   -0.6   .01    .3     .5     5.735  .2     1      110  
i1  .  .      5000   8.05   0.01   .5     .4     .7     5.735  .2     1      110  
