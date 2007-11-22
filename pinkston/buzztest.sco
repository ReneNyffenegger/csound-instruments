;large sine wave table for buzz
f01 0 8192  10    1  
;large cosine wave table for gbuzz
f02 0 8192  9     1     1     90  
;test buzz instrument
;nn	st	dur	amp	pch	nh
i01 0  10     20000  6.00   30
s
;test gbuzz instrument
;first, just vary nh over time
;nn	st	dur	amp	pch	nhmin	nhmax	rmin	rmax
i02 0  10     20000  6.00   1      50     1      1      1    
;next, just vary r factor over time
i . +  .      .      .      50     50     .25    1  
;finally, vary both nh and r
i . +  .      .      .      1      50     .25    1  
;min partial number is p10
i . +  .      .      .      .      42     .      .      8    
e
