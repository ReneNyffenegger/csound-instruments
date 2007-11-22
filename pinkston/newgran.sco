; f statements read sound files in the SSDIR 
; directory into f-table 1, 2, 3
f1  0 524288      1     "abuzz2-44.wav"   0     0     0   
f2  0 524288      1     "endless6.wav"    0     0     0   
f3  0 131072      1     "thewind.wav"     0     0     0   
; various control functions for gap and size
; linear ramp down
f4  0 129   7     1     129   0 
; linear ramp up
f5  0 129   7     0     129   1 
; pyramid
f6  0 129   7     0     64    1     65    0  
; inverse pyramid
f7  0 129   7     1     64    0     65    1  
; hanning window
f8  0 129   20    2  
; no change function
f9  0 2     2     1     1   
;Run tests with three sampled sounds (ifn = 1, 2, 3)
;Sound One
;Test with vary gap and size, but no randomness or pitch shift
;	st 	dur	amp	nvoice	ratio	mode	thresh	 
i2  0  14     5000   32     1      1      0       
;	ifn	flen	pshifts	skip1	rndoff	mingap	gapoff%
                        1       10      4       0       0.05    0.01    0	
;	minsize	sizoff%	att%	dec%	iseed	pit1	pit2	
                        0.02    0       30      30      0.13    1       1     
;	pit3	pit4	maxgap	gapfn	maxsize	sizefn
                        1       1       .2      7       .5      7    
;Sound Two
;	st 	dur	amp	nvoice	ratio	mode	thresh 	
i2  +  .      2000   .      .      .      .       
;	ifn	flen	
                        2       10	
;Sound Three
;	st 	dur	amp	nvoice	ratio	mode	thresh 	
i2  +  15     4000   32     .15    1      0	  
;	ifn	flen
                        3       1.627 
s
;Same as previous with gapoff and sizoff % of 50 
;Sound One
;	st 	dur	amp	nvoice	ratio	mode	thresh	 
i2  0  14     5000   32     1      1      0       
;	ifn	flen	pshifts	skip1	rndoff	mingap	gapoff%
                        1       10      4       0       0.05    0.01    50	
;	minsize	sizoff%	att%	dec%	iseed	pit1	pit2	
                        0.02    50      30      30      0.13    1       1     
;	pit3	pit4	maxgap	gapfn	maxsize	sizefn
                        1       1       .2      7       .5      7    
;Sound Two
;	st 	dur	amp	nvoice	ratio	mode	thresh 	
i2  +  .      2000   .      .      .      .       
;	ifn	flen	
                        2       10	
;Sound Three
;	st 	dur	amp	nvoice	ratio	mode	thresh 	
i2  +  15     4000   32     .15    1      0	  
;	ifn	flen
                        3       1.627 
s
;Same as previous with 4 different pitches
;Sound One
;	st 	dur	amp	nvoice	ratio	mode	thresh	 
i2  0  14     5000   32     1      1      0       
;	ifn	flen	pshifts	skip1	rndoff	mingap	gapoff%
                        1       10      4       0       0.05    0.01    50	
;	minsize	sizoff%	att%	dec%	iseed	pit1	pit2	
                        0.02    50      30      30      0.13    1       .5    
;	pit3	pit4	maxgap	gapfn	maxsize	sizefn
                        2       .25     .2      7       .5      7    
;Sound Two
;	st 	dur	amp	nvoice	ratio	mode	thresh 	
i2  +  .      2000   .      .      .      .       
;	ifn	flen	
                        2       10	
;Sound Three
;	st 	dur	amp	nvoice	ratio	mode	thresh 	
i2  +  15     4000   32     .15    1      0	  
;	ifn	flen
                        3       1.627 
s
;Same as previous with random pitch shifting
;Sound One
;	st 	dur	amp	nvoice	ratio	mode	thresh	 
i2  0  14     5000   32     1      1      0       
;	ifn	flen	pshifts	skip1	rndoff	mingap	gapoff%
                        1       10      0       0       0.05    0.01    50	
;	minsize	sizoff%	att%	dec%	iseed	pit1	pit2
                        0.02    50      30      30      0.13    1       .5    
;	pit3	pit4	maxgap	gapfn	maxsize	sizefn
                        2       .25     .2      7       .5      7    
;Sound Two
;	st 	dur	amp	nvoice	ratio	mode	thresh 	
i2  +  .      2000   .      .      .      .       
;	ifn	flen	
                        2       10	
;Sound Three
;	st 	dur	amp	nvoice	ratio	mode	thresh 	
i2  +  15     4000   32     .15    1      0	  
;	ifn	flen
                        3       1.627 
s
;Fix basic gap and size, slight detunings, 50% random gap and size
;Sound One
;	st 	dur	amp	nvoice	ratio	mode	thresh	 
i2  0  14     5000   32     1      1      0       
;	ifn	flen	pshifts	skip1	rndoff	mingap	gapoff%
                        1       10      4       0       .01     0.001   50	
;	minsize	sizoff%	att%	dec%	iseed	pit1	pit2
                        0.001   50      30      30      0.13    1       1.001 
;	pit3	pit4	maxgap	gapfn	maxsize	sizefn
                        1.002   .999    .01     9       .04     9   
;Sound Two
;	st 	dur	amp	nvoice	ratio	mode	thresh 	
i2  +  .      2000   .      .5     .      .	  
;	ifn	flen	
                        2       10	
;Sound Three
;	st 	dur	amp	nvoice	ratio	mode	thresh 	
i2  +  13     4000   32     .15    1      0	  
;	ifn	flen
                        3       1.627 
e

