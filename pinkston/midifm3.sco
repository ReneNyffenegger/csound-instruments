;--------------------------------------------;
; Pinkston: Sample Score for FM Instrument 3 ;
;--------------------------------------------;

f01 0 2048  10    1                     ;Simple sine                                    
;Exponential rise										
f02 0 513   5     .001  513   1   			
;Parameter Data:		rise	decay	carfac	m1fac	index1	m1ris	m1dur			
f03 0 16    -2    .05   1     1     1     5     .1    0  
;	m1dec	m2fac	index2	m2ris	m2dur	m2dec				
                        1       1       3       .25     0       1				
;execute for 30 seconds
f0  30						
e										
