;============================================================================
; CONTRABASS - ALGORITHM #15
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
                        99      1       56      30      25      27      99      92      90      0    
;AMS      FIXED?   FREQ   DET    RSC
                        0       0       1       0       2     

; OPERATOR 2 PARAMETERS
f13 0 32    -2             
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
                        63      0       67      20      27      32      92      95      95      0    
;AMS      FIXED?   FREQ   DET    RSC
                        0       0       4       0       1     

; OPERATOR 3 PARAMETERS
f14 0 32    -2 
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
                        99      1       56      29      35      50      99      93      95      0    
;AMS      FIXED?   FREQ   DET    RSC
                        0       0       1       0       0     

; OPERATOR 4 PARAMETERS
f15 0 32    -2         
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
                        99      2       99      19      20      39      82      89      89      0    
;AMS      FIXED?   FREQ   DET    RSC
                        0       0       1       0       2     

; OPERATOR 5 PARAMETERS
f16 0 32    -2 
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
                        75      1       97      35      38      37      99      99      99      0    
;AMS      FIXED?   FREQ   DET    RSC
                        0       0       1       0       2     

; OPERATOR 6 PARAMETERS
f17 0 32    -2 
;OUTLVL   KEYVEL   EGR1   EGR2   EGR3   EGR4   EGL1   EGL2   EGL3   EGL4
                        37      7       67      71      44      37      99      92      71      0    
;AMS      FIXED?   FREQ   DET    RSC
                        0       0       5       0       2     

;====================================================================;
;                       Yamaha DX7 Algorithm 15                      ;
;                                                                    ;
;    p02 = start     p03 = dur       p04 = pch       p05 = vel       ;
;    p06 = panfac    p07 = vibdel    p08 = vibwth    p09 = vibhz     ;
;    p10 = op1fn     p11 = op2fn     p12 = op3fn     p13 = op4fn     ;
;    p14 = op5fn     p15 = op6fn     p16 = ampfn     p17 = pkamp     ;
;    p18 = rsfn      p19 = devfn     p20 = erisfn    p21 = edecfn    ;
;    p22 = vsfn      p23 = velfn     p24 = feedfn    p25 = feedbk    ;
;                    p26 = Algorithm Number (Disabled)               ;
;====================================================================;
t       0.000   65.000
i1.00  0.000  1.485  65     57     0      0      0      0    
       12     13     14     15     16     17     2      10000
       3      8      4      6      10     9      11     7   
i1.01  1.500  0.233  60     65  
i1.02  1.750  0.231  65     60  
i1.03  2.000  1.119  69     56  
i1.04  3.000  0.967  65     68  
i1.05  4.000  1.427  77     75  
i1.06  5.500  0.267  79     54  
i1.07  5.750  0.287  77     56  
i1.08  6.000  1.890  72     48  
i1.09  8.000  1.523  74     66  
i1.10  9.500  0.285  72     53  
i1.11  9.750  0.321  70     43  
i1.12  10.000 1.019  72     59  
i1.13  11.000 1.083  65     45  
i1.14  12.000 0.087  69     33  
i1.15  12.000 1.421  70     72  
i1.16  13.500 0.260  67     50  
i1.17  13.750 0.298  65     38  
i1.18  14.000 1.833  67     48  
i1.19  16.000 4.052  65     44  
f0  21
e
