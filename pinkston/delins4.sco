;Sample Score for Pinkston Delay Chapter Instrument 4
;LFO wave is a sine								
f01 0 512   10    1        			
;Oscil wave								
f02 0 512   10    1     .5    .3    .2    .1 
;LFO depth factor is .9, gradually increase max delay time								
;	st	dur	amp	pch	lfohz	depth	maxdlt	
i4  0  3      10000  8.00   5      .9     1	  
i4  +  .      .      .      .      .      2       
i4  +  .      .      .      .      .      3       
i4  +  .      .      .      .      .      4       
e								

