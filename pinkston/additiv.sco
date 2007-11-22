;=======================================================;
;Example score for additiv.orc. Note that all the .fun	;
;files are in the file addfuns.zip and must be unzipped	;
;into the soundin directory for this score to work. The	;
;partial numbers, relative amplitudes, and envelopes, 	;
;as well as the entire instrument, are drawn from the	;
;MSP Additive Synthesis Tutorial instrument by Chris	;
;Dobrian. They are used without permission, but with	;
;thanks and apologies to Chris. RP			;
;=======================================================;
f01 0 8192  10    1  
;Example 1
;partial amplitude functions (drawn with fgenie)
f11 0 513   1     "add11fp.fun"     0     6     1   
f12 0 513   1     "add12fp.fun"     0     6     1   
f13 0 513   1     "add13fp.fun"     0     6     1   
f14 0 513   1     "add14fp.fun"     0     6     1   
f15 0 513   1     "add15fp.fun"     0     6     1   
f16 0 513   1     "add16fp.fun"     0     6     1   
;	st	dur	amp	pch	gain1	fn1	ptl2	gain2	fn2	ptl3	gain3	fn3
i01 0  1      10000  8.09   .8     11     3      .8     12     4      .8     13  
;				ptl4	gain4	fn4	ptl5	gain5	fn5	ptl6	gain6	fn6	
                        5       .7      14      7       .8      15      8       .8      16   
f0  2
s
;Example 2
;partial amplitude functions (drawn with fgenie)
f11 0 513   1     "add21fp.fun"     0     6     1   
f12 0 513   1     "add22fp.fun"     0     6     1   
f13 0 513   1     "add23fp.fun"     0     6     1   
f14 0 513   1     "add24fp.fun"     0     6     1   
f15 0 513   1     "add25fp.fun"     0     6     1   
f16 0 513   1     "add26fp.fun"     0     6     1   
;	st	dur	amp	pch	gain1	fn1	ptl2	gain2	fn2	ptl3	gain3	fn3
i01 0  2      10000  5.09   .8     11     2      .8     12     4      .6     13  
;				ptl4	gain4	fn4	ptl5	gain5	fn5	ptl6	gain6	fn6	
                        8       .8      14      16      .8      15      32      .8      16   
f0  3
s
;Example 3
;partial amplitude functions (drawn with fgenie)
f11 0 513   1     "add31fp.fun"     0     6     1   
f12 0 513   1     "add32fp.fun"     0     6     1   
f13 0 513   1     "add33fp.fun"     0     6     1   
f14 0 513   1     "add34fp.fun"     0     6     1   
f15 0 513   1     "add35fp.fun"     0     6     1   
f16 0 513   1     "add36fp.fun"     0     6     1   
;	st	dur	amp	pch	gain1	fn1	ptl2	gain2	fn2	ptl3	gain3	fn3
i01 0  2      10000  7.09   .8     11     2.99   .6     12     4.01   .8     13  
;				ptl4	gain4	fn4	ptl5	gain5	fn5	ptl6	gain6	fn6	
                        4.98    .5      14      7.04    .4      15      8.02    .6      16   
f0  3
s
;Example 4
;partial amplitude functions (drawn with fgenie)
f11 0 513   1     "add41fp.fun"     0     6     1   
f12 0 513   1     "add42fp.fun"     0     6     1   
f13 0 513   1     "add43fp.fun"     0     6     1   
f14 0 513   1     "add44fp.fun"     0     6     1   
f15 0 513   1     "add45fp.fun"     0     6     1   
f16 0 513   1     "add46fp.fun"     0     6     1   
;	st	dur	amp	pch	gain1	fn1	ptl2	gain2	fn2	ptl3	gain3	fn3
i01 0  .75    10000  8.04   1      11     2      1      12     3      1      13   
;				ptl4	gain4	fn4	ptl5	gain5	fn5	ptl6	gain6	fn6	
                        4       .7      14      5       .3      15      7       .1      16   
f0  2
s
;Example 5
;partial amplitude functions (drawn with fgenie)
f11 0 513   1     "add51fp.fun"     0     6     1   
f12 0 513   1     "add52fp.fun"     0     6     1   
f13 0 513   1     "add53fp.fun"     0     6     1   
f14 0 513   1     "add53fp.fun"     0     6     1   
f15 0 513   1     "add52fp.fun"     0     6     1   
f16 0 513   1     "add56fp.fun"     0     6     1   
;	st	dur	amp	pch	gain1	fn1	ptl2	gain2	fn2	ptl3	gain3	fn3
i01 0  5      5500   9.09   1      11     1.01   1      12     1.02   1      13   
;				ptl4	gain4	fn4	ptl5	gain5	fn5	ptl6	gain6	fn6	
                        1.04    1       14      1.05    1       15      1.06    1       16    
f0  6
s
;Example 6
;partial amplitude functions (drawn with fgenie)
f11 0 513   1     "add61fp.fun"     0     6     1   
f12 0 513   1     "add62fp.fun"     0     6     1   
f13 0 513   1     "add63fp.fun"     0     6     1   
f14 0 513   1     "add63fp.fun"     0     6     1   
f15 0 513   1     "add62fp.fun"     0     6     1   
f16 0 513   1     "add66fp.fun"     0     6     1   
;	st	dur	amp	pch	gain1	fn1	ptl2	gain2	fn2	ptl3	gain3	fn3
i01 0  2      6900   8.09   1      11     1.12   1      12     1.26   1      13   
;				ptl4	gain4	fn4	ptl5	gain5	fn5	ptl6	gain6	fn6	
                        1.41    1       14      1.59    1       15      1.78    1       16    
f0  3
s
;Example 7
;partial amplitude functions (drawn with fgenie)
f11 0 513   1     "add71fp.fun"     0     6     1   
f12 0 513   1     "add72fp.fun"     0     6     1   
f13 0 513   1     "add73fp.fun"     0     6     1   
f14 0 513   1     "add74fp.fun"     0     6     1   
f15 0 513   1     "add75fp.fun"     0     6     1   
f16 0 513   1     "add76fp.fun"     0     6     1   
;	st	dur	amp	pch	gain1	fn1	ptl2	gain2	fn2	ptl3	gain3	fn3
i01 0  5      10000  8.04   .4     11     1.97   .45    12     2.8    .5     13  
;				ptl4	gain4	fn4	ptl5	gain5	fn5	ptl6	gain6	fn6	
                        4.2     .6      14      8.24    .7      15      13.8    .7      16   
e
