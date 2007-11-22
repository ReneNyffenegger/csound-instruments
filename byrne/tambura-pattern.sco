; CREATED BY:PER BYRNE VILLEZ    hbyrne@pavilion.co.uk

; SCORE INITIALIZATION
;SEE FOF/SAMPLE A PRIMER OR CSOUND MANUAL 


f1  0 32768 1     "tambura.aif"     0     0     0   
f2  0 32768 1     "tambura.aif"     .01   0     0   
f19 0 1024  19    .5    .5    270   .5

; score 
;   start idur  ifq       ;typical 'tampura pattern'
i1  0  10     123.47
i1  .6 7      185  
i1  1.2       17     183       
i1  1.8       10     123.47    
i1  6  7      185.47
i1  6.1       8.9    164.81
i1  6.2       8.8    162
i1  6.3       10.7   123.47
e

