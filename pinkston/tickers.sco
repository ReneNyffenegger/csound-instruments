f1  0 8192  10    1  
;the individual tick envelope function for instrs 2 & 3
f2  0 513   5     .0001 33    1     480   .000001
;pan control functions
f3  0 257   7     .5    128   1     129   .25
f4  0 257   7     0     128   1     129   0 
;parms: st      dur     amp     pch     rise    decay   lfohz   lfofn   oscfn
i1  0  3      16000  13.00  1      2      15     2      1    
i1  +  .      .      .      .      .      20   
i1  +  .      .      .      .      .      25   
f0  10
s
;parms:	st	dur	amp	pch	rise	decay	lfohz	amfn	oscfn
i2  0  3      16000  13.00  1      2      15     2      1    
;	lfohzfn	panfn
                        3       4     
i2  +  .      .      .      .      .      20   
i2  +  .      .      .      .      .      25   
f0  10
s
;parms: st      dur     amp     pch     rise    decay   lfohz   amfn    oscfn
i3  0  3      16000  12.06  1      2      15     2      1    
;	lfohzfn	panfn	ibend	bendfn
                        3       4       .25     4   
i3  +  .      .      .      .      .      20   
i3  +  .      .      .      .      .      25   
e
