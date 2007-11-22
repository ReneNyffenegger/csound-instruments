; FILTERDRUM.SCO

; p3 = duration
; p4 = amplitude
; p5 = pitch in pch
; p6 = pitch bend in oct

; sine wave
f1  0.00    1024  10    1			

; linear rise
f2  0.00    513   7     1     51    
      2     1     1     1   

; linear decay
f3  0.00    513   7     1     51  
      2     10    1     1   

; exponential rise
f4  0.00    513   5     0.001 51
      2     1     1     1   

; exponential decay
f5  0.00    513   5     1     51  
      2     0.001 1     1   

; p1	p2		p3		p4		p5		p6 
i1  0.00      7.00   15000  11.00  -1.00
e
