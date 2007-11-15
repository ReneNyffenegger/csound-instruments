;Function 3 uses the GEN20 subroutine to compute a Hanning window for use as a grain envelope

;Function 4 uses the GEN01 subroutine to read in an AIF audio file

;Function 5 uses the GEN01 subroutine to read in annother AIF audio file

;Function 6 uses the GEN07 subroutine to compute a linear AR "GATE" envelope function

;Function 7 uses the GEN07 subroutine to compute a linear ADSR envelope function

;Function 8 uses the GEN05 subroutine to compute an exponential ADSR envelope function



f 3 0 4097  20    2     1   

f 4 0 0     1     "sing.aif"  0     4     0   

f 5 0 0     1     "hellorcb.aif"    0     4     0   

f 6 0 1024  7     0     10    1     1000  1     14    0  

f 7 0 1024  7     0     128   1     128   .6    512   .6    256   0 

f 8 0 1024  5     .01   256   1     192   .5    256   .5    64    .01



;ins	strt	dur 	amp		frq1	sample	envfn	frq2   frq3

;============================================================================

i 118  0      2.31   30000  440    4      7      430    450

i 118  3      4.62   30000  220    4      8      225    215

i 118  8      2.28   10000  442    5      6      444    438

i 118  8.3    2.28   10000  438    5      6      441    435

i 118  8.8    2.1    10000  450    5      6      460    445

i 118  11     4.62   10000  219    4      3      221    218

i 118  11     4.62   10000  440    4      7      438    442

i 118  11.5   2.31   10000  554.4  4      8      550    560		

i 118  12     2.31   10000  659.2  4      7      640    666		

i 118  14     3      20000  440    5      6      439    441

