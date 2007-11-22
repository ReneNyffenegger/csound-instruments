;a sine wave
f01 0 512   10    1  
;oscil function a
f02 0 512   10    1     .1    0     .05 
;oscil function b
f03 0 512   10    0     1     0     .2    0     0     0     .1  
;nn	st	dur	amp	pch	modamp	modhz	modfn	oscfna	oscfnb	rndhz
i01 0  3      10000  8.00   .5     1      1      2      3      5    
i01 +  .      .      .      .      2    
i01 .  .      .      .      .      3    
i01 .  .      .      .      .      4    
i01 12 5      5000   6.07   .5     2   
i . .  .      .      8.02   .      2.5  
i . .  .      .      8.03   .      3    
i . .  .      .      8.10   .      3.5  
e
