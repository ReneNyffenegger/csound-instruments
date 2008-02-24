;======================================================================;
; Example score for pvoc1.orc. Demonstrates differences in quality 
; between various analysis frame sizes, forward and reverse playback,
; time stretching and compression, pitch shifting by semitones, and 
; the use of a hand drawn control function for the timeptr control.
; RP
;======================================================================;
f01 0 513   7     0     513   1 
f02 0 513   7     1     513   0 
f03 0 513   1     "pvoctest.fun"    0     4     0   
;Use pvoc.901 (thewind.wav, dur=1.67)
;Analysis frame size = 256, overlap = 4
;nn	st	dur	.nnn	length	tpfn	ipshift	ispecwarp
i1  0  1.67   "wind1.pvx"   1.67   1      0      0    
i1  2  1.67   .      .      2          
i1  4  3.33   .      .      1          
i1  7.5       .8    
f0  9.0
s
;Use pvoc.902 (thewind.wav, dur=1.67)
;Analysis frame size = 128, overlap = 4
;Note poor quality with this frame size
;nn	st	dur	.nnn	length	tpfn	ipshift	ispecwarp
i1  0  1.67   "thewind2.pvx"   1.67   1      0      0    
i1  2  1.67   .      .      2    
i1  4  3.33   .      .      1    
i1  7.5       .8    
f0  9.0
e