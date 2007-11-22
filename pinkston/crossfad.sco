;sine wave
f01 0 8192  10    1  
f02 0 8192  10    1     0     .5    0     .25   0     .125
f03 0 8192  9     11    1     0     12    1     0     13    1     0     14    1     0   
f04 0 8192  10    0     1   
;Left to right gating function
f05 0 513   7     1     513   0 
;right to left
f06 0 513   7     0     513   1 
;back and forth
f07 0 513   7     0     256   1     257   0 
;nn	st	dur	amp	pch	rise	decay	ifna	ifnb	igatefn
i01 0  2      20000  9.00   .1     .5     1      2      7    
i01 +  .      .      7.00   .      .      .      3    
i01 +  .      .      9.01   .      .      .      4    
