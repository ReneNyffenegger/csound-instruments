;Test score for mapping.orc
f1  0 8192  10    1     .5    .2    .1 
;define a velocity to amplitude scaling function
;linear mapping
f2  0 128   -7    100   128   32767
;exponential mapping
f4  0 128   -5    100   128   32767
;pan function
f3  0 128   7     .5    32    1     32    0     32    1     32    .5 
;nn	st	dur	vel	pch	rise	decay	endtime	ampfn
i01 0  .5     10     9.00   .1     .25    6.0    2  
i . +  .      20   
i . +  .      30   
i . +  .      40     
i . +  .      50     
i . +  .      60     
i . +  .      70     
i . +  .      80     
i . +  .      90     
i . +  .      100    
i . +  .      110  
i . +  .      120  
i . +  .      127  
s
f0  2
s
;nn	st	dur	vel	pch	rise	decay	endtime	ampfn
i01 0  .5     10     9.00   .1     .25    6.0    4  
i . +  .      20   
i . +  .      30   
i . +  .      40     
i . +  .      50     
i . +  .      60     
i . +  .      70     
i . +  .      80     
i . +  .      90     
i . +  .      100    
i . +  .      110  
i . +  .      120  
i . +  .      127  
e
