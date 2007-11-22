;============================================================================
; PLUCK BASS - ALGORITHM #17
;============================================================================
; SIMPLE SINE FUNCTION
f01 0 4096  10    1  
; OPERATOR OUTPUT LEVEL TO AMP SCALE FUNCTION (DATA FROM CHOWNING/BRISTOW)
f02 0 128   7     0     10    .003  10    .013
      10    .031  10    .079  10    .188  10    .446
      5     .690  5     1.068 5     1.639 5     2.512
      5     3.894 5     6.029 5     9.263 4     13.119
      29    13.119
; RATE SCALING FUNCTION
f03 0 128   7     0     128   1 
; EG RATE RISE FUNCTION FOR LVL CHANGE BETWEEN 0 AND 99 (DATA FROM OPCODE)
f04 0 128   -7    38    5     22.8  5     12    5  
      7.5   5     4.8   5     2.7   5     1.8   5     1.3 
      8     .737  3     .615  3     .505  3     .409  3       
                        .321    6       .080    6       .055    2       .032    3       .024  
                        3       .018    3       .014    3       .011    3       .008    3       
                        .008    3       .007    3       .005    3       .003    32      .003 
; EG RATE RISE PERCENTAGE FUNCTION
f05 0 128   -7    .00001      31    .00001      4     .02   5 
                        .06     10      .14     10      .24     10      .35     10      .50  
                        10      .70     5       .86     4       1.0     29      1.0  
; EG RATE DECAY FUNCTION FOR LVL CHANGE BETWEEN 0 AND 99
f06 0 128   -7    318   4     181   5     115   5 
      63    5     39.7  5     20    5     11.2  5     7       
      8     5.66  3     3.98  6     1.99  3     1.34  3       
                        .99     3       .71     5       .41     3       .15     3       .081  
                        3       .068    3       .047    3       .037    3       .025    3  
                        .02     3       .013    3       .008    36      .008 
; EG RATE DECAY PERCENTAGE FUNCTION
f07 0 128   -7    .00001      10    .25   10    .35   10
                        .43     10      .52     10      .59     10      .70     10      .77  
                        10      .84     10      .92     9       1.0     29      1.0  
; EG LEVEL TO AMP FACTOR MAPPING FUNCTION (INDEX IN RADIANS = INDEX / 2PI)
;f08     0       128     6      .001    96      .5      32      1
;f08   0   128   -6    0   64   .0318   0       .0318   64      2.08795
f08 0 128   -7    0     10    .000477     10    .002
      10    .00493      10    .01257      10    .02992      10    .07098
      5     .10981      5     .16997      5     .260855     5     .39979
      5     .61974      5     .95954      5     1.47425     4     2.08795
      29    2.08795
; VELOCITY TO AMP FACTOR MAPPING FUNCTION (ROUGH GUESS)
f09 0 129   9     .25   1     0   
; VELOCITY SENSITIVITY SCALING FUNCTION
f10 0 8     -7    0     8     1   
; FEEDBACK SCALING FUNCTION
f11 0 8     -6    0     8     6            
;============================================================================
; OPERATOR 1 PARAMETERS:    
f12 0 32    -2    
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
                        99      0       84      30      28      76      99      90      0       0     
;AMS      FIXED?   FREQ   DET    RSC
                        0       0       .5      0       4     

; OPERATOR 2 PARAMETERS
f13 0 32    -2             
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
                        76      2       80      40      28      54      99      90      0       0     
;AMS      FIXED?   FREQ   DET    RSC
                        0       0       .5      0       4     

; OPERATOR 3 PARAMETERS
f14 0 32    -2 
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
                        60      1       84      30      28      76      99      90      0       0     
;AMS      FIXED?   FREQ   DET    RSC
                        0       0       1       0       4     

; OPERATOR 4 PARAMETERS
f15 0 32    -2         
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
                        97      2       94      68      24      55      96      78      0       0     
;AMS      FIXED?   FREQ   DET    RSC
                        0       0       .5      0       1     

; OPERATOR 5 PARAMETERS
f16 0 32    -2 
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
                        51      2       99      0       0       0       99      0       0       0     
;AMS      FIXED?   FREQ   DET    RSC
                        0       0       .5      0       0     

; OPERATOR 6 PARAMETERS
f17 0 32    -2 
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
                        82      5       94      56      24      55      96      78      0       0     
;AMS      FIXED?   FREQ   DET    RSC
                        0       0       4       0       1     

;====================================================================;
;                       Yamaha DX7 Algorithm 17                      ;
;                                                                    ;
;    p02 = start     p03 = dur       p04 = pch       p05 = vel       ;
;    p06 = panfac    p07 = vibdel    p08 = vibwth    p09 = vibhz     ;
;    p10 = op1fn     p11 = op2fn     p12 = op3fn     p13 = op4fn     ;
;    p14 = op5fn     p15 = op6fn     p16 = ampfn     p17 = pkamp     ;
;    p18 = rsfn      p19 = devfn     p20 = erisfn    p21 = edecfn    ;
;    p22 = vsfn      p23 = velfn     p24 = feedfn    p25 = feedbk    ;
;                    p26 = Algorithm Number (Disabled)               ;
;====================================================================;
i1.01  0.000  1.587  46     90     0      0      0      0    
       12     13     14     15     16     17     2      15000
       3      8      4      6      10     9      11     7   
t       0.000   114.000
i1.02  1.496  0.315  53     83  
i1.03  1.967  1.075  53     79  
i1.04  2.954  0.975  41     84  
i1.05  3.958  1.569  46     98  
i1.06  5.496  1.535  53     94  
i1.07  6.925  0.987  41     85  
i1.08  7.923  1.629  46     102 
i1.09  9.517  0.219  53     89  
i1.10  10.019 0.987  53     83  
i1.11  10.942 1.004  41     93  
i1.12  12.004 1.519  46     86  
i1.13  13.485 0.160  53     70  
i1.14  13.973 1.148  53     82  
i1.15  15.027 0.717  41     85  
i1.16  16.019 1.519  39     94  
i1.17  17.535 0.198  46     83  
i1.18  17.975 1.635  46     79  
i1.19  19.546 0.483  39     90  
i1.20  20.065 1.419  41     100 
i1.21  21.506 0.273  48     95  
i1.22  21.929 1.615  48     85  
i1.23  23.462 0.590  41     88  
i1.24  24.021 1.425  46     98  
i1.25  25.458 0.319  53     85  
i1.26  25.948 1.077  53     88  
i1.27  26.944 1.033  41     94  
i1.28  27.977 1.608  46     86  
i1.29  29.498 1.527  53     92  
i1.30  30.942 1.065  41     92  
i1.31  32.004 1.535  46     91  
i1.32  33.517 0.223  53     91  
i1.33  33.900 1.212  53     83  
i1.34  35.013 1.037  41     103 
i1.35  36.031 4.140  46     101 
f0  42
e
