;Test score for simple chorus instrument
;Oscil wave functions:
;Simple sine
f1  0 8192  10    1  
;Richer waveform									
f2  0 8192  10    1     .5    0     .1       	 
;Test with pure sine wave
;no	st	dur	amp	pch	rise	dec	fn	pan	detune
i01 0  3      20000  8.00   .1     .5     1      .5     5   
i01 +  .      .      .      .      .      .      .      3    
i01 .  .      .      .      .      .      .      .      1    
i01 .  .      .      .      .      .      .      .      .5   
f0  14
s
;Repeat with richer waveform (note: beating between all component partials)
;no	st	dur	amp	pch	rise	dec	fn	pan	detune
i01 0  3      20000  8.00   .1     .5     2      .5     5   
i01 +  .      .      .      .      .      .      .      3    
i01 .  .      .      .      .      .      .      .      1    
i01 .  .      .      .      .      .      .      .      .5   
f0  14
e	 	 	 	 	 	 	 	 	 
