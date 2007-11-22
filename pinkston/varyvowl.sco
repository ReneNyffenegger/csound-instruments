;Test score for variable vowel orchestra. RP
f1  0 8192  10    1  
;generate a "sigmoid" function
f2  0 8192  19    .5    .5    270   .5
;line segment for vibrato rise
f3  0 513   7     0     513   1 
;vowel formant function (18 p-fields per vowel)
f4  0 256   -2
;1 - male voice singing A
;	fmt1	amp1	bw1	fmt2	amp2	bw2	fmt3	amp3	bw3
                        609     0       100     1000    -6      100     2450    -12     100 
;	fmt4	amp4	bw4	fmt5	amp5	bw5	ilris	ildur	ildec
                        2700    -11     100     3240    -24     100     .003    .02     .007
;2 - male voice singing E
;	fmt1	amp1	bw1	fmt2	amp2	bw2	fmt3	amp3	bw3
                        400     0       100     1700    -9      100     2300    -8      100  
;	fmt4	amp4	bw4	fmt5	amp5	bw5	ilris	ildur	ildec
                        2900    -11     100     3400    -19     100     .003    .02     .007
;3 - male voice singing IY
;	fmt1	amp1	bw1	fmt2	amp2	bw2	fmt3	amp3	bw3
                        238     0       100     1741    -20     100     2450    -16     100 
;	fmt4	amp4	bw4	fmt5	amp5	bw5	ilris	ildur	ildec
                        2900    -20     100     4000    -32     100     .003    .02     .007
;4 - male voice singing O
;	fmt1	amp1	bw1	fmt2	amp2	bw2	fmt3	amp3	bw3
                        325     0       100     700     -12     100     2550    -26     100 
;	fmt4	amp4	bw4	fmt5	amp5	bw5	ilris	ildur	ildec
                        2850    -22     100     3100    -28     100     .003    .02     .007
;5 - male voice singing OO
;	fmt1	amp1	bw1	fmt2	amp2	bw2	fmt3	amp3	bw3
                        360     0       100     750     -12     100     2400    -29     100 
;	fmt4	amp4	bw4	fmt5	amp5	bw5	ilris	ildur	ildec
                        2675    -26     100     2950    -35     100     .003    .02     .007
;6 - male voice singing U
;	fmt1	amp1	bw1	fmt2	amp2	bw2	fmt3	amp3	bw3
                        415     0       100     1400    -12     100     2200    -16     100 
;	fmt4	amp4	bw4	fmt5	amp5	bw5	ilris	ildur	ildec
                        2800    -18     100     3300    -27     100     .003    .02     .007
;7 - male voice singing ER
;	fmt1	amp1	bw1	fmt2	amp2	bw2	fmt3	amp3	bw3
                        300     0       100     1600    -14     100     2150    -12     100 
;	fmt4	amp4	bw4	fmt5	amp5	bw5	ilris	ildur	ildec
                        2700    -15     100     3100    -23     100     .003    .02     .007
;8 - male voice singing UH
;	fmt1	amp1	bw1	fmt2	amp2	bw2	fmt3	amp3	bw3
                        400     0       100     1050    -12     100     2200    -19     100 
;	fmt4	amp4	bw4	fmt5	amp5	bw5	ilris	ildur	ildec
                        2650    -20     100     3100    -29     100     .003    .02     .007
;9 - female voice singing A
;	fmt1	amp1	bw1	fmt2	amp2	bw2	fmt3	amp3	bw3
                        650     0       100     1100    -8      100     2860    -13     100 
;	fmt4	amp4	bw4	fmt5	amp5	bw5	ilris	ildur	ildec
                        3300    -12     100     4500    -19     100     .003    .02     .007
;10 - female voice singing E
;	fmt1	amp1	bw1	fmt2	amp2	bw2	fmt3	amp3	bw3
                        500     0       100     1750    -9      100     2450    -10     100 
;	fmt4	amp4	bw4	fmt5	amp5	bw5	ilris	ildur	ildec
                        3350    -14     100     5000    -23     100     .003    .02     .007
