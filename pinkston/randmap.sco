;test score for randmap.orc
f1  0 8192  10    1     .3    .1    0     .05 
;table of 16 pitches (all black notes - 3 octaves); no rescaling!
f2  0 16    -2    .01   .03   .06   .08   .10
      1.01  1.03  1.06  1.08  1.10  2.01  2.03  2.06
      2.08  2.10  3.01
;table of 16 pitches (only whole tones)
f3  0 16    -2    .00   .02   .04   .06   .08
                        .10     1.00    1.02    1.04    1.06    1.08    1.10    2.00
                        2.02    2.04    2.06
;new collection of pitches
f4  0 8     -2    .00   1.00  2.00  3.00  2.00  2.00  2.03  1.03
;nn	st	dur	amp	base	rise	dec	rndhz	seed	table	delay
i01 0  30     10000  7.00   .1     5      6      .12345 2      0    
;canon at upper octave
i01 4  26     .      8.00 
;canon at lower octave
i01 8  22     12000  6.00
s
;nn	st	dur	amp	base	rise	dec	rndhz	seed	table	delay
i01 0  30     10000  7.00   .1     5      6      .12345 2      0    
;use same seed, same start, but different base pch and delay output: parallel 3rds
i01 0  26     .      7.04   .      .      .      .      .      4    
;beginning at 8 beats, parallel major triads
i01 0  22     12000  6.07   .      .      .      .      .      8    
s
;repeat first section with different seed and different pitch table
;nn	st	dur	amp	base	rise	dec	rndhz	seed	table
;i01	0	30	10000	7.00	.1	5	8	.23456	3
i01 0  30     10000  7.00   .1     5      8      .010101       3      
;canon at upper octave
i01 4  26     .      8.00 
;canon at lower octave
i01 8  22     12000  6.00
s
;repeat again with different seed and different pitch table
;nn	st	dur	amp	base	rise	dec	rndhz	seed	table
i01 0  30     10000  7.00   .1     5      8      .202020       4     
;canon at upper octave
i01 4  26     .      8.00 
;canon at lower octave
i01 8  22     12000  6.00
e
