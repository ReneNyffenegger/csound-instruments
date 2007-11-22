;Test score for wgplucks.orc
f1  0 8192  10    1  
;linear decay function
f2  0 513   7     1     513   0 
;exponential decay function
f3  0 513   5     1     513   .001 
;test some wgplucks with idamp = 10, ifilt = 1000
;nn	st	dur	amp	pch	ipick	iplk	idamp	ifilt
i10 0  3      120    7.09   .5     0      10     1000
i10 +  .      .      .      .      .5   
i10 +  .      .      .      .25    0  
i10 +  .      .      .      .      .5   
i10 +  .      .      .      .125   0 
i10 +  .      .      .      .      .5   
f0  19
s
;test some wgplucks with idamp = 30, ifilt = 10
;nn	st	dur	amp	pch	ipick	iplk	idamp	ifilt
i10 0  2      120    7.09   .5     0      30     10  
i10 +  .      .      .      .      .5   
i10 +  .      .      .      .25    0  
i10 +  .      .      .      .      .5   
i10 +  .      .      .      .125   0 
i10 +  .      .      .      .      .5   
f0  13
s
;test wgpluck2 with various pickup positions and absorption factors
;Note how wgpluck2 and repluck both seem slightly out of tune (flat)
;nn	st	dur	amp	pch	ipick	iplk	iabsor
i11 0  3      20000  7.09   .5     0      .75  
i11 +  4      .      .      .      .      .65  
i11 +  6      .      .      .      .      .5   
i11 +  3      40000  7.09   .25    .      .75  
i11 +  4      .      .      .      .      .65  
i11 +  6      .      .      .      .      .5   
i11 +  3      80000  7.09   .125   .      .75  
i11 +  4      .      .      .      .      .65  
i11 +  6      .      .      .      .      .5   
i11 +  3      .      7.09   .05    .      .75  
i11 +  4      .      .      .      .      .65  
i11 +  6      .      .      .      .      .5   
f0  53
s
;nn	st	dur	amp	pch	ipick	iplk	iabsor	iplkhz	iplkris	iplkdec
i12 0  6      30000  7.09   .9     .1     .75    12     .001   .01
i12 +  .      .      .      .      .25  
i12 +  .      .      .      .      .45  
s
;nn	st	dur	amp	pch	ipick	iplk	iabsor	iplkhz	iplkris	iplkdec
i12 0  6      30000  7.09   .9     .1     .65    12     .001   .01
i12 +  .      .      .      .      .25  
i12 +  .      .      .      .      .45  
s
;nn	st	dur	amp	pch	ipick	iplk	iabsor	iplkhz	iplkris	iplkdec
i12 0  6      30000  7.09   .9     .1     .55    12     .001   .01
i12 +  .      .      .      .      .25  
i12 +  .      .      .      .      .45  
s
;nn	st	dur	amp	pch	ipick	iplk	iabsor	iplkhz	iplkris	iplkdec
i12 0  6      20000  7.09   .9     .05    .65    12     .001   .01
i12 .02       .      .      8.00     
i12 6  .      18000  7.09   .      .    
i12 6.02      .      .      8.02     
i12 12 8      15000  7.09   .      .    
i12 12.005    .      .      8.04 
i12 12.01     .      .      8.11 
i12 12.023    .      18000  7.02
e
