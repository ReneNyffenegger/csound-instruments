;-------------------------------------------;
;Pinkston: Sample Score for FM Instrument 2 ;
;-------------------------------------------;
f01 0 2048  10    1                     ;simple sine wave
;	st	dur	amp	pch	cfac	mfac	index	rise	dec
i02 0  1      20000  8.09   1      1      5      .05    .01
;	afact	rel	xfac1	xris	xdec	xfac2	xrel	detune	
                        1       .2      0       .1      .5      .25     .25     0	
i02 2  .      .      .      3      1      2      .      .    
                        .       .       .       .       .01     1       .25		
i02 4  .      .      6.09   5      1      1.5        	

i02 6  .      .      8.09   3      2      4      .      .    
                        .       .       .5      .       .       1			
;three notes slightly detuned and slightly staggered entrances
i02 8  6      10000  6.00   1      1.4    10     3      1.9  
                        .7      1       0       3       1.9     .25     1		
i02 8.005     .      .      .      .      .      .      .      .    
                        .       .       .       .       .       .       .       1	
i02 8.012     .      .      .      .      .      .      .      .    
                        .       .       .       .       .       .       .       -1	
e									

