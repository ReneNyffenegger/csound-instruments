f   01  0   262144 1 "speech1.aif" 0 4 0    ;GEN1 READS "SPEECH1.AIF" INTO A TABLE
;8192 POINT SINE
f   02  0   8192    10  1
;SQUARE WAVE  ODD HARMONICS (THROUGH 17TH) AT A STRENGTH OF 1/HARMONIC#
f   03  0   513 10  1 0 .333 0 .2 0 .143 0 .111 0 .0909 0 .077 0 .0666 0 .0588
;SAWTOOTH WAVE  ALL HARMONICS (THROUGH 13TH) AT A STRENGTH OF 1/HARMONIC#
f   04  0   513 10  1 .5 .333 .25 .2 .166 .143 .125 .111 .1 .0909 .0833 .077
;PULSE (TRUMPET?)
f   05  0   513 10  .8 .9 .95 .96 1 .91 .8 .75 .6 .42 .5 .4 .33 .28 .2 .15     
;COSINE WAVE (SINE WAVE WITH INITIAL PHASE OF 90 DEGREES):
f   06  0   8192    9   1 1 90
;TRIANGLE WAVE (ODD HARMONICS AT A STRENGTH OF 1/HARMONIC 
;NUMBER WITH INVERTED PHASE FOR EVERY OTHER HARMONIC):
f   07  0   513 9   1 1 0 3 .333 180 5 .2 0 7 .143 180 9 .111 0
;HALF OF A SINE:
f   08  0   513 9   .5 1 0
;A QUASI-GAUSIAN ENVELOPE
f   09  0   1024    -19 1 .5 270 .5
;CYCLE OFFSET CANCELLATION
f   10  0   8192    9   .75 1   0   2.25    1   0       
;CYCLE OFFSET CANCELLATION
f   11  0   8192    9   1.66    1   0   3.33    1   0
;INVERSE PHASE CANCELLATION
f   12  0   8192    9   1.25    1   0   4.25    1   180 
;ENHARMONIC PARTIALS # 21, 22, 25, 27, 31, 33, 35
f   13  0   8192    9   21 1 0 22 1 0 25 1 0 27 1 0 31 1 0 33 1 0 34 1 0 35 1 0 
;PULSE-TRAIN
f   14  0   4096    11  10  1 .9
;SAWTOOTH
f   15  0   512     7   1 512 -1
;SQUARE             
f   16  0   1024    7   1 512 1 0 -1 512 -1
;FOR WAVESHAPING        
f   17  0   512     7   -1 100 -1 312 1 100 1
;A SINGLE IMPULSE   
f   18  0   128     7   1 1 1 0 0
;AN EXPONENTIAL ENVELOPE FUNCTION
f   19  0   1024    5   .001 100 1 824 .75 100 .001             
;QUASI-GUASSIAN
f   20  0   513     8   0 150 0.5 50 1 113 1 50 0.5 150 0
;STRETCHED COSINE
f   21  0   2048    8   1 750 0 550 -1 400 0 348 1
;SMOOTH
f   22  0   8193    6   0 2048 .5 2048 1 2048 0 2049 -1
;POINTS OF INFLECTION ARE NOT BETWEEN ODD ORDINATE VALUES
f   23  0   8193    6   0 2048 1 2048 -1 2048 1 2049 0
;SUCCESSIVE MAXIMA
f   24  0   1024    6   0 256 .25 256 .5 256 .75 256 1
;POLYNOMIAL FUNCTION
f   25  0   1025    3   -1 1 5 2 4 1 3 1 2 1
;WAVESHAPING FUNCTION
f   26  0   1025    7   -1 256 -1 513 1 256 1   
;AMP NORMALIZING FUNCTION
f   27  0   513     4   26 1
;WAVESHAPING FUNCTION: GEN13 - ODD HARMONICS
f   28  0   4097    13  1 1 1 0 .8 0 .5 0 .2
;AMP NORMALIZING FUNCTION
f   280 0   2049    4   28 1
;WAVESHAPING FUNCTION: GEN14 - SAME HARMONICS
f   29  0   4097    14  1 1 1 0 .8 0 .5 0 .2
;AMP NORMALIZING FUNCTION
f   290 0   2049    4   29 1
;WAVESHAPING FUNCTION: GEN14 - EVEN HARMONICS
f   30  0   4097    14  1 1 0 1 0 .6 0 .4 0 .1
;AMP NORMALIZING FUNCTION
f   301 0   2049    4   30 1
;WAVESHAPING FUNCTION: GEN 13 - OVER 20 HARMONICS
f   31  0   4097    13  1 1 1 .666 .5 .3 0 0 .3 0 .2 .25 .33 0 0 .1 0 .45 .33 .2 .1 .1 .15
;AMP NORMALIZING FUNCTION
f   310 0   2049    4   31 1
;SIGNIFICATION
f   32  0   8193    13  1 1 1 1 -1 -1 1 1 -1 -1 1 1 -1 -1 1 1 -1 -1
;AMP NORMALIZING FUNCTION
f   320 0   2049    4   32 1
i 201   0       11      15000   0   .25
i 201   .5      10.5    <       <   <
i 201   1       10      .       .   .
i 201   1.5     9.5     .       .   .
i 201   2       9       .       .   .
i 201   2.5     8.5     .       .   .
i 201   3       8       .       .   .
i 201   3.5     7.5     .       .   .   
i 201   4       7       .       .   .       
i 201   4.5     6.5     .       .   .   
i 201   5       6       .       .   .       
i 201   5.5     5.5     .       .   .   
i 201   6       5       .       .   .       
i 201   6.5     4.5     .       .   .   
i 201   7       4       .       .   .       
i 201   7.5     3.5     .       .   .   
i 201   8       3       .       .   .       
i 201   8.5     2.5     .       .   .   
i 201   9       2       .       .   .       
i 201   9.5     1.5     5000    2   3.5 
s
i 202   00  1 20000 440 02
i .     02  . .     .   03
i .     04  . .     .   04
i .     06  . .     .   05
i .     08  . .     .   06
i .     10  . .     .   07
i .     12  . .     .   08
i .     14  . .     .   09
i .     16  . .     .   10
i .     18  . .     .   11
i .     20  . .     .   12
i .     22  . .     .   13
i .     24  . .     .   14
i .     26  . .     .   15
i .     28  . .     .   16
s
i 203   00  1 20000 440 02
i .     02  . .     .   03
i .     04  . .     .   04
i .     06  . .     .   05
i .     08  . .     .   06
i .     10  . .     .   07
i .     12  . .     .   08
i .     14  . .     .   09
i .     16  . .     .   10
i .     18  . .     .   11
i .     20  . .     .   12
i .     22  . .     .   13
i .     24  . .     .   14
i .     26  . .     .   15
i .     28  . .     .   16
s
i 204 0     3 20000     8.09 13
i 204 4     . .         8.07 13
i 204 8     . .         8.05 13
i 204 12    . .         8.03 13
s
i   205 0   3   20000   440
i   205 4   .   .       220 
i   205 8   .   .       110
s
i   206 0   3   20000   440 28  280 
i   206 4   .   .       .   29  290
i   206 8   .   .       .   30  301
i   206 12  .   .       .   31  310
i   206 16  .   20000   .   32  320
s
f 1     0   8193    10  1               ;8192 POINT SINE FOR USE WITH 
f 2     0   8193    9   1 1 90          ;8192 POINT COSINE FOR USE WITH 
;MAKES FUNCTION TABLES 33 AND 34
f33     0   8193    15  1 1 1 0 1 180 .8 45 .6 270 .5 90 .4 225 .2 135 .1 315
f35     0   4097    4   33 1    ;AMP NORMALIZATION FN FOR f 33
f36     0   4097    4   34 1    ;AMP NORMALIZATION FN FOR f 34
i 207   0   5       20000  8.00 0   1
i 207   +   .       20000  8.00 1   0
s
;EVEN HARMONICS WITH NO PHASE SHIFT, ODD HARMONICS WITH PHASE SHIFT
f 33    0   8193    15  1 1 1 0 1 0 1 180 1 180 1 0 1 0 1 180 1 180 1 0 1 0 1 180 1 180
f 35    0   4097    4   33 1    ;AMP NORMALIZATION FN FOR f 33
f 36    0   4097    4   34 1    ;AMP NORMALIZATION FN FOR f 34
i 207   0   5       20000  8.00 0   1
i 207   +   .       20000  8.00 1   0
s
;DIFFERENT HARMONIC STRENGTHS AND PHASES
f 33    0   8193    15  1 1 1 0 1 0 .9 180 .5 270 .75 90 .4 45 .2 225 .1 0
f 35    0   4097    4   33 1    ;AMP NORMALIZATION FN FOR f 33
f 36    0   4097    4   34 1    ;AMP NORMALIZATION FN FOR f 34
i 207   0   5       20000  8.00 0   1
i 207   +   .       20000  8.00 1   0
s
;LOWER HARMONICS NO PHASE SHIFT, UPPER HARMONICS WITH PHASE SHIFT
f 33    0   8193 15 1   1   1 0 1 0 .5 0 .9 0 .3 0 .75 0 .2 180 .6 180 .15 180 .5 180 .1 180
f 35    0   4097    4   33 1    ;AMP NORMALIZATION FN FOR f 33
f 36    0   4097    4   34 1    ;AMP NORMALIZATION FN FOR f 34
i 207   0   5       20000  8.00 0   1
i 207   +   .       20000  8.00 1   0
s
;LOWER HARMONICS WITH PHASE SHIFT, UPPER HARMONICS NO PHASE SHIFT
f 33    0   8193    15  1 1 1 180 1 180 .5 180 .9 180 .3 180 .75 180 .2 0 .6 0 .15 0 .5 0 .1 0
f 35    0   4097    4   33 1    ;AMP NORMALIZATION FN FOR f 33
f 36    0   4097    4   34 1    ;AMP NORMALIZATION FN FOR f 34
i 207   0   5       20000  8.00 0   1
i 207   +   .       20000  8.00 1   0
s
f   1   0   8192    10  1               
f   2   0   8192    9   1 1 90          
f   37  0   1024    -12 40  ;BESSEL FUNCTION-DEFINED FROM 0 TO 40
i 208   0  2  3000      800  800    1    6   .1   2
i 208  +  .  .          1900 147    8    1    4   .2
i 208  .  .  .          1100 380    2    9   .5   2
i 208  .  10  .         100  100    11   3   .2   5
s
i 208  0  1  3000       200 100    1    6   .1   2
i 208  +  .  <          <    <      <    <   <    <
i 208  +  .  .          <    <      <    <   <    <
i 208  +  .  .          <    <      <    <   <    <
i 208  +  .  .          <    <      <    <   <    <
i 208  +  .  .          <    <      <    <   <    <
i 208  +  .  .          <    <      <    <   <    <
i 208  +  10 5000       800  800    9    1   .9   6
s
i 208  0  11 1000       50   51     1    6   .1   2
i 208  1  9  500        700  401    1    6   .1   2
i 208  2  8  .           900 147    8    1    4   .2
i 208  3  7  .          1100 381    2    9   .5   2
i 208  4  6  .          200  102    11   3   .2   5
i 208  5  6  .          800  803    9    1   .9   6
s
f   5   0 513 10 1 0 .333 0 .2 0 .143 0 .111 0 .0909 0 .077 0 .0666
f   10  0 1024 -19 1 .5 270 .5
f   38  0 16 -2 2 1 9 10 5 3 4 0 8 7 6 11
f   39  0   128 -17 0 1 12 2 24 3 36 4 48 5 60 6 72 7 84 8 96 9 108 10 120 11
i 209   0 4  20000 1    .1
s
f0 1
s ; NOTE SAME SEED = SAME PSUEDO-RANDOM SEQUENCE
i 209 0 4  20000 1  .1
s
f0 1
s
i 209 0 4  20000 1  .2
s
f0 1
s
i 209 0 4  10000  2 .3
s
f0 1
s
i 209 0 4  10000  2 .4
s
f0 1
s
i 209 0 4 25000 4   .5
s
f0 1
s
i 209 0 4 25000 4   .6
s
f   40  0   513 20  1 1 ;HAMMING
f   41  0   513 20  2 1 ;HANNING
f   42  0   513 20  3 1 ;BARTLETT
f   43  0   513 20  4 1 ;BLACKMAN
f   44  0   513 20  5 1 ;BLACKMAN-HARRIS
f   45  0   513 20  6 1 ;GUASSIAN
f   46  0   513 20  7 1.75  ;KAISER
f   47  0   513 20  8 1 ;RECTANGLE
f   48  0   513 20  9 1 ;SINC
s
f   49  0   513 21  1 1 ;UNIFORM
f   50  0   513 21  2 1 ;LINEAR
f   51  0   513 21  3 1 ;TRIANGULAR
f   52  0   513 21  4 1 ;EXPONENTIAL
f   53  0   513 21  5 1 ;BIEXPONENTIAL
f   54  0   513 21  6 1 ;GUASSIAN
f   55  0   513 21  7 1 ;CAUCHY
f   56  0   513 21  8 1 ;POSITIVE CAUCHY
f   57  0   513 21  9 1 1 2 ;BETA
f   58  0   513 21  10 1 2  ;WEIBULL
f   59  0   513 21  11 1    ;POISSON
s
f 02    0   8192    10  1           ;SINE
f 03    0   8193    7   -1 8192 1   ;PHASOR FROM -1 TO +1
f 10    0   8192    10  0   0   1 
f 61    0   8192    10  0   0   1
f 62    0   8192    10  1   .43 0 .25 .33 .11 0 .75
f 63    0   8192    9   1   1   0 1.5 1 0
f 64    0   8192    9   3   1   0 3.5 1 0
;p4     =   amp 
;p5-6   =   xtrans: init-final 
;p7-8   =   xoscil amp: init-final 
;p9-10  =   xoscil freq: init-final
;p11    =   x index fn
;p12-13 =   ytrans: init-final
;p14-15 =   yoscil amp: init-final 
;p16-17 =   yoscilfreq: init-final 
;p18    =   y index fn
;p19    =   x plane fn table   
;p20    =   y plane fn table
i 210 0     5 20000 -.5 .5   .1 .1 440 440 3   0  0  1  1 440 440 3 2 2     
i 210 6     5 20000   0  0    1  1 440 440 3 -.5 .5 .1 .1 440 440 3 2 2     
s
i 210 0     5 20000 -.5   .5 .1 10 110 110 3   0  3  3  1 110 110 3 2 2     
i 210 6     5 20000 .25 -.25  3 1  110 110 3 -.5 .5 .1 10 110 110 3 2 2     
s
i 210 0     5 20000 -.5 .5   .1 .1 440 440 3   0  0  1  1 440 440 3 2 61    
i 210 6     5 20000   0  0    1  1 440 440 3 -.5 .5 .1 .1 440 440 3 2 61    
s
i 210 0     5 20000 -.5   .5 .1 10 110 110 3   0  3  3  1 110 110 3 2 61    
i 210 6     5 20000 .25 -.25  3 1  110 110 3 -.5 .5 .1 10 110 110 3 2 61    
s
i 210 0     5 20000 -.5 .5   .1 .1 440 440 3   0  0  1  1 440 440 3 62 10   
i 210 6     5 20000   0  0    1  1 440 440 3 -.5 .5 .1 .1 440 440 3 62 10   
s
i 210 0     5 20000 -.5   .5 .1 10 110 110 3   0  3  3  1 110 110 3 62 10   
i 210 6     5 20000 .25 -.25  3 1  110 110 3 -.5 .5 .1 10 110 110 3 62 10   
s
i 210 0     5 20000 -.5 .5   .1 .1 440 440 3   0  0  1  1 440 440 3 63 64   
i 210 6     5 20000   0  0    1  1 440 440 3 -.5 .5 .1 .1 440 440 3 63 64   
s
i 210 0     5 20000 -.5   .5 .1 10 110 110 3   0  3  3  1 110 110 3 63 64   
i 210 6     5 20000 .25 -.25  3 1  110 110 3 -.5 .5 .1 10 110 110 3 63 64







