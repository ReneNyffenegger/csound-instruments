; Endless Glissando Score										
f01 0 512   10    1         		 
; Use a Gaussian window function to approximate Risset's amplitude (bell) function										
f02 0 2048  20    6     1     0   
; Generate the 10-octave gliss function given in Dodge										
f03 0 513   5     1     512   .0009766
; Generate 60 seconds of endless glissando with a 120 second cycle time										
i01 0  60     15000  6000   120		 
e	 			 	 		 	 		 
