;Example Score for tstretch.orc
;the source sounds
f1  0 131072      1     "thewind.wav"     0     0     0   
f4  0 262144      1     "eroica44.wav"    0     0     0   
;Hanning window function
f2  0 512   20    2        
;varying time stretch control function for instr3-4
f3  0 513   -7    1     128   .333  256   3     129   1   
;
;fixed time stretch functions for instr3-4
f5  0 3     -7    2     3     2   
f6  0 3     -7    .67   3     .67 
;no stretching at all
f7  0 3     7     1     3     1   
;Test simple fixed time stretch instrument at 1/4th speed; vary grain lengths
;nn	st	dur	amp	timefac	rise	decay	grlen	srcfn	winfn
i01 0  7      30000  .25    .5     1      .005   1      2    
i01 +  .      .      .      .      .      .01  
i01 +  .      .      .      .      .      .05  
i01 +  .      .      .      .      .      .1   
s
;Repeat with dual-window fixed time stretch instrument
;nn	st	dur	amp	timefac	rise	decay	grlen	srcfn	winfn
i02 0  7      30000  .25    .5     1      .005   1      2    
i02 +  .      .      .      .      .      .01  
i02 +  .      .      .      .      .      .05  
i02 +  .      .      .      .      .      .1   
s
;Tests with dual-window variable time stretch instrument
;nn	st	dur	amp	timfn 	rise	decay	grlen	srcfn	winfn
i03 0  5      30000  3      .5     1      .005   1      2	
i03 +  .      .      .      .      .      .01  
i03 +  .      .      .      .      .      .05  
i03 +  .      .      .      .      .      .1   
s
;Repeat tests with quad-window variable time stretch instrument
;nn	st	dur	amp	timfn 	rise	decay	grlen	srcfn	winfn
i04 0  5      20000  3      .5     1      .005   1      2    
i04 +  .      .      .      .      .      .01  
i04 +  .      .      .      .      .      .05  
i04 +  .      .      .      .      .      .1   
s
;Tests of instrument 4 with Beethoven Sym #3, fixed time stretch values
;Play with no stretching first, different grain lengths
;nn	st	dur	amp	timfn 	rise	decay	grlen	srcfn	winfn
i04 0  7      20000  7      .5     1      .005   4      2    
i04 +  .      .      .      .      .      .01  
i04 +  .      .      .      .      .      .05  
i04 +  .      .      .      .      .      .1   
s
;2 times as fast
;nn	st	dur	amp	timfn 	rise	decay	grlen	srcfn	winfn
i04 0  4      20000  5      .5     1      .005   4      2    
i04 +  .      .      .      .      .      .01  
i04 +  .      .      .      .      .      .05  
i04 +  .      .      .      .      .      .1   
s
;2/3rds speed
;nn	st	dur	amp	timfn 	rise	decay	grlen	srcfn	winfn	
i04 0  10     20000  6      .5     1      .005   4      2	
i04 +  .      .      .      .      .      .01  
i04 +  .      .      .      .      .      .05  
i04 +  .      .      .      .      .      .1   
s
;2/3rds speed with doublings
;nn	st	dur	amp	timfn 	rise	decay	grlen	srcfn	winfn	
i04 0  10     10000  6      .5     1      .005   4      2	
i04 .002
i04 10 .      .      .      .      .      .01  
i04 10.00125
i04 20 .      .      .      .      .      .05  
i04 20.00625
i04 30 .      .      .      .      .      .1   
i04 30.0125
e	