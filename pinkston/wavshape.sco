;=========================================================================;
; =========  Score for General Purpose Waveshaping Instrument =========   ;
;                                                                         ;
; This demonstrates the use of high partials, sometimes without a         ;
; fundamental, to get quasi-inharmonic spectra from waveshaping.          ;
;=========================================================================;
; Sine table
f1      0 512 10 1
; transfer function1:  h0 h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12 h13 h14 h15 h16
f04     0  513 13 1 1  0  1 -.8 0 .6  0  0  0 .4  0  0   0   0   .1 -.2 -.3  .5
; normalizing function with midpoint bipolar offset:
f05     0       257     4       4       1
;	st	dur	pch	amp	wsfn	nmfn	ndxris	ndxdec
i9      0       4       5.00   10000	4	5	2	2
i9      4       .       6.00    .
i9      8       .       7.00    .

s
f0      1
s

; transfer function2:  h0 h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12 h13 h14 h15 h16
f04     0  513 13 1 1  0  0  0 -.1  0 .3  0 -.5 0 .7  0 -.9  0   1   0  -1   0
; normalizing function with midpoint bipolar offset:
f05     0       257     4       4       1
;	st	dur	pch	amp	wsfn	nmfn	ndxris	ndxdec
i9      0       4       5.00   10000	4	5	2	2
i9      4       .       6.00    .
i9      8       .       7.00    .

s
f0      1
s

; transfer function2:  h0 h1 h2 h3 h4 h5 h6 h7 h8 h9 h10 h11 h12 h13 h14 h15 h16
f04     0  513 13 1 1  0  0  0  0  0  0  0 -1  0  1  0   0   -.1 0   .1  0   -.2
;                      h17 h18 h19 h20 h21 h22 h23
                       .3  0   -.7 0   .2  0   -.1
; normalizing function with midpoint bipolar offset:
f05     0       257     4       4       1
;	st	dur	pch	amp	wsfn	nmfn	ndxris	ndxdec
i9      0       4       5.00   10000	4	5	2	2
i9      4       .       5.06    .
i9      8       .       6.00    .
s
f0	1
s
; This proves the statement in Dodge (p. 147) that Chebyshev polynomials
; of order K have "only the kth harmonic." This is only true when the 
; waveshaping index is at the maximum - i.e., when the entire transfer
; function is being accessed. RP.
;
; test four specific Chebyshev polynomials using gen03. The values were 
; obtained from Dodge p. 147.
;------------------------ functions by fgenie --------------------------------;
; First-order Chebyshev: x
f04	0	513	3	-1	1	0	1
; Normalizing function for fn4
f05	0	257	4	4	1
; Second-order Chebyshev: 2x2 - 1
f06	0.000 	513	3	-1	1	-1	0	2
; Normalizing function for fn6
f07	0	257	4	6	1
; Third-order Chebyshev: 4x3 - 3x
f08	0.000 	513	3	-1	1	0	-3	0	4
; Normalizing function for fn8
f09	0	257	4	8	1
; Seventh-order Chebyshev: 64x7 - 112x5 + 56x3 - 7x
f10	0.000 	513	3	-1	1	0	-7	0	56
	0	-112	0	64
; Normalizing function for fn10
f11	0	257	4	10	1
; four notes with same fundamental, different waveshape & normalizing functions
;	st	dur	pch	amp	wsfn	nmfn	ndxris	ndxdec
i9      0       4       8.00   10000	4	5	0	0
i9	+	.	.	.	6	7
i9      +       .       .	.	8	9
i9      +       .       .	.	10	11
s
f0	1
s
; Use a hand-drawn function created by FGenie
; Hand drawn ws func
f12	0	512	1	"drawn.fun"	0	0	1
; Normalizing function for f12
f13	0	256	4	12	1
;	st	dur	pch	amp	wsfn	nmfn	ndxris	ndxdec
i9      0       3       6.00	20000	12	13	1.5	1.5
i9	+	.	6.07
i9	+	6	7.00	15000	.	.	3	3
i9	+	.5	8.04	.	.	.	.5	0
i9	12.25	8	5.00	5000	.	.	6	2
i9	.	.	6.00
i9	.	.	7.07
i9	.	.	8.04
i9	.	.	8.06
i9	.	.	8.10
i9	.	.	9.03
e

