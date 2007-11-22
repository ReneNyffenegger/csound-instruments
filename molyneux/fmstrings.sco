;=======================================================================;
; FMSTRINGS       Score for FM Strings based on Dodge coded by Molyneux ;
;=======================================================================;
; p6     =        relative index level                                  ;
; p7     =        code for envelope rise and fall times                 ;
;                    1 = fast rise/fast fall, 2 = fast rise/slow fall   ;
;                    3 = slow rise/fast fall, 4 = slow rise/slow fall   ;
; p8     =        code for index envelope rise time                     ;
;                    0 = fast, 1 = slow                                 ;
;=======================================================================;
; sine
f1  0 512   10    1  
; linear rise
f2  0 513   7     0     513   1 
; linear fall
f3  0 513   7     1     513   0 
; attack function for vibamp
f4  0 513   7     0     400   1     113   .8 
; attack function for vibamp
f5  0 513   7     0     200   .56   250   1     63    .85 
; index rise function
f6  0 513   5     .001  62    .95   61    .55   200   1     190   .86
; attack function
f7  0 513   5     .001  200   .95   156   .7    157   1 
;=========================================================================;
; FMSTRINGS            p4      p5       p6      p7      p8                ;
;                      amp     pch      relndx  eg#     ndxeg             ;
;=========================================================================;
i1  0.00      5.02   7234   8.10   1      2      1    
i1  0.01      5.06   7394   8.11   1      2      1    
i1  0.02      5.04   7791   8.05   1      2      1    
i1  0.04      5.00   7891   8.04   1      2      1    
i1  4.25      5.08   9169   9.01   .5     4      0    
i1  4.26      5.06   8786   8.05   .5     4      0    
i1  4.27      5.04   8786   8.11   .5     4      0    
i1  4.29      5.07   8786   8.02   .5     4      0    
i1  8.52      6.61   7394   8.01   .7     2      1    
i1  8.62      6.39   8063   8.05   .7     2      1    
i1  8.65      6.40   8163   8.10   .7     2      1    
i1  8.69      6.45   9772   9.04   .7     2      1    
e
