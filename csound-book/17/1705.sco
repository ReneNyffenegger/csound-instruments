;OSCIL WAVE SHAPE FOR PART 1                                                    
f 1 0 8192  10    1                                   
;OSCIL WAVE SHAPE FOR PART 2                                                    
f 2 0 8192  10    1     0     .25   0     .125                    
;HAMMING WINDOW FUNCTION FOR LFO GATING                                                 
f 3 0 8192  20    1                                   
;FIXED CENTER PANNING FUNCTION (.5 CONSTANT)                                                    
f 4 0 3     -7    .5    3     .5                          
;PAN LEFT TO RIGHT                                                  
f 5 0 129   7     1     129   0                           
;PAN RIGHT TO LEFT                                                  
f 6 0 129   7     0     129   1                           
;PAN CENTER TO LEFT TO RIGHT TO CENTER                                                  
f 7 0 129   7     .5    32    1     64    0     33    .5          

;       ST  DUR AMP     PCH1    PCH3    SEEDS   DUR FACS    MIN MAX OCT PAN     
;                       PT1 PT2 PT1 PT2 DUR N   RNG FN
i 1705 0      10     32000  9.00   8.11   .4     .3     .4     .035   .04    4      1      4    
i 1705 4      10     30000  9.08   7.09   .2     .1     .4     .05    .05    5      2      7    
i 1705 8      10     26000  7.06   9.01   .8     .7     .4     .1     .06    7      3      6    
i 1705 9      9      .      8.09   8.03   .6     .51    .3     .2     .06    4      3      5    