;11 - female voice singing IY
;	fmt1	amp1	bw1	fmt2	amp2	bw2	fmt3	amp3	bw3
                        330     0       100     2000    -14     100     2800    -11     100 
;	fmt4	amp4	bw4	fmt5	amp5	bw5	ilris	ildur	ildec
                        3450    -50     100     4500    -52     100     .003    .02     .007
;12 - female voice singing O
;	fmt1	amp1	bw1	fmt2	amp2	bw2	fmt3	amp3	bw3
                        400     0       100     840     -12     100     2800    -26     100 
;	fmt4	amp4	bw4	fmt5	amp5	bw5	ilris	ildur	ildec
                        3250    -24     100     4500    -31     100     .003    .02     .007
;13 - female voice singing OO
;	fmt1	amp1	bw1	fmt2	amp2	bw2	fmt3	amp3	bw3
                        280     0       100     650     -18     100     2200    -48     100 
;	fmt4	amp4	bw4	fmt5	amp5	bw5	ilris	ildur	ildec
                        3450    -50     100     4500    -52     100     .003    .02     .007
;try a few tests
;A-E-IY-O-OO
;	st	dur	gain	fund	vibdel	vibwth	vibrte	vowfn	irise	idecay
i02 0  12     .3     8.00   .25    .0175  5      4      .1     .2  
;	vow1	dur1	vow2	dur2	vow3	dur3	vow4	dur4	vow5
                        1       3       2       3       3       3       4       3       5     
;IY-E-A-O-OO
;	st	dur	gain	fund	vibdel	vibwth	vibrte	vowfn	irise	idecay
i02 +  12     .3     8.00   .25    .0175  5      4      .1     .2  
;	vow1	dur1	vow2	dur2	vow3	dur3	vow4	dur4	vow5
                        3       3       2       3       1       3       4       3       5     
;OO-O-IY-E-A
;	st	dur	gain	fund	vibdel	vibwth	vibrte	vowfn	irise	idecay
i02 +  12     .3     8.00   .25    .0175  5      4      .1     .2  
;	vow1	dur1	vow2	dur2	vow3	dur3	vow4	dur4	vow5
                        5       3       4       3       3       3       2       3       1     
;E-IY-A-O-OO
;	st	dur	gain	fund	vibdel	vibwth	vibrte	vowfn	irise	idecay
i02 +  12     .3     8.00   .25    .0175  5      4      .1     .2  
;	vow1	dur1	vow2	dur2	vow3	dur3	vow4	dur4	vow5
                        2       3       3       3       1       3       4       3       5     
s
f0  .5
s
;cluster chord with O-A-IY-OO-E
;	st	dur	gain	fund	vibdel	vibwth	vibrte	vowfn	irise	idecay
i02 0  12     .1     7.05   4      .0125  5      4      1      3    
;	vow1	dur1	vow2	dur2	vow3	dur3	vow4	dur4	vow5
                        4       3       1       3       3       3       5       3       2     
i02 .01       .      .      8.00   .      .      4.9  
i02 .02       .      .      8.02   .      .      5.1  
i02 .03       .      .      8.08   .      .      4.8  
i02 .05       .      .      7.10   .      .      5.2  
i02 .08       .      .      8.05   .      .      4.7  
i02 .13       .      .      8.07   .      .      5.3  
i02 .21       .      .      7.08   .      .      4.6  
i02 .34       .      .      6.04   .      .      5.4  
;female cluster with OO-O-A-E-IY
i02 10 12     .07    9.05   2      .014   6      4      1      3     
       5      1      4      2      1      5      2      4      3    
i02 10.01     .      .      9.04   .      .      5.7  
i02 10.02     .      .      9.02   .      .      5.3  
i02 10.03     .      .      8.11   .      .      6.1  
i02 10.05     .      .      8.07   .      .      4.9  
i02 10.08     .      .      8.02   .      .      5.2  
i02 10.13     .      .      7.08   .      .      5.1  
e
