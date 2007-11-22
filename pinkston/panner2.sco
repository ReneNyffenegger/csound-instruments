;sine wave
f01 0 8192  10    1  
;Left to right panning function
f02 0 513   7     1     513   0 
;right to left
f03 0 513   7     0     513   1 
;back and forth
f04 0 513   7     0     256   1     257   0 
;nn	st	dur	amp	pch	rise	decay	ifn	ipanfn
i01 0  2      20000  9.00   .1     .5     1      2    
i01 +  .      .      8.11   .      .      .      3    
i01 +  .      .      9.01   .      .      .      4    
