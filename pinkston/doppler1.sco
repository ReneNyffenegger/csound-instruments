f1  0 8192  10    1     .3    .1 
f2  0 8192  20    2  
;distance control functions
f5  0 129   7     0     129   1 
f6  0 129   7     1     129   0 
f7  0 128   7     100   64    1     64    100 
;x function
f8  0 3     2     1     1     1   
;y function
f9  0 129   7     10    128   -10
;	st	dur	mindst	maxdst	distfn
i50 0  10     1      100    7  
s
f0  1
s
;
i50 0  10     1      500    7  
s
f0  1
s
;	st	dur	xmax	ymax	xfn	yfn
i51 0  10     5      100    8      9    
s
f0  1
s
;x function
f8  0 129   5     25    64    5     64    25 
;	st	dur	xmax	ymax	xfn	yfn
i51 0  10     25     500    8      9    
