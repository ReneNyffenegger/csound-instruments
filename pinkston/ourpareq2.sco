;Test score for ourpareq2.orc
;Sound 1
;	st	dur	gain	insound		
i01 0  4      .9     "rich44.wav"	
;	lowC	lowV	lowQ	lowBP	
                        100     0       .2      1	
;	mid1C	mid1V	mid1Q 	mid1BP
                        400     0       .2      1    
;	mid2C	mid2V	mid2Q	mid2BP
                        800     0       .2      1    
;	highC	highV	highQ	highBP	balBP
                        2000    0       .2      1       1     
;Sound2
;	st	dur	gain	insound		
i01 +  35     .9     "blackorpheushead1.wav"	
s
f0  2
s
;Try some low end and high end boost with balance
;Sound 1
;	st	dur	gain	insound		
i01 0  4      .8     "rich44.wav"	
;	lowC	lowV	lowQ	lowBP		
                        100     18      .2      0	
;	mid1C	mid1V	mid1Q 	mid1BP
                        400     0       .2      1    
;	mid2C	mid2V	mid2Q	mid2BP
                        800     0       .2      1    
;	highC	highV	highQ	highBP	balBP
                        2000    12      .2      0       0     
;Sound2
;	st	dur	gain	insound		
i01 +  35     .9     "blackorpheushead1.wav"	
s
f0  2
s
;Try some low end and high end boost without balance
;Sound 1
;	st	dur	gain	insound		
i01 0  4      .8     "rich44.wav"	
;	lowC	lowV	lowQ	lowBP		
                        100     18      .2      0	
;	mid1C	mid1V	mid1Q 	mid1BP
                        400     0       .2      1    
;	mid2C	mid2V	mid2Q	mid2BP
                        800     0       .2      1    
;	highC	highV	highQ	highBP	balBP
                        2000    12      .2      0       1     
;Sound2
;	st	dur	gain	insound		
i01 +  35     .7     "blackorpheushead1.wav"	
s
f0  2
s
;Try some midrange boost with balance
;Sound 1
;	st	dur	gain	insound		
i01 0  4      .8     "rich44.wav"	
;	lowC	lowV	lowQ	lowBP		
                        100     0       .2      1	
;	mid1C	mid1V	mid1Q 	mid1BP
                        400     12      2       0     
;	mid2C	mid2V	mid2Q	mid2BP
                        800     12      2       0     
;	highC	highV	highQ	highBP	balBP
                        2000    0       .2      1       0     
;Sound2
;	st	dur	gain	insound		
i01 +  35     .9     "blackorpheushead1.wav"	
s
f0  2
s
;Try some midrange boost without balance
;Sound 1
;	st	dur	gain	insound		
i01 0  4      .2     "rich44.wav"	
;	lowC	lowV	lowQ	lowBP		
                        100     0       .2      1	
;	mid1C	mid1V	mid1Q 	mid1BP
                        400     12      2       0     
;	mid2C	mid2V	mid2Q	mid2BP
                        800     12      2       0     
;	highC	highV	highQ	highBP	balBP
                        2000    0       .2      1       1     
;Sound2
;	st	dur	gain	insound		
i01 +  35     .25    "blackorpheushead1.wav"	