;============================================================================
; MUSIC BOX - ALGORITHM #5
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
                        99      3       82      33      71      40      99      0       0       0     
;AMS      FIXED?   FREQ   DET    RSC
                        3       0       .5      +3      2    

; OPERATOR 2 PARAMETERS
f13 0 32    -2             
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
                        65      2       99      55      38      99      91      58      0       0     
;AMS      FIXED?   FREQ   DET    RSC
                        3       0       4.86    +3      0    

; OPERATOR 3 PARAMETERS
f14 0 32    -2 
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
                        99      3       83      33      71      40      99      0       0       0     
;AMS      FIXED?   FREQ   DET    RSC
                        3       0       .5      -3      2    

; OPERATOR 4 PARAMETERS
f15 0 32    -2         
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
                        75      2       99      75      43      28      99      77      84      0    
;AMS      FIXED?   FREQ   DET    RSC
                        3       0       4       +3      2    

; OPERATOR 5 PARAMETERS
f16 0 32    -2 
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
                        92      4       85      33      71      51      99      0       0       0     
;AMS      FIXED?   FREQ   DET    RSC
                        3       0       1       -2      2    

; OPERATOR 6 PARAMETERS
f17 0 32    -2 
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
                        77      2       99      72      25      99      99      77      99      89   
;AMS      FIXED?   FREQ   DET    RSC
                        3       0       7.21    +7      1    

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
t       0.000   98.000
i1.00  0.000  1.038  53     64     0      0      0      0    
       12     13     14     15     16     17     2      8000 
       3      8      4      6      10     9      11     7   
i1.00  0.500  1.196  60     55  
i1.01  1.000  2.121  67     66  
i1.02  1.500  0.979  69     76  
i1.03  2.500  0.517  72     81  
i1.04  3.000  0.592  76     92  
i1.05  3.500  0.550  77     79  
i1.06  4.000  1.054  70     70  
i1.07  4.000  0.542  53     64  
i1.08  4.500  0.504  62     51  
i1.09  5.000  1.542  67     52  
i1.10  5.500  0.312  72     47  
i1.11  6.000  0.346  81     83  
i1.12  6.000  0.321  72     91  
i1.13  6.500  0.258  72     72  
i1.14  6.500  0.242  82     79  
i1.15  7.000  0.679  64     60  
i1.16  7.000  0.883  72     61  
i1.17  7.000  0.454  79     80  
i1.18  7.500  0.483  81     78  
i1.19  8.000  0.508  53     59  
i1.20  8.000  0.654  72     66  
i1.21  8.000  0.900  77     79  
i1.22  8.500  0.571  60     50  
i1.23  9.000  2.508  67     57  
i1.24  9.500  1.029  69     73  
i1.25  10.500 0.454  72     63  
i1.26  11.000 0.504  76     74  
i1.27  11.500 0.504  77     73  
i1.28  12.000 0.679  53     59  
i1.29  12.000 0.996  70     62  
i1.30  12.500 0.496  62     52  
i1.31  13.000 1.538  67     56  
i1.32  13.500 0.262  72     43  
i1.33  14.000 0.338  81     85  
i1.34  14.000 0.312  72     87  
i1.35  14.500 0.217  72     75  
i1.36  14.500 0.242  82     83  
i1.37  15.000 0.696  64     73  
i1.38  15.000 0.933  72     70  
i1.39  15.000 0.467  79     78  
i1.40  15.500 0.479  81     71  
i1.41  16.000 0.617  72     32  
i1.42  16.000 0.750  53     63  
i1.43  16.000 0.825  77     81  
f0  17
e
