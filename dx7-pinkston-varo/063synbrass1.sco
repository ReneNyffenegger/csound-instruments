;============================================================================
; SYNTH BRASS 1 - ALGORITHM #2
;============================================================================
; SIMPLE SINE FUNCTION
f01 0 8192  10    1  
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
                        99      0       71      41      54      61      99      95      99      0    
;AMS      FIXED?   FREQ   DET    RSC
                        3       1       1.413   -7      0    

; OPERATOR 2 PARAMETERS
f13 0 32    -2             
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
                        86      0       59      46      5       38      38      95      95      0    
;AMS      FIXED?   FREQ   DET    RSC
                        0       0       1       +7      0    

; OPERATOR 3 PARAMETERS
f14 0 32    -2 
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
                        99      0       71      41      54      61      99      95      99      0    
;AMS      FIXED?   FREQ   DET    RSC
                        3       1       1.738   +7      0    

; OPERATOR 4 PARAMETERS
f15 0 32    -2         
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
                        82      0       56      13      5       35      99      96      94      0    
;AMS      FIXED?   FREQ   DET    RSC
                        0       0       1       +7      0    

; OPERATOR 5 PARAMETERS
f16 0 32    -2 
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
                        77      0       56      13      4       33      99      96      94      0    
;AMS      FIXED?   FREQ   DET    RSC
                        0       0       1       +6      0    

; OPERATOR 6 PARAMETERS
f17 0 32    -2 
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
                        64      0       56      13      3       33      99      96      94      0    
;AMS      FIXED?   FREQ   DET    RSC
                        0       0       4       +5      0    

;====================================================================;
;                       Yamaha DX7 Algorithm 2                       ;
;                                                                    ;
;    p02 = start     p03 = dur       p04 = pch       p05 = vel       ;
;    p06 = panfac    p07 = vibdel    p08 = vibwth    p09 = vibhz     ;
;    p10 = op1fn     p11 = op2fn     p12 = op3fn     p13 = op4fn     ;
;    p14 = op5fn     p15 = op6fn     p16 = ampfn     p17 = pkamp     ;
;    p18 = rsfn      p19 = devfn     p20 = erisfn    p21 = edecfn    ;
;    p22 = vsfn      p23 = velfn     p24 = feedfn    p25 = feedbk    ;
;                    p26 = Algorithm Number (Disabled)               ;
;====================================================================;
t       0.000   120.000
i1.01  0.000  0.619  60     105    0      0      0      0    
       12     13     14     15     16     17     2      10000
       3      8      4      6      10     9      11     7   
i1.02  1.010  1.433  67     101 
i1.03  2.519  0.298  69     87  
i1.04  3.000  0.802  70     95  
i1.05  3.942  0.296  62     85  
i1.06  4.419  0.288  65     82  
i1.07  4.933  0.552  65     66  
i1.08  5.412  0.371  63     85  
i1.09  5.927  0.408  60     80  
i1.10  6.448  0.275  58     76  
i1.11  6.931  0.673  60     93  
i1.12  7.971  0.373  60     96  
i1.13  8.454  0.281  62     85  
i1.14  8.900  1.446  63     95  
i1.15  10.406 0.317  65     72  
i1.16  10.892 0.223  63     67  
i1.17  11.402 0.185  62     66  
i1.18  11.906 0.333  60     74  
i1.19  12.421 0.300  58     78  
i1.20  12.946 1.256  65     91  
i1.21  14.456 0.406  63     73  
i1.22  14.960 0.744  60     91  
i1.23  15.950 0.610  60     97  
i1.24  16.996 1.273  67     107 
i1.25  18.435 0.283  69     94  
i1.26  18.977 0.781  70     92  
i1.27  19.977 0.329  72     86  
i1.28  20.425 0.263  70     78  
i1.29  20.908 0.288  69     91  
i1.30  21.394 0.360  67     90  
i1.31  21.862 0.352  65     89  
i1.32  22.415 0.329  63     88  
i1.33  22.921 1.244  65     98  
i1.34  24.535 0.494  62     91  
i1.35  25.008 0.358  63     80  
i1.36  25.498 0.354  65     85  
i1.37  26.000 0.394  67     83  
i1.38  26.444 0.354  69     83  
i1.39  26.979 0.794  70     97  
i1.40  27.906 0.281  62     87  
i1.41  28.381 0.317  65     78  
i1.42  28.873 0.606  65     80  
i1.43  29.365 0.462  63     83  
i1.44  29.890 0.448  60     80  
i1.45  30.381 0.400  58     67  
i1.46  30.846 0.425  60     76  
i1.47  31.317 0.606  58     63  
i1.48  31.883 0.427  53     98  
i1.49  32.340 0.406  55     91  
i1.50  32.896 4.179  36     108 
i1.51  32.896 4.177  48     108 
f0  38
e
