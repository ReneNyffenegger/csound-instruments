;global amp control function
f01 0 8192  7     .5    4096  1     4096  .5
;global pan control function
f02 0 8192  7     .5    2048  1     4096  0     2048  .5
;soundin data table
f03 0 16    -2    4     0   
;	snd#	dur
                        36      .176    ;bass drum
                        37      1.291   ;bell (53)
                        38      .142    ;high hat (42)
                        39      1.128   ;tom tom (43)
;global sends instrument (run always to zero global sends variables)
i01 0  10
;global control instrument 
;	st	dur	maxval1	func1	maxval2	func2
i02 0  10     1      1      1      2    
;schedule instrument
;	st	dur	amp	evthz	table	seed	insno	idry	isend1	isend2	
i03 0  10     1      8      3      .531   11     1      0      0    
s
f0  1
s
;Play it again with reverb
;global sends instrument (run always to zero global sends variables)
i01 0  13
;global control instrument 
;	st	dur	maxval1	func1	maxval2	func2
i02 0  10     1      1      1      2    
;schedule instrument
;	st	dur	amp	evthz	table	seed	insno	idry	isend1	isend2	
i03 0  10     1      8      3      .135   11     .8     0      .2   
;	st	dur	gain	rvt	diff
i52 0  13     .5     2      .25  
s
f0  1
s
;Now try some slapback delay in the opposite channel
;global pan control function
f02 0 2     -2    1     1   
;global sends instrument (run always to zero global sends variables)
i01 0  12
;global control instrument 
;	st	dur	maxval1	func1	maxval2	func2
i02 0  10     1      1      1      2    
;schedule instrument
;	st	dur	amp	evthz	table	seed	insno	idry	isend1	isend2	
i03 0  10     1      8      3      .351   11     .8     .6     0   
;	st	dur	idel1	ilvl1	ipan1	ifeed1	idel2	ilvl2	ipan2	ifeed2	isend2
i51 0  12     .125   .25    .35    .5     .5     .125   0      .5     0   
s
f0  1
s
;Delay plus reverb
;global sends instrument (run always to zero global sends variables)
i01 0  15
;global control instrument 
;	st	dur	maxval1	func1	maxval2	func2
i02 0  10     1      1      1      2    
;schedule instrument
;	st	dur	amp	evthz	table	seed	insno	idry	isend1	isend2	
i03 0  10     1      8      3      .555   11     .8     .6     .2  
;	st	dur	idel1	ilvl1	ipan1	ifeed1	idel2	ilvl2	ipan2	ifeed2	isend2
i51 0  12     .125   .25    .35    .5     .5     .125   0      .5     .2  
;	st	dur	gain	rvt	diff
i52 0  15     .125   2      .25  
e
