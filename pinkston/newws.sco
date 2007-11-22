;=========================================================================;
; =========  Score for General Purpose Waveshaping Instrument =========   ;
;=========================================================================;
; Sine table
f1  0 512   10    1  

;Three hand-drawn waveshaping functions
f02 0 513   1     "ws1.fun"   0     0     0   
f03 0 513   1     "ws2.fun"   0     0     0   
f04 0 513   1     "ws3.fun"   0     0     0   
;simple tests with no normalization function
;nn	st	dur	amp	pch	wsfn	nrmfn
i01 0  4      20000  7.07   2      0    
i01 +  .      .      .      3    
i01 +  .      .      .      4    
s
f0  1
s
;Waveshaping function generated via Chebyshev polynomials of 1st kind (Gen 13)
f05 0.000   513   13    1     1     0     1     -0.5  -0.33
      0.25  0.2   -0.167      -0.142      0.125 .125  -.142 -.167 .2
                        .25     -.33    -.5     1   
;Normalizing function for above (mid-point bipolar offset specified)
f06 0 257   4     5     1   
;Waveshaping function generated via Gen03 - polynomial from Dodge Figure 4.29, p. 143
f07 0 513   3     -1    1     -.3   -.127 3.6   7.2   -17.44      -16  
      40.32 12.8  -43.52      0     20.48	
;Normalization function for above
f08 0 257   4     7     1   

;nn	st	dur	amp	pch	wsfn	nrmfn
i01 0  4      20000  7.07   5      6    
i01 +  .      .      8.07   7      8    
s
f0  1
s
;=========================================================================;
; This demonstrates the use of high partials, sometimes without a         ;
; fundamental, to get quasi-inharmonic spectra from waveshaping.          ;
;=========================================================================;
; transfer function1:  h0 h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12 h13 h14 h15 h16
f04 0 513   13    1     1     0     1     -.8   0     .6    0     0     0     .4    0     0     0     0     .1    -.2 -.3 .5
; normalizing function with midpoint bipolar offset:
f05 0 257   4     4     1   
;	st	dur	amp	pch	wsfn	nrmfn
i01 0  4      10000  5.00   4      5    
i01 4  .      .      6.00    
i01 8  .      .      7.00    

s
f0  1
s

; transfer function2:  h0 h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12 h13 h14 h15 h16
f04 0 513   13    1     1     0     0     0     -.1   0     .3    0     -.5   0     .7    0     -.9   0     1     0 -1 0
; normalizing function with midpoint bipolar offset:
f05 0 257   4     4     1   
;	st	dur	amp	pch	wsfn	nrmfn
i01 0  4      10000  5.00   4      5    
i01 4  .      .      6.00    
i01 8  .      .      7.00    

s
;f0      1
s

; transfer function2:  h0 h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12 h13 h14 h15 h16
f04 0 1025  13    1     1     0     0     0     0     0     0     0     -1    0     1     0     0     -.1   0     .1 0 -.2
;                      h17 h18 h19 h20 h21 h22 h23
                        .3      0       -.7     0       .2      0       -.1   
; normalizing function with midpoint bipolar offset:
f05 0 513   4     4     1   
;	st	dur	amp	pch	wsfn	nrmfn
i01 0  4      10000  5.00   4      5    
i01 4  .      .      5.06    
i01 8  .      .      6.00    
e

