;============================================================================
; GLOCKENSPIEL - ALGORITHM #7
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
                        99      1       99      47      30      47      99      92      0       0     
;AMS      FIXED?   FREQ   DET    RSC
                        0       0       1       0       0     

; OPERATOR 2 PARAMETERS
f13 0 32    -2             
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
                        89      2       99      46      35      20      80      75      67      0    
;AMS      FIXED?   FREQ   DET    RSc
                        0       0       8       0       0     

; OPERATOR 3 PARAMETERS
f14 0 32    -2 
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
                        99      7       95      60      49      38      99      81      0       0     
;AMS      FIXED?   FREQ   DET    RSc
                        0       0       1       0       5     

; OPERATOR 4 PARAMETERS
f15 0 32    -2         
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
                        97      5       99      71      20      97      82      48      0       0     
;AMS      FIXED?   FREQ   DET    RSC
                        0       0       8       0       7     

; OPERATOR 5 PARAMETERS
f16 0 32    -2 
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
                        69      5       99      69      20      96      99      0       0       0     
;AMS      FIXED?   FREQ   DET    RSc
                        0       0       8       0       5     

; OPERATOR 6 PARAMETERS
f17 0 32    -2 
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
                        99      5       94      56      24      55      96      78      0       0     
;AMS      FIXED?   FREQ   DET    RSC
                        0       0       16      0       5     

;====================================================================;
;                       Yamaha DX7 Algorithm 16                      ;
;                                                                    ;
;    p02 = start     p03 = dur       p04 = pch       p05 = vel       ;
;    p06 = panfac    p07 = vibdel    p08 = vibwth    p09 = vibhz     ;
;    p10 = op1fn     p11 = op2fn     p12 = op3fn     p13 = op4fn     ;
;    p14 = op5fn     p15 = op6fn     p16 = ampfn     p17 = pkamp     ;
;    p18 = rsfn      p19 = devfn     p20 = erisfn    p21 = edecfn    ;
;    p22 = vsfn      p23 = velfn     p24 = feedfn    p25 = feedbk    ;
;                    p26 = Algorithm Number (Disabled)               ;
;====================================================================;
t       0.000   82.000
i1.00  0.000  0.410  76     65     0      0      0      0    
       12     13     14     15     16     17     2      15000
       3      8      4      6      10     9      11     7   
i1.01  0.500  0.463  75     46  
i1.02  1.000  0.506  76     80  
i1.03  1.500  0.494  75     72  
i1.04  2.000  0.633  76     77  
i1.05  2.500  0.490  71     66  
i1.06  3.000  0.583  74     98  
i1.07  3.500  0.467  72     95  
i1.08  4.000  2.100  45     103 
i1.09  4.000  0.567  69     87  
i1.10  4.500  1.442  52     75  
i1.11  5.000  1.117  57     86  
i1.12  5.500  0.615  60     72  
i1.13  6.000  0.577  64     92  
i1.14  6.500  0.502  69     95  
i1.15  7.000  0.554  40     92  
i1.16  7.000  1.481  71     93  
i1.17  7.500  0.502  52     90  
i1.18  8.000  0.946  56     96  
i1.19  8.500  0.550  64     81  
i1.20  9.000  0.442  68     100 
i1.21  9.500  0.575  71     89  
i1.22  10.000 0.635  45     87  
i1.23  10.000 1.483  72     100 
i1.24  10.500 0.471  52     86  
i1.25  11.000 2.281  57     80  
i1.26  11.500 0.506  64     79  
i1.27  12.000 0.512  76     90  
i1.28  12.500 0.500  75     85  
i1.29  13.000 0.485  76     98  
i1.30  13.500 0.573  75     77  
i1.31  14.000 0.590  76     96  
i1.32  14.500 0.490  71     74  
i1.33  15.000 0.546  74     82  
i1.34  15.500 0.460  72     86  
i1.35  16.000 0.640  69     80  
i1.36  16.000 1.752  45     81  
i1.37  16.500 0.879  52     68  
i1.38  17.000 0.794  57     79  
i1.39  17.500 0.535  60     70  
i1.40  18.000 0.473  64     85  
i1.41  18.494 0.483  69     86  
i1.42  18.994 0.563  40     92  
i1.43  18.994 1.575  71     92  
i1.44  19.494 0.398  52     93  
i1.45  19.994 0.563  56     94  
i1.46  20.494 0.510  64     81  
i1.47  20.994 0.458  72     95  
i1.48  21.494 0.498  71     77  
i1.49  21.994 3.175  45     73  
i1.50  21.994 3.190  69     85  
i1.51  22.494 2.631  52     71  
i1.52  22.994 2.138  57     84  
f0  26
e
