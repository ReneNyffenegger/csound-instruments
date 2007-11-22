;generate a set of cosine partials
f01 0 8192  11    32 
;the bw control function (exponential)
f02 0 513   5     .01   256   1     257   .01
;the cf control function (linear)
f03 0 513   7     0     256   1     257   0 
;nn	st	dur	amp	pch	bwmin	bwvar	oscfn	bwfn
i01 0  4      20000  8.00   0      2500   1      2    
;nn	st	dur	amp	pch	cf1	cfvar	Q	oscfn	cffn
i02 5  4      20000  8.00   7.00   4      2      1      3    
;nn	st	dur	amp	pch	cf1	cfvar	Q	oscfn	cffn
i03 10 4      20000  8.00   7.00   4      6      1      3    
e
