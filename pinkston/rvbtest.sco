;One test with original Csound reverb unit
;nn	st	dur	dryfac	wetfac	iskip
i01 0  3      .75    .25    0  
;nn	st	dur	scale	rvt	istor	flag
i02 0  6      .4     2      0      1    
s
;Four tests with reverb2 - gradually increase diffusion
;nn	st	dur	dryfac	wetfac	iskip
i01 0  3      .75    .25    0  
;nn	st	dur	scale	rvt	diff	istor	flag
i03 0  6      .5     2      0      0      1    
s
;nn	st	dur	dryfac	wetfac	iskip
i01 0  3      .75    .25    0  
;nn	st	dur	scale	rvt	diff	istor	flag
i03 0  6      .5     2      .3     0      1    
s
;nn	st	dur	dryfac	wetfac	iskip
i01 0  3      .75    .25    0  
;nn	st	dur	scale	rvt	diff	istor	flag
i03 0  6      .5     2      .6     0      1    
s
;nn	st	dur	dryfac	wetfac	iskip
i01 0  3      .75    .25    0  
;nn	st	dur	scale	rvt	diff	istor	flag
i03 0  6      .5     2      .9     0      1    
e
