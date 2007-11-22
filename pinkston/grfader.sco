;Test score for GRFader.orc. Load the presets file and try the 8 presets.
; f statements read sound files in the SSDIR 
f1  0 262144      1     "BbCl-D0.wav"     0     0     0   
f2  0 262144      1     "BC-Db0.wav"      0     0     0   
f3  0 262144      1     "CBC-Bb0.wav"     0     0     0   
f4  0 262144      1     "CBC-FHi.wav"     0     0     0   
f5  0 262144      1     "EbCl-D6.wav"     0     0     0   
f6  0 65536 1     "thewind.wav"     0     0     0   
; various control functions for gap and size
;no change
f13 0 3     7     1     3     1   
; linear ramp down
f14 0 129   7     1     129   0 
; linear ramp up
f15 0 129   7     0     129   1 
; pyramid
f16 0 129   7     0     64    1     65    0  
; inverse pyramid
f17 0 129   7     1     64    0     65    1  
; hanning window
f18 0 129   20    2  
f0  120
e

