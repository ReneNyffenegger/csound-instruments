;Test score for Schdgran.orc. 
f1  0 8192  10    1  
;dur func 
f2  0 513   7     .021  256   .2    257   .021	
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
;no change function
f8  0 2     2     1     1   
;linear rise
f9  0 513   7     0     513   1 
;linear decay
f10 0 513   7     1     513   0 
;.25 sine
f11 0 513   9     .25   1     0   
;	st	dur	pkamp	pchvar	maxden	maxdur	insno	rndoff	rpitmax	tptfn	begpt	endpt
i01 0  10     13000  3      100    .2     2      25     .5     9      0      1       
;	ampfn	denfn	durfn	pchfn	rpchfn	panfn
                        3       6       2       4       7       5     
;	st	dur	pkamp	pchvar	maxden	maxdur	insno	rndoff	rpitmax	tptfn	begpt	endpt
i01 10 10     40000  4      150    .2     3      50     .125   9      0      1    
;	ampfn	denfn	durfn	pchfn	rpchfn	panfn
                        3       6       2       4       7       5     
;	st	dur	pkamp	pchvar	maxden	maxdur	insno	rndoff	rpitmax	tptfn	begpt	endpt
i01 20 10     9500   2      200    .08    3      25     0      11     0      1    
;	ampfn	denfn	durfn	pchfn	rpchfn	panfn
                        8       8       8       8       8       5     