;Test score for Csound filter units
;instr1 = tone filter (simple lowpass)
;nn	st	dur	khp
i01 0  2      8000 
i.  +  .      4000 
i.  +  .      2000 
i.  +  .      1000 
i.  +  .      500  
i.  +  .      250  
i.  +  .      125  
f0  15
s
;instr3 = butterworth lowpass filter
;nn	st	dur	kcf
i03 0  2      8000 
i.  +  .      4000 
i.  +  .      2000 
i.  +  .      1000 
i.  +  .      500  
i.  +  .      250  
i.  +  .      125  
f0  15
s
;instr7 = reson used as lowpass filters. We set the cf to 0 and adjust the bw.
; Note that the half power point (cutoff frequency) will by .707 * kbw
;nn	st	dur	kcf	kbw
i07 0  2      0      8000 
i.  +  .      .      4000 
i.  +  .      .      2000 
i.  +  .      .      1000 
i.  +  .      .      500  
i.  +  .      .      250  
i.  +  .      .      125  
f0  15
s
;instr2 = atone filter
;nn	st	dur	khp
i02 0  2      250  
i.  +  .      500  
i.  +  .      1000 
i.  +  .      2000 
i.  +  .      4000 
i.  +  .      8000 
f0  13
s
;instr4 = butterworth hipass filter
;nn	st	dur	kcf
i04 0  2      250  
i.  +  .      500  
i.  +  .      1000 
i.  +  .      2000 
i.  +  .      4000 
i.  +  .      8000 
f0  13
s
;instr8 = two cascaded resons used as a sharp bandpass filter. 
;nn	st	dur	kcf	Q	iscl	igain
i08 0  2      100    10     1      0	   
i.  +  .      200    
i.  +  .      400    
i.  +  .      600    
i.  +  .      800    .      .      .9   
i.  +  .      1600   .      .      .7   
f0  13
s
;instr9 = two cascaded butterbps used as a sharp bandpass filter. 
;nn	st	dur	kcf	Q	iscl	igain
i09 0  2      100    10     1      0	   
i.  +  .      200    
i.  +  .      400    
i.  +  .      600    
i.  +  .      800    .      .      .9   
i.  +  .      1600   .      .      .6   
e
