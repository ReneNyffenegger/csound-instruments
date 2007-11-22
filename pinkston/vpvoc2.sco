;Example score for vpvoc instrument
;Note: pvoc.309 is an analysis file of crashcym.wav, analyzed with -n1024 and -w8
;Exponential function with peak at about 5.5KHz
f1  0 512   5     .001  128   1     384   .001
;Exponential function with notch at about 5.5KHz
f2  0 512   5     1     128   .001  384   1 
;Flat frequency response (all 1's straight across)
f3  0 512   7     1     512   1 
;Ramp for linear timepoint movement
f4  0 513   7     0     513   1 
;Forward and backward timepoint
f5  0 513   7     0     256   1     257   0 
;High Pass with cutoff at approximately 2K
f6  0 512   17    0     0     47    1     512   1 
;Low Pass with cutoff at approximately 500Hz
f7  0 512   17    0     1     12    0     512   0 
;Band Pass with cf at 1KHz and a 200Hz bw (no HP and infinite rolloff)
f8  0 512   17    0     0     21    1     26    0     512   0 
;Notch with cf at 2KHz and a 1KHz bw (no HP and infinite rolloff)
f9  0 512   17    0     1     36    0     58    1     512   1 
;Band Pass with cf at 200Hz and a 50Hz bw (Q of 4)
f10 0 512   17    0     0     4     1     7     0     512   0 
;Band Pass with cf at 4000Hz and a 1KHz bw (Q of 4)
f11 0 512   17    0     0     82    1     106   0     512   0 
;Forward to half way, then reverse
f16 0 512   -7    0     257   .5    256   0       
;Pass a band of frequencies around 500 Hz
f18 0 512   17    0     0     15    1     32    0		
;move from notched to flat to peak
;Pass a band of frequencies around 1000 Hz
f19 0 512   17    0     0     31    1     64    0			
;Pass a single bin at about 500 Hz
f20 0 512   17    0     0     15    1     16    0	
;Pass bins 16-19 only
f21 0 512   17    0     0     15    1     19    0  
;custom time point function
f22 0 513   -7    0     171   .59   171   .1    171   .59
;bins 1, 2, 4, 8, 16, and 32 only
f23 0 512   2 
      1     1     0     1     0     0     0     1   
      0     0     0     0     0     0     0     1   
      0     0     0     0     0     0     0     0   
      0     0     0     0     0     0     0     1   
;sine wave
f100  0     8192  10    1  
;Unfiltered
;nn	st	dur	.nnn	length	tpfn	ipshift	
i01 0  3      "crashcym.pvx"       1.5    5      0    
;	fn1	dur1	igain1	fn2	dur2	igain2	
                        3       1       4       0       0       0     
;	fn3	dur3	igain3	fn4	igain4
                        0       0       0       0       0	
;Remove a band ca 1000Hz wide, centered around 2KHz
;nn	st	dur	.nnn	length	tpfn	ipshift	
i01 4  3      "crashcym.pvx"       1.5    5      0    
;	fn1	dur1	igain1	fn2	dur2	igain2	
                        9       1       4       0       0       0     
;	fn3	dur3	igain3	fn4	igain4
                        0       0       0       0       0     
;Pass a band ca 200Hz wide, centered around 1KHz
;nn	st	dur	.nnn	length	tpfn	ipshift	
i01 8  3      "crashcym.pvx"       1.5    5      0    
;	fn1	dur1	igain1	fn2	dur2	igain2	
                        8       1       22      0       0       0     
;	fn3	dur3	igain3	fn4	igain4
                        0       0       0       0       0     
;High Pass
;nn	st	dur	.nnn	length	tpfn	ipshift	
i01 12 3      "crashcym.pvx"       1.5    5      0    
;	fn1	dur1	igain1	fn2	dur2	igain2	
                        6       1       5       0       0       0     
;	fn3	dur3	igain3	fn4	igain4
                        0       0       0       0       0     
;Low Pass
;nn	st	dur	.nnn	length	tpfn	ipshift	
i01 16 3      "crashcym.pvx"       1.5    5      0    
;	fn1	dur1	igain1	fn2	dur2	igain2	
                        7       1       12      0       0       0     
;	fn3	dur3	igain3	fn4	igain4
                        0       0       0       0       0     
f0  20
s
;move from flat to notched to peak to flat
;nn	st	dur	.nnn	length	tpfn	ipshift	
i01 0  3      "crashcym.pvx"       1.5    5      0    
;	fn1	dur1	igain1	fn2	dur2	igain2	
                        3       1       4       2       1       0     
;	fn3	dur3	igain3	fn4	igain4
                        1       1       0       3       0     
;move from flat to peak to notched to flat
;nn	st	dur	.nnn	length	tpfn	ipshift	
i01 4  3      "crashcym.pvx"       1.5    5      0    
;	fn1	dur1	igain1	fn2	dur2	igain2	
                        3       .5      5       1       1       0     
;	fn3	dur3	igain3	fn4	igain4
                        2       1.5     0       3       0     
;slow down and move from start of sound to middle and back, from notched to flat to peak
;nn	st	dur	.nnn	length	tpfn	ipshift	
i01 8  6      "crashcym.pvx"       3      16     0   
;	fn1	dur1	igain1	fn2	dur2	igain2
                        2       3       10      3       3       0     
;	fn3	dur3	igain3	fn4	igain4
                        1       0       0       0       0     
;same, from peak to flat to notched
i01 15 6      "crashcym.pvx"       3      16     0   
;	fn1	dur1	igain1	fn2	dur2	igain2
                        1       3       10      3       3       0     
;	fn3	dur3	igain3	fn4	igain4
                        2       0       0       0       0     
f0  22
s
;exchange bands at 500 and 4000
;nn	st	dur	.nnn	length	tpfn	ipshift	
i01 0  3      "crashcym.pvx"       1.5    5      0    
;	fn1	dur1	igain1	fn2	dur2	igain2	
                        8       3       18      11      0       12    
;	fn3	dur3	igain3	fn4	igain4
                        0       0       0       0       0     
;Repeat down 2 octaves
;nn	st	dur	.nnn	length	tpfn	ipshift	
i01 4  3      "crashcym.pvx"       1.5    5      -24  
;	fn1	dur1	igain1	fn2	dur2	igain2	
                        8       3       19      11      0       12    
;	fn3	dur3	igain3	fn4	igain4
                        0       0       0       0       0     
f0  8
s
;Crossfade between bins 16-31 and 32-63
i01 0  6      "crashcym.pvx"       3      16     0   
;	fn1	dur1	igain1	fn2	dur2	igain2
                        18      6       14      19      0       0     
;	fn3	dur3	igain3	fn4	igain4
                        18      0       0       0       0     
f0  7
s
;Play sound at original speed and pitch...
;nn	st	dur	.nnn	length	tpfn	ipshift	
i01 0  3      "crashcym.pvx"       3      4      0    
;	fn1	dur1	igain1	fn2	dur2	igain2
                        3       3       4       3       0       0     
;	fn3	dur3	igain3	fn4	igain4
                        0       0       0       0       0     
;...combined with stretched bins 2, 4, 8, and 16
i01 0  6      "crashcym.pvx"       3      16     1	 
;	fn1	dur1	igain1	fn2	dur2	igain2
                        23      6       10      23      0       0     
;	fn3	dur3	igain3	fn4	igain4
                        0       0       0       0       0     
f0  7
s
;Use vpvoc to crossfade from original sound to bins 16-19 only.
;nn	st	dur	.nnn	length	tpfn	ipshift	
i01 0  6      "crashcym.pvx"       3      22     0   
;	fn1	dur1	igain1	fn2	dur2	igain2
                        3       3       4       21      4       6     
;	fn3	dur3	igain3	fn4	igain4
                        21      0       0       3       0     
f0  7
s
;synthesize bins 16-19 only using pvread and oscil (instr 2)
;	st	dur	.nnn	length	tpfn	binno	gain
i02 0  6      "crashcym.pvx"       3      16     16     10  
i02 .  .      .      .      .      17   
i02 .  .      .      .      .      18   
i02 .  .      .      .      .      19   
e
