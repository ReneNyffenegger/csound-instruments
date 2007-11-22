;Example score for combtest.orc
;First, play source sound without any effects added
;nn	st	dur	dryfac	wetfac	iskip
i01 0  3.5    1      0      0    
;Replay source sound, sending output only to effects instr
;nn	st	dur	dryfac	wetfac	iskip
i01 +  .      0      1    
;Keep effects instrument on throughout section
;nn	st	dur	ilpt	irvt	igain	flag	istor
i02 0  10     .05    3      .5     1   
s
;Play only 1st second of richard.wav 4 times ("hello")
;nn	st	dur	dryfac	wetfac	iskip
i01 0  1      0      1      0    
i01 1.5
i01 3
i01 4.5
;Generate a 4-note chord using comb. Notes:
;1) Each new note requires a separate comb filter, with the 
;   ilpt set to 1/frequency of the desired pitch. 
;2) Each comb instrument must accept input from gasend only
;   for one second (enough to get the "hello"); then the comb
;   unit must be allowed to continue executing for irvt seconds.
;   This involves playing two notes in the score for every pitch
;   of the chord: one note of 1-second duration with igain set
;   to some positive value; a second note long enough to complete
;   the decay, which has igain = 0 and istor = 1, so the comb
;   filter can finish reverberating what is already in its memory.
;   This technique requires the use of specific instrument instances
;   (i02.1, i02.2, etc.), to ensure that the same comb filter
;   is being continued once the input is shut off.
;first note of chord
;nn	st	dur	ipch	irvt	igain	flag	istor
i02.1  0      1      6.07   11.5   .25    1  
;shut off input after 1 second, but continue reverb
i02.1  1      10.5   .      .      0      0      1    
;second note of chord
;nn	st	dur	ipch	irvt	igain	flag	istor
i02.2  1.5    1      6.11   9      .25    1      0    
;shut off input after 1 second, but continue reverb
i02.2  2.5    9      .      .      0      0      1    
;third note of chord
;nn	st	dur	ipch	irvt	igain	flag	istor
i02.3  3      1      7.02   7.5    .15    1      0    
;shut off input after 1 second, but continue reverb
i02.3  4      7.5    .      .      0      0      1    
;fourth note of chord
;nn	st	dur	ipch	irvt	igain	flag	istor
i02.4  4.5    1      7.05   6      .25    1      0    
;shut off input after 1 second, but continue reverb
i02.4  5.5    6      .      .      0      0      1    
s
;Richard in the barbershop
;nn	st	dur	dryfac	wetfac	iskip
i01 0  2.2    0      1      0    
i01 4  1      0      1      2.2  
;nn	st	dur	ipch	irvt	igain	flag	istor
i02.1  0      4      7.00   6      .08    0  
i02.2  .      .      7.07 
i02.3  .      .      8.04 
i02.4  .      .      8.10   .      .      1    
;nn	st	dur	ipch	irvt	igain	flag	istor
i02.1  4      2      7.00   6      0      0      1    
i02.2  .      .      7.07 
i02.3  .      .      8.04 
i02.4  .      .      8.10   .      .	   
i02 2.8       7      6.05   6      .1     0      0    
i02 .  .      7.00 
i02 .  .      8.03 
i02 .  .      8.09   .      .      1    
e
