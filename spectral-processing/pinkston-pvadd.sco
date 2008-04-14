f01 0 8192  10    1  
;pvoc."gong3.pvx" is gong3.aif analyzed with -n1024 -w8
;pvoc."kalimba-low.pvx" is kalimba low.aif analyzed with -n1024 -w8
;	st	dur	ilength	gaindb	ishift	file	nbins	bin1	incr
i01 0  10     2.5    0      1      "gong3.pvx"   100    1      1    
i01 10 .      .      18     .      .      .      30   
i01 20 .      .      .      .      .      25     30  
s
i01 0  10     2.5    18     .5     "gong3.pvx"   10     25     1   
i01 10 .      .      10     .      .      .      20   
s
;	st	dur	len	gaindb	ishift	file	nbins	bin1	incr
i01 0  10     2.5    12     .5     "gong3.pvx"   50     10     2   
i01 +  .      .      12     .      .      .      .      5    
i01 +  .      .      16     .      .      .      .      10   
i01 +  .      .      20     .      .      .      .      15   
s
f0  2
s
f02 0 1025  9     .25   1     0   
f03 0 1025  9     .25   1     90  
;	st	dur	len1	dur1	time1	gain1	ishift1	file1	nbins1	1bin1	incr1
i02 0  10     2.5    0      0      6      .5     "gong3.pvx"   50     10     2   
;			len2	dur2	time2	gain2	ishift2	file2	nbins2	1bin2	incr2	env1	env2
                        1.5     .1      .1      -1      1       "kalimba-low.pvx"       50      1       1       2       3     
e
