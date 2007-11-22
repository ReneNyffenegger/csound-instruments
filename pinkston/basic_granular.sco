

/***************************************************
Simple  Granular        Synthesis       Instrument

Uses a sine wave as the grain to demonstrate various principles

Created by Gregory Cornelius 
October 2006
***************************************************/


f1  0 8192  10    1                     ; sine wave
f2  0 1024  20    2                     ; hanning window


;in	 st	dur	amp	pch	dens	dur 	wnfn ampoff pchoff
i01 0  5      5000   7.01   20     .05    2      0      0    
i01 6  .      5000   .      40     .05    2        
i01 12 .      5000   .      40     .01    2  
i01 18 .      2000   .      50     .01    2  
i01 24 .      500    .      200    .01    2  

s
f0  0 1
s

i01 0  5      5000   7.01   20     .05    2      4000   2 
i01 6  .      1000   .      40     .05    2      4000   500	
i01 12 .      1000   .      40     .01    2      4000   1000
i01 18 .      1000   .      50     .01    2      4000   500
i01 24 .      500    .      200    .01    2      1000   100

e
