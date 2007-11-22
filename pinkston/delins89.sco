;Sample Score for Pinkston Delay Chapter Instruments 8-9
f01 0 513   20    3                     ;triangle window fn
f02 0 513   10    1                     ;sine fn
; Play soundin.890 - a single cello sample
;	st	dur	dry	wet	soundin#
i08 0  2      0      1      890      		
; arpeggio: harmonize up 5 semitones with feedback
;	st	dur	gain	delay	nsemis	ifeed	lfohz	
i09 0  4      .45    .33    5      .9     0	  
; Play soundin.891 - a single timpani stroke
;	st	dur	dry	wet	soundin#
i08 4  2      0      1      891      		
; gliss: harmonize down .1 semitones with max feedback
;	st	dur	gain	delay	nsemis	ifeed	lfohz	
i09 4  4      .4     .0123  -.1    .99    0        
; Play soundin.892 - a single bass sample
;	st	dur	dry	wet	soundin#
i08 8  4      .5     .8     892     		
; flange: +/- .2 semitones with feedback and slow lfo
;	st	dur	gain	delay	nsemis	ifeed	lfohz	
i09 8  4.5    .75    .05    -.2    .7     .5        
e								

