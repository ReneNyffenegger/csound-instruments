;Test score for soundins.orc. 
;load in some .wav sound files using gen01
;"Hello, my name is Richard Boulanger." 132098 samples. 2.995 seconds.
;	st	size	gen#	filecod		skip	format	chan
f01 0 262145      1     "richard.wav"     0     4     0   
;a cello note: dur = 1.568; len = 34569; root = 7.05
f02 0 65537 1     "cello.wav" 0     4     0   
;an alto flute note with loop, deferred table size, read loop info from file
f03 0 0     1     "altfloop.aif"    0     0     0   
;test instrument 1 - uses soundin.42 (Beethoven excerpt)
;nn	st	dur	snd#	rscl
i01 0  6      42     0   
s
;test instrument 2 - uses soundin.41 (copy of "richard.wav")
;the whole phrase
;nn	st	dur	snd#	skip	rise	decay	rscl
i02 0  3      41     0      0      0      0    
;skip to the name and fade in/out
i02 4  1.5    .      1.7    .1     1   
s
;test instrument 3 - uses "richard.wav" in fn01
;first, the whole phrase forwards at original pitch
;nn	st	dur	amp	fn#	start	dur	end	rise	decay
i03 0  3      30000  1      0      2.995  132098 0      0    
;next, the whole phrase backwards at original pitch
i03 +  .      .      .      132098 .      0    
f00 7
s
;test instrument 4 - uses "cello.wav" in fn02
;play some cello notes at different pitches
;nn	st	dur	amp	pch	fn#	root	rise	decay	mode	lpst	lpend
i04 0  1      15000  7.00   2      7.05   .01    .1     0      0      1    
i04 +  .      .      7.03 
i04 +  .      .      7.06 
i04 +  .      .      7.09 
i04 +  .      .      8.00 
i04 +  2      .      6.05 
f00 7.5
s
;test instrument 5 with alto flute sample
;nn	st	dur	amp	pch	fn#	rise	decay
i05 0  1.5    15000  7.05   3      .01    .1 
i05 1.5       .5     <      7.09 
i05 2  .      .      8.00 
i05 2.5       .      25000  8.05
i05 3  2      8000   7.07
i . .  .      .      7.10 
i . .  .      .      8.01 
i . .  .      .      8.04 
e
