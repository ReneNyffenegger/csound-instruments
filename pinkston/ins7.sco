;Test Score for Pinkston Complex Instrument 7 (Constrained Random)
; pitch function 1 - a C minor 7 chord with octave doublings								
f01 0 8     -2    6.00  6.07  7.00  7.07	
      8.00  8.03  8.07  8.10	
; amp factor function (quarter sine wave)								
f02 0 129   9     .25   1     0   
; duration function 1 - just quarters or 8ths								
f03 0 2     -2    .25   .125
; duration function 2 - mostly 8ths, some quarters and 16ths								
f04 0 8     -2    .25   .25   .125  .125
                        .125    .125    .0625   .0625
; pitch function 2 - lots of Fs with some quarter and 8th-tone detunings								
; some rests, too.								
f05 0 32    -2    9.05  9.05  9.05  9.05  9.05
      10.05 10.05 10.05 8.05  8.05  9.055 9.055 10.055
      9.045 9.045 10.045      8.055 8.055 10.055      10.055      9.0525
      9.0525      9.0525      9.0475      9.0475      9.0475
; pitch function 3 - low Ebs and Fbs, an occasional Bb or rest								
f06 0 8     -2    7.03  7.03  7.03  7.03	
      7.05  7.05  6.10		
; dur function 3 - only 3 choices: two thirds 16ths, one third 8th notes								
f07 0 4     -2    .0625 .0625 .125		
;								
;=========================================================================;								
; Generate a short composition using tables for pitches and durations								
;=========================================================================;								
; Two primary voices for the basic rhythm track								
;	st	dur	pkamp	durfn	pchfn	ampfn	rise	decay
i7  0  40     16000  3      1      2      .001   3 
;	note envlp facs	random seed values						
;	rise	decay	dur	pch	pan			
                        .001    .1      .030251 .071983 .022186			
;	st	dur	pkamp	durfn	pchfn	ampfn	rise	decay
i7  2  38     16000  3      1      2      .001   3 
;	note envlp facs	random seed values						
;	rise	decay	dur	pch	pan			
                        .001    .1      .070703 .012719 .081447			
; Solo voice with some quarter-tones and shorter durations after 12 beats								
;	st	dur	pkamp	durfn	pchfn	ampfn	rise	decay
i7  12 12     20000  4      5      2      2      3    
;	note envlp facs	random seed values						
;	rise	decay	dur	pch	pan			
                        .001    .1      .010149 .100153 .012345			
; Second, faster solo with lower pitches at 25.125 beats								
;	st	dur	pkamp	durfn	pchfn	ampfn	rise	decay
i7  25.125    10     16000  7      6      2      2      3    
;	note envlp facs	random seed values						
;	rise	decay	dur	pch	pan			
                        .001    .1      .030251 .071983 .022186			
e

