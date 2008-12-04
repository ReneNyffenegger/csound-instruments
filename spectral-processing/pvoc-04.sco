        ;; karpen
f 1 0 512   5     1     512   .001      ; LOWPASS
f 2 0 512   7     1     100   1     1     0     411   0 ; LOWSHELF
f 3 0 512   5     .001  256   1     256   .001 ; BANDREJECT
f 4 0 512   9     .5    1     0         ; BANDPASS

        ;; pinkston
;Exponential function with spike in lower middle of frequency range
f5  0 512   5     .001  128   1     384   .001
;Exponential function with hole in lower middle of frequency range
f6  0 512   5     1     128   .001  384   1 
;Flat frequency response (all 1's straight across)
f7  0 512   7     1     512   1 
;Ramp for linear timepoint movement
f8  0 513   7     0     513   1 
;Reverse ramp
f9  0 513   7     1     513   0 
;Forward to half way, then reverse
f10  0 512   -7    0     257   .5    256   0 
;Half way to start and back
f11  0 512   -7    .5    257   0     256   .5
;Pass a band of frequencies around 500 Hz
f12  0 512   17    0     0     15    1     32    0		
;move from notched to flat to peak
;Pass a band of frequencies around 1000 Hz
f13  0 512   17    0     0     31    1     64    0			
;Pass a single bin at about 500 Hz
f10 0 512   17    0     0     15    1     16    0	
;Pass bins 16-19 only
f14 0 512   17    0     0     15    1     19    0  
;custom time point function
f15 0 513   -7    0     171   .59   171   .1    171   .59
;bins 1, 2, 4, 8, 16, and 32 only
f16 0 512   2 
      1     1     0     1     0     0     0     1   
      0     0     0     0     0     0     0     1   
      0     0     0     0     0     0     0     0   
      0     0     0     0     0     0     0     1   

        ;; f, d, f, d, f, d, f
i1 0      11      11   "traffic.pvx" 5 1.5 6 1.5 7 1.5 8
s
f0 1
s
i1 0      11      11   "traffic.pvx" 16 1.5 14 1.5 10 1.5 12 1.5 10
s
f0 1
s
i1 0      11      11   "traffic.pvx" 8 1.5 7 1.5 7 1.5 4 1.5 1
s
f0 1
s
i1 0      11      11   "traffic.pvx" 13 1.5 14 1.5 16 1.5 1
