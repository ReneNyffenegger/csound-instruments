;oscil wave shape
f01 0 8192  10    1     .5  
;linear ramp for port
f02 0 8193  7     0     8193  1
;pure sine
f03 0 8192  10    1        
;	st	dur	amp	pch	prevpch	rate
i01 0  2      10000  8.00   8.00   1 
i01 +  .      .      8.03   pp5
i01 +  .      .      8.07 
i01 +  6      .      7.07    
s
f0  1
s
; test instr 2
;	st	dur	amp	pch	prevpch	rate	iportfn	idelay
i02 0  2      10000  8.00   8.00   1      2      0    
i02 +  .      .      8.03   pp5    .      .      .5   
i02 +  .      .      8.07   .      .      .      1    
i02 +  6      .      7.07   .      .      .      2    
s
f0  1
s
; test instr 3
;	st	dur	amp	pch	prevpch	rate	iportfn	idelay	ivibwth	ivibrte	ivibfn	ivibdel
i03 0  2      10000  8.00   8.00   1      2      0      .04    6.5    3      1    
i03 +  .      .      8.03   pp5    .      .      .5   
i03 +  .      .      8.07   .      .      .      1    
i03 +  6      .      7.07   .      .      .      2    
s
f0  1
s
;try a legato phrase
;	st	dur	amp	pch	prevpch	rate	envdur
i04 0  2      10000  8.00   8.00   1      12   
i04 +  .      .      8.03   pp5    .      -1   
i04 +  .      .      8.07 
i04 +  6      .      7.07 
s
f0  1
s
; test instr 5
;	st	dur	amp	pch	prevpch	rate	iportfn	idelay	ivibwth	ivibrte	ivibfn	ivibdel	
i05 0  2      10000  8.00   8.00   1      2      0      .04    6.5    3      1    
;	carfac	modfac	indvar	index1	indris	indec
                        5       4       5       1       .5      1    
i05 +  .      .      8.03   pp5    .      .      .5   
i05 +  .      .      8.07   .      .      .      1    
i05 +  6      .      7.07   .      .      .      2    
