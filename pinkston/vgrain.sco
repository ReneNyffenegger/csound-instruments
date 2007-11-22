;test score for vgrain.orc
f01 0 8192  10    1  
;hanning window func for grains
f02 0 8192  20    2  
;linear rise
f03 0 8193  7     0     8193  1
;linear decay
f04 0 8193  7     1     8193  0
;exponential rise
f05 0 8193  5     1     8193  100
;exponential decay
f06 0 8193  5     100   8193  1
;no-change function
f07 0 2     2     1     1   
;pyramid function
f08 0 8192  7     0     4096  1     4096  0
;steeper exponential rise
f09 0 8193  5     1     8193  500
;exponential pyramid
f10 0 8192  5     1     4096  100   4096  1
;sixteenth partial only
f11 0 8192  9     16    1     0   
;fund and 16th
f12 0 8192  9     1     1     0     16    1     0   
;8th and 9th partials only
f13 0 8192  9     8     1     0     9     1     0   
;cluster of inharmonic partials
f14 0 8192  9     1     1     0     1.13  1     0     1.219 1     0   
      1.317 1     0     1.471 1     0   
;cluster of high odd partials
f15 0 8192  9     27    1     0     29    1     0   
      31    1     0     33    1     0   
      35    1     0     37    1     0   
;sound file
f16 0 65536 1     "thewind1.wav"    0     0     0   
;1) Don't vary anything except the basic grain amplitude.
;Dens = 1000; grain dur = .01
;	st	dur	pkamp	cpitch	xdens	ampdev	pitdev	xdur	
i01 0  10     4000   8.00   1000   4000   100    .01	
;	wavefn	grainfn	xampfn	cpitfn	densfn	vampfn	vpitfn	durfn	
                        1       2       8       7       7       7       7       7     
;	maxdur	rise	decay	randens
                        .5      .5      1       0     
;2) Exp rise for dens, hanning for amp var, exp decay for pit var.
;Max dens = 200; max dur = .25
;	st	dur	pkamp	cpitch	xdens	ampdev	pitdev	xdur	
i01 +  .      8000   8.07   200    8000   100    .25
;	wavefn	grainfn	xampfn	cpitfn	densfn	vampfn	vpitfn	durfn
                        1       2       8       7       5       2       6       2     
;	maxdur	rise	decay	randens
                        .5      .5      1       0	
;3) Same as previous, but max dur = .01
;	st	dur	pkamp	cpitch	xdens	ampdev	pitdev	xdur	
i01 +  .      10000  8.07   200    10000  100    .01
;	wavefn	grainfn	xampfn	cpitfn	densfn	vampfn	vpitfn	durfn
                        1       2       8       7       5       2       6       2	
;4) Steep exp rise for density; hanning for vamp, vpit and dur
;Max dens=1000.
;	st	dur	pkamp	cpitch	xdens	ampdev	pitdev	xdur	
i01 +  .      10000  8.00   1000   10000  100    .01
;	wavefn	grainfn	xampfn	cpitfn	densfn	vampfn	vpitfn	durfn
                        1       2       8       7       9       2       2       2	
;5) Same as previous, but max dur = .25
;	st	dur	pkamp	cpitch	xdens	ampdev	pitdev	xdur	
i01 +  .      3000   8.00   1000   3000   100    .25
;	wavefn	grainfn	xampfn	cpitfn	densfn	vampfn	vpitfn	durfn
                        1       2       8       7       9       2       2       2	
;6) Same as previous, but max dur = .01 and pit func is exp decay
;	st	dur	pkamp	cpitch	xdens	ampdev	pitdev	xdur	
i01 +  .      10000  8.00   1000   10000  100    .01
;	wavefn	grainfn	xampfn	cpitfn	densfn	vampfn	vpitfn	durfn
                        1       2       8       7       9       2       6       2	
;7) Same as previous, but dens = 500, dens func is less steep rise,
;cpit = 7.00, and xdur = .07 
;	st	dur	pkamp	cpitch	xdens	ampdev	pitdev	xdur	
i01 +  .      8000   7.00   500    8000   100    .07
;	wavefn	grainfn	xampfn	cpitfn	densfn	vampfn	vpitfn	durfn
                        1       2       8       7       5       2       6       2	
;8) Same as previous, but dens = 200, cpit = 7.07, and xdur = .15 
;	st	dur	pkamp	cpitch	xdens	ampdev	pitdev	xdur	
i01 +  .      8000   7.07   200    8000   100    .15
;	wavefn	grainfn	xampfn	cpitfn	densfn	vampfn	vpitfn	durfn
                        1       2       8       7       5       2       6       2	
;9) Same as previous, but dens func = exponential pyramid, cpit = 8.07
;	st	dur	pkamp	cpitch	xdens	ampdev	pitdev	xdur	
i01 +  .      2000   8.07   200    3000   100    .15
;	wavefn	grainfn	xampfn	cpitfn	densfn	vampfn	vpitfn	durfn
                        1       2       8       7       10      2       6       2	
