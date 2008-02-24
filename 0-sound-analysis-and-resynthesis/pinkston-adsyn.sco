;Test score for adsyn.orc
;unity function for no change
f01 0 2     2     1     1   
;linear ramp
f02 0 513   7     0     513   1 
;hetro -f175 -h30 cello44.wav adsyn.1
;no	st	dur	ampfac	pitfac	timfac	fileno
i01 0  2      1      1      1      "cello.het"
i01 2  4      1      1      .5   
i01 5  2      1      1.5    1  
i01 7  2      1      .5     1   
i01 9  6      1      1      .333 
;keep attack transient at normal speed, then stretch sustained part of note
;no	st	dur	ampfac	pitfac	timfac	fileno	ampfn	pitfn	timfn	
i02 15 9      1      1      .15    "cello.het" 1      1      2    
;	vampd	vpitd	vtimd	ampdel	pitdel	timdel
                        0       0       .25     0       0       .25   
s
;hetro -h50 thewind.wav adsyn.2
;no	st	dur	ampfac	pitfac	timfac	fileno
i01 0  2      1      1      1      "wind.het"
i01 2  4      1      1      .5   
i01 7  2      1      1.5    1  
i01 9  2      1      .5     1   
i01 11 6      1      1      .333 
;wait a second, then start an upward glissando
;no	st	dur	ampfac	pitfac	timfac	fileno	ampfn	pitfn	timfn	
i02 17 6      1      3      .333   "wind.het"  1      2      1    
;	vampd	vpitd	vtimd	ampdel	pitdel	timdel
                        0       5       0       0       1       0     
s
;try various numbers of harmonics and time points on a low piano note
;this uses only the default n points (256) and only 60 harmonics
;piano C2: hetro -f65 -h60 -M24000 c2.aiff adsyn.10
i01 0  2.5    1      1      1      "c2a.het"
i01 3  5      1      1      .5   
i01 9  2.5    1      1.5    1  
i01 12 2.5    1      2      1    
i01 15 7.5    1      1      .333 
s
;this has better quality - more time points, more harmonics, correct fundamental
;piano C2: hetro -f32.7032 -h100 -n512 -M30000 c2.aiff adsyn.11
i01 0  2.5    1      1      1      "c2b.het"
i01 3  5      1      1      .5   
i01 9  2.5    1      1.5    1  
i01 12 2.5    1      2      1    
i01 15 7.5    1      1      .333 
s
;even better resolution, with 1000 time points
;hetro -f32.7032 -h100 -n1000 -M30000 c2.aif adsyn.12
;	st	dur	amp	pit	time	adsyn.nnn
i01 0  2.5    1      1      1      "c2c.het"
i01 3  5      1      1      .5   
i01 9  2.5    1      1.5    1  
i01 12 2.5    1      2      1    
i01 15 7.5    1      1      .333 
;keep attack transient at normal speed, then stretch sustained part of note
;wait 5 seconds, then start downward slow gliss
;no	st	dur	ampfac	pitfac	timfac	fileno	ampfn	pitfn	timfn	
i02 23 25     1      .8     .05    "c2c.het"   1      2      2    
;	vampd	vpitd	vtimd	ampdel	pitdel	timdel
                        0       20      .5      0       5       1     
s
;even better resolution, with 1000 time points
;piano C5: hetro -f261 -h100 -n1000 -M30000 c5.aiff adsyn.13
i01 0  2.5    1      1      1      "c5.het"
i01 3  5      1      1      .5   
i01 9  2.5    1      1.5    1  
i01 12 2.5    1      2      1    
i01 15 7.5    1      1      .333 
;keep attack transient at normal speed, then stretch sustained part of note
;wait 5 seconds, then start downward slow gliss
;no	st	dur	ampfac	pitfac	timfac	fileno	ampfn	pitfn	timfn	
i02 23 25     1      .8     .05    "c5.het"    1      2      2    
;	vampd	vpitd	vtimd	ampdel	pitdel	timdel
                        0       20      .5      0       5       1     
e
