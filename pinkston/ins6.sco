;Test Score for Pinkston Complex Instrument 6 (3-part gesture)
;Oscil wave shape for Part 1													
f1  0 8192  10    1        								
;Oscil wave shape for part 2													
f2  0 8192  10    1     0     .25   0     .125 					
;Hamming Window function for lfo gating													
f3  0 8192  20    1        								
;fixed center panning function (.5 constant)													
f4  0 3     -7    .5    3     .5    						
;pan left to right													
f5  0 129   7     1     129   0   						
;pan right to left													
f6  0 129   7     0     129   1   						
;pan center to left to right to center													
f7  0 129   7     .5    32    1     64    0     33    .5   		
;	st	dur	amp	pch1	pch3	seeds	dur facs	min	max	oct	pan		
;						pt1	pt2	pt1	pt2	dur	N	rng	fn
i6  0  10     32000  9.00   8.11   .4     .3     .4     .035   .04    4      1      4    
i6  4  10     30000  9.08   7.09   .2     .1     .4     .05    .05    5      2      7    
i6  8  10     26000  7.06   9.01   .8     .7     .4     .1     .06    7      3      6    
i6  9  9      .      8.09   8.03   .6     .51    .3     .2     .06    4      3      5    
e

