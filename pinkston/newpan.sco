;lovely sound?
f01 0 16385 11    32 
;pan control function 1 (3 pan cycles)
f02 0 257   19    3     1     90    1  
;
f03 0 257   7     0     128   1     129   0 
;play two test notes
;			amp	pch	rise	dec	panfn	pandel
i01 0  6      20000  8.03   .5     1      2      0    
i01 8  .      .      8.05   .      .      3      2    
f0  20
s
;wave 1
f04 0 8192  10    1     .5  
;wave 2
f05 0 8192  10    0     .5    0     1   
;play two test notes
;			amp	pch	rise	dec	xfadfn	xfadel	wave1fn	wave2fn
i02 0  6      20000  7.07   .5     1      2      0      4      5    
i02 8  .      .      7.07   .      .      3      2    

