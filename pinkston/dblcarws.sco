;=========================================================================;
; =========  Score for Multi-Carrier Waveshaping Instrument =========     ;
;                                                                         ;
;=========================================================================;
; Sine table
f1  0 512   10    1  
; LFO gating function (Hamming Window)
f3  0 512   20    1  
; transfer function1:  h0 h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12 h13 h14 h15 h16
f04 0 513   13    1     1     0     1     -.8   0     .6    0     0     0     .4    0     0     0     0     .1    -.2 -.3 .5
; normalizing function with midpoint bipolar offset:
f05 0 257   4     4     1   
;Gate with carrier * 3
;	st	dur	pch	amp	wsfn	nmfn	ndxris	ndxdec 	c1	c2	    ifn
i10 0  4      5.00   10000  4      5      2      2      1      3      1    
i10 4  .      6.00   .      .      .      .      .      .      .      .    
i10 8  .      7.00   . 
s
;gate with carrier * 1.083 (up one semitone)
;	st	dur	pch	amp	wsfn	nmfn	ndxris	ndxdec 	c1	c2	    ifn
i10 0  4      6.00   10000  4      5      2      2      1      1.083  1
i10 4  .      7.00   . 
i10 8  .      8.00   . 
s
;gate with carrier * 1.25 (up minor third)
;	st	dur	pch	amp	wsfn	nmfn	ndxris	ndxdec 	c1	c2	    ifn
i10 0  4      6.00   10000  4      5      2      2      1      1.25   1 
i10 4  .      7.00   . 
i10 8  .      8.00   . 
s
;gate with carrier * 8 (up 3 octaves)
;	st	dur	pch	amp	wsfn	nmfn	ndxris	ndxdec 	c1	c2	    ifn
i10 0  4      5.00   10000  4      5      2      2      1      8      1    
i10 4  .      6.00   . 
i10 8  .      7.00   . 
s
;gate with carrier * 2.82843 (up octave + tritone)
;	st	dur	pch	amp	wsfn	nmfn	ndxris	ndxdec 	c1	c2	    ifn
i10 0  4      6.00   10000  4      5      2      2      1      2.82843       1     
i10 4  .      7.00   . 
i10 8  .      8.00   . 
s
;Gate with carrier * 3
;	st	dur	pch	amp	wsfn	nmfn	ndxris	ndxdec 	c1	c2	    ifn
i11 0  4      5.00   20000  4      5      2      2      1      3      1    
; 	lfohz	depth	lfofn	rndhz	rndfac	seed
                        8       .5      3       3       .5      .6574
i11 4  .      6.00   .      .      .      .      .      .      .      .    
                        .       .       .       .       .       -1    
i11 8  .      7.00   . 
s
;gate with carrier * 1.083 (up one semitone)
;	st	dur	pch	amp	wsfn	nmfn	ndxris	ndxdec 	c1	c2	    ifn
i11 0  4      6.00   20000  4      5      2      2      1      1.083  1
; 	lfohz	depth	lfofn	rndhz	rndfac	seed
                        8       .5      3       3       .5      -1   
i11 4  .      7.00   . 
i11 8  .      8.00   . 
s
;gate with carrier * 1.25 (up minor third)
;	st	dur	pch	amp	wsfn	nmfn	ndxris	ndxdec 	c1	c2	    ifn
i11 0  4      6.00   20000  4      5      2      2      1      1.25   1 
; 	lfohz	depth	lfofn	rndhz	rndfac	seed
                        8       .5      3       3       .5      -1   
i11 4  .      7.00   . 
i11 8  .      8.00   . 
s
;gate with carrier * 8 (up 3 octaves)
;	st	dur	pch	amp	wsfn	nmfn	ndxris	ndxdec 	c1	c2	    ifn
i11 0  4      5.00   20000  4      5      2      2      1      8      1    
; 	lfohz	depth	lfofn	rndhz	rndfac	seed
                        8       .5      3       3       .5      -1   
i11 4  .      6.00   . 
i11 8  .      7.00   . 
s
;gate with carrier * 2.82843 (up octave + tritone)
;	st	dur	pch	amp	wsfn	nmfn	ndxris	ndxdec 	c1	c2	    ifn
i11 0  4      6.00   20000  4      5      2      2      1      2.82843       1     
; 	lfohz	depth	lfofn	rndhz	rndfac	seed
                        8       .5      3       3       .5      -1   
i11 4  .      7.00   . 
i11 8  .      8.00   . 
e
