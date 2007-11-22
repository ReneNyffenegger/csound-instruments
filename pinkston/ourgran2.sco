;grain envelope function
f1  0 8192  20    1  
;wave data parms:	istart	iend	idirect	iwrap
f2  0 16    -2    0     1.47  1     1   
      0     13.333      1     1   
      0     3.25  1     0   
;ampfn
f3  0 128   -7    6000  64    25000 64    4000
;durfn
f4  0 128   -5    .1    64    .025  64    .2 
;timefn (0 - 1)
f5  0 128   7     .5    32    0     64    1     32    .5 
;f5	0	128	-7	0	128	.95
;ghzfn 
f6  0 128   -5    20    64    200   64    10 
;pitfn
f7  0 2     2     1     1   
;panfn	(offset rescaled sine wave)
f8  0 128   19    1     1     0     1   
;srcfn
f9  0 4     -7    11    4     13.999
;src function
f11 0 65536 1     "thewind.wav"     0     0     0   
f12 0 1048576     1     "abuzz2-44.wav"   0     0     0   
f13 0 1048576     1     "cbc-bb0.wav"     0     0     0   
;This generates 5 seconds of grains using the crude schedule instrument
;	st	dur	ampfn	durfn	timefn	ghzfn	pit	pan	src	data	envfn	sfn1
i01 0  40     3      4      5      6      7      8      9      2      1      11      
e
