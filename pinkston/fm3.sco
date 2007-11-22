;--------------------------------------------;
; Pinkston: Sample Score for FM Instrument 3 ;
;--------------------------------------------;

f01 0 2048  10    1                     ;Simple sine                                    
;Exponential rise										
f02 0 513   5     .001  513   1   			
;Parameter Data:	rise	decay	carfac	m1fac	index1	m1ris	m1dur			
f03 0 16    -2    .25   .5    1     1     5     .5    0  
;	m1dec	m2fac	index2	m2ris	m2dur	m2dec				
                        1       1       3       1       0       1				
;in	st	dur	amp	pch	parms					
i03 0  2      20000  7.07   3     				
i03 +  .      .      8.07    					
i03 +  .      .      9.07    					
i03 +  .      .      6.07    					
e										