;10) Same as previous, but use wave shape with 16th partial only
;	st	dur	pkamp	cpitch	xdens	ampdev	pitdev	xdur	
i01 +  .      2000   8.07   200    2000   100    .15
;	wavefn	grainfn	xampfn	cpitfn	densfn	vampfn	vpitfn	durfn
                        11      2       8       7       10      2       6       2	
;11) Same as 9, but cpit = 12.07
;	st	dur	pkamp	cpitch	xdens	ampdev	pitdev	xdur	
i01 +  .      3000   12.07  200    3000   100    .15
;	wavefn	grainfn	xampfn	cpitfn	densfn	vampfn	vpitfn	durfn
                        1       2       8       7       10      2       6       2	
;12) Same as previous, but pitdev = 1600
;	st	dur	pkamp	cpitch	xdens	ampdev	pitdev	xdur	
i01 +  .      2000   12.07  200    2000   1600   .15
;	wavefn	grainfn	xampfn	cpitfn	densfn	vampfn	vpitfn	durfn
                        1       2       8       7       10      2       6       2	
;13) Same as 10, but use wave shape with both fund and 16th partial
;	st	dur	pkamp	cpitch	xdens	ampdev	pitdev	xdur	
i01 +  .      3000   8.07   200    3000   100    .15
;	wavefn	grainfn	xampfn	cpitfn	densfn	vampfn	vpitfn	durfn
                        12      2       8       7       10      2       6       2	
;14) Same as previous, but wave shape has 8th & 9th partials only
;	st	dur	pkamp	cpitch	xdens	ampdev	pitdev	xdur	
i01 +  .      3000   8.07   200    3000   100    .15
;	wavefn	grainfn	xampfn	cpitfn	densfn	vampfn	vpitfn	durfn
                        13      2       8       7       10      2       6       2	
;15) Same as previous, but wave shape has cluster of inharm partials
;	st	dur	pkamp	cpitch	xdens	ampdev	pitdev	xdur	
i01 +  .      3000   8.07   200    3000   100    .15
;	wavefn	grainfn	xampfn	cpitfn	densfn	vampfn	vpitfn	durfn
                        14      2       8       7       10      2       6       2	
;16) Same as previous, but wave shape has cluster of high odd partials
;and cpitch is 3.07
;	st	dur	pkamp	cpitch	xdens	ampdev	pitdev	xdur	
i01 +  .      4000   3.07   200    4000   100    .15
;	wavefn	grainfn	xampfn	cpitfn	densfn	vampfn	vpitfn	durfn
                        15      2       8       7       10      2       6       2	
s
;17) Same as previous, but use pure sine, make a staggered cluster, reduce xdur to .1
;	st	dur	pkamp	cpitch	xdens	ampdev	pitdev	xdur	
i01 0  10     1600   8.07   200    4000   100    .1 
;	wavefn	grainfn	xampfn	cpitfn	densfn	vampfn	vpitfn	durfn
                        1       2       8       7       10      2       6       2     
;	maxdur	rise	decay
                        .25     .5      1	
i01 1  .      .      8.075
i01 2  .      .      8.065
i01 3  .      .      8.08 
i01 4  .      .      8.06    
s
;18) Try some experiments with randomizing the density (works with Csound v. 3.54)
;Dens = 1000; grain dur = .025
;	st	dur	pkamp	cpitch	xdens	ampdev	pitdev	xdur	
i01 0  30     4000   9.00   1000   0      0      .025        
;	wavefn	grainfn	xampfn	cpitfn	densfn	vampfn	vpitfn	durfn
                        1       2       7       7       10      7       7       7	
;	maxdur	rise	decay 	rndfac	
                        .25     .5      1       0     
;add 50% randomization in grain density
;	st	dur	pkamp	cpitch	xdens	ampdev	pitdev	xdur	
i01 30 30     5000   9.00   1000   0      0      .025        
;	wavefn	grainfn	xampfn	cpitfn	densfn	vampfn	vpitfn	durfn
                        1       2       7       7       10      7       7       7	
;	maxdur	rise	decay 	rndfac	
                        .25     .5      1       .5    
s
;Dens = 100; grain dur = .25; use sound file in fn16
;N.B., use 1/duration of sound file for cpitch to keep original pitch
;	st	dur	pkamp	cpitch	xdens	ampdev	pitdev	xdur	
i01 0  30     4000   -.6729 1000   0      0      .25	 
;	wavefn	grainfn	xampfn	cpitfn	densfn	vampfn	vpitfn	durfn
                        16      2       7       7       10      7       7       7	
;	maxdur	rise	decay 	rndfac	
                        .25     .5      1       0     
;add 50% randomization in grain density
;	st	dur	pkamp	cpitch	xdens	ampdev	pitdev	xdur	
i01 30 30     5000   -.6729 1000   0      0      .25	 
;	wavefn	grainfn	xampfn	cpitfn	densfn	vampfn	vpitfn	durfn
                        16      2       7       7       10      7       7       7	
;	maxdur	rise	decay 	rndfac	
                        .25     .5      1       .5    
e

