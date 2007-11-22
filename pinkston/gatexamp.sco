;a sine wave
f01 0 512   10    1  
;oscil function a
f02 0 512   10    1     .1    0     .05 
;Try these, as well:
;f02	0	512	10	1	.9	.8	.7	.6	.5	.4	.3	.2	.1
;f02	0	512	9	8	1	0
;oscil function b
f03 0 512   10    0     1     0     .2    0     0     0     .1  
;nn	st	dur	amp	pch	modamp	modhz	modfn	oscfna	oscfnb
i01 0  3      10000  8.00   .5     .25    1      2      3    
i01 +  .      .      .      .      .5   
i01 .  .      .      .      .      1    
i01 .  .      .      .      .      2    
i01 12 5      5000   6.07   .5     .67 
i . .  .      .      8.02   .      .72  
i . .  .      .      8.03   .      .83  
i . .  .      .      8.10   .      .91  
e
