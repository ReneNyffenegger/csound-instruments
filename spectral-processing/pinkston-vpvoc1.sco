;Example score for vpvoc instrument
;sine wave
f100  0     8192  10    1  
;Exponential function with spike in lower middle of frequency range
f1  0 512   5     .001  128   1     384   .001
;Exponential function with hole in lower middle of frequency range
f2  0 512   5     1     128   .001  384   1 
;Flat frequency response (all 1's straight across)
f3  0 512   7     1     512   1 
;Ramp for linear timepoint movement
f4  0 513   7     0     513   1 
;Reverse ramp
f5  0 513   7     1     513   0 
;Forward to half way, then reverse
f6  0 512   -7    0     257   .5    256   0 
;Half way to start and back
f7  0 512   -7    .5    257   0     256   .5
;Pass a band of frequencies around 500 Hz
f8  0 512   17    0     0     15    1     32    0		
;move from notched to flat to peak
;Pass a band of frequencies around 1000 Hz
f9  0 512   17    0     0     31    1     64    0			
;Pass a single bin at about 500 Hz
f10 0 512   17    0     0     15    1     16    0	
;Pass bins 16-19 only
f11 0 512   17    0     0     15    1     19    0  
;custom time point function
f12 0 513   -7    0     171   .59   171   .1    171   .59
;bins 1, 2, 4, 8, 16, and 32 only
f13 0 512   2 
      1     1     0     1     0     0     0     1   
      0     0     0     0     0     0     0     1   
      0     0     0     0     0     0     0     0   
      0     0     0     0     0     0     0     1   
;pvoc.309 was produced by pvanal -n1024 -w8 crashcym.wav pvoc.309
;nn	st	dur	.nnn	length	tpfn	ipshift	
i01 0  6      "crashcym.pvx"       3      6      0    
;	fn1	dur1	fn2	dur2	fn3	dur3	fn4	gain
                        2       3       3       3       1       0       0       2     
;move from peak to flat to notched
i01 7  6      "crashcym.pvx"       3      6      0    
       1      3      3      3      2      0      0      2    
f0  14
s
;Crossfade between bins 16-31 and 32-63
i01 0  6      "crashcym.pvx"       3      6      0    
       8      6      9      0      8      0      0      2    
f0  7
s
;Play sound at original speed and pitch...
;nn	st	dur	.nnn	length	tpfn	ipshift	
i01 0  3      "crashcym.pvx"       3      4      0    
;	fn1	dur1	fn2	dur2	fn3	dur3	fn4	gain
                        3       3       3       0       0       0       0       2     
;...combined with stretched bins 2, 4, 8, and 16
i01 0  6      "crashcym.pvx"       3      6      1	 
       13     6      13     0      0      0      0      4    
f0  7
s
;Use vpvoc to crossfade from original sound to bins 16-19 only.
;nn	st	dur	.nnn	length	tpfn	ipshift	
i01 0  6      "crashcym.pvx"       3      12     0   
;	fn1	dur1	fn2	dur2	fn3	dur3	fn4	gain
                        3       2       11      4       11      0       3       2     
f0  7
s
;synthesize bins 16-19 only using pvread and oscil (instr 2)
;	st	dur	.nnn	length	tpfn	binno	gain
i02 0  6      "crashcym.pvx"       3      6      16     300 
i02 .  .      .      .      .      17   
i02 .  .      .      .      .      18   
i02 .  .      .      .      .      19   
e
