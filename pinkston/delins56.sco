;Sample Score for Pinkston Delay Chapter Instruments 5-6
;LFO wave is a hamming window function								
f01 0 512   20    1        			
;sound producing instrument								
;	st	dur	main	send				
i5  0  5      .4     .8     			
;flange effect unit								
;	st	dur	feedbk	lfohz1	lfohz2	maxdel	depth1	depth2
i6  0  5      .9     .2     .7     .005   .8     .9  
e								
