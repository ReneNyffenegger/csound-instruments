;test score for scorefun.orc. 
f1  0 8192  10    1  
;dur func 
f2  0 513   -7    .021  256   .2    257   .021	
;amp func
f3  0 513   5     1     256   .125  128   .5    127   .1
;pch func (exponential rise of 3 octaves)
f4  0 513   5     .25   513   1 
;pan func (offset cosine wave)
f5  0 513   19    1     1     90    1  
;density func (hamming window - bell shaped)
f6  0 513   20    1  
;random pitch deviation
f7  0 513   7     0     256   1     257   0 
;	st	dur	pkamp	pchvar	maxden	insno	rndoff	rndpitmax
i01 0  30     10000  3      100    2      25     .5  
;	st	dur	pkamp	pchvar	maxden	insno	rndoff	rndpitmax
i01 30 30     20000  3      100    3      0      .5   