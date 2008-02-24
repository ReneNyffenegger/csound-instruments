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
;Use pvoc.903 (thewind.wav, dur=1.67)
;Analysis frame size = 1024, overlap = 4
;Much better quality here.
;Use spectral warping.
;Also demonstrate pitch shifting.
;nn	st	dur	.nnn	length	tpfn	ipshift	ispecwarp
i1  0  1.67   "wind3.pvx"   1.67   1      3      1    
i1  2  1.67   .      .      2      -3   
i1  4  3.33   .      .      1      0      0    
i1  7.5       .8    
i1  9  10     .      .      3    
f0  20.0
s
;Use pvoc.904 (thewind.wav, dur=1.67)
;Analysis frame size = 1024, overlap = 8
;nn	st	dur	.nnn	length	tpfn	ipshift	ispecwarp
i1  0  1.67   "wind4.pvx"   1.67   1      3      1    
i1  2  1.67   .      .      2      -3   
i1  4  3.33   .      .      1      0    
i1  7.5       .8    
i1  9  10     .      .      3    
f0  20.0
s
;Use pvoc.907 (fire1M44.wav)
;Analysis frame size = 1024, overlap = 4
;nn	st	dur	.nnn	length	tpfn	ipshift	ispecwarp
i1  0  60     "fire1m44"    12.585 3      0      0    
e
