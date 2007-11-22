;		Score for final project in Digital Audio Processing
;		---------------------------------------------------

;			Piece entitled : X A N A D U (long version)
;				Joseph T. Kung, 12/12/88

;          	The first part of the score will specify all function
;		tables used in the piece. The second part specifies
;		the instruments and notes. The latter is divided into
;		7 sections, each playing a chord on a different instrument.
;		The chords are uncommon guitar chords that use the open
;		B and E strings often. These will be transposed by
;		octaves on some chords.

;		Each instrument will play a chord. The timbre
;		of the instrument will change in that interval and join
;		with the next instrument/chord sequence. Instrument 3
;		uses a modified FM synthesis technique. This is joined
;		by an additional plucked-string instrument
;		(instruments 1 and 2). The results are effected using
;		choruses, delays, and echoes. Reverb will be suppplied
;		by an external source (Lexicon PCM70).

;	The Function Tables
;	-------------------
;All functions are post-normalized (max value is 1) if p4 is POSITIVE.

f31 0 8192  10    1                     ;sine wave
f32 0 8192  11    1                     ;cosine wave
f33 0 8192  -12   20.0                  ;unscaled ln(I(x)) from 0 to 20.0

;-----------------------------------------------------------------------------

;----------- This section comprises all the new FM sounds -----------------

;Seção 1
i3  0  30     0      5.10   2.0    0.2  ;Bb
i3  0  30     0      6.10   2.0    0.2  ;Bb
i3  0  24     0      7.05   2.0    0.2  ;F
i3  0  18     0      7.10   2.0    0.2  ;Bb
i3  0  10     0      8.01   2.0    0.2  ;Db
i3  0  10     0      8.05   2.0    0.2  ;F
i3  0  10     0      9.00   2.0    0.2  ;C

i3  10 26     0      8.02   2.0    0.2  ;D
i3  10 8      0      8.10   2.0    0.2  ;Bb
i3  10 26     0      10.00  2.0    0.2  ;C

i3  18 18     0      7.08   2.0    0.2  ;Ab - G#
i3  18 18     0      8.08   2.0    0.2  ;Ab - G#

i3  24 18.5   0      7.04   2.0    0.2  ;E

i3  30 6      0      5.11   2.0    0.2  ;B
i3  30 6      0      6.11   2.0    0.2  ;B

;--------------- seção 2 ----------------;

i3  34 11     0      5.09   2.0    0.2  ;A
i3  34 11     0      6.09   2.0    0.2  ;A

i3  34 6      0      7.09   2.0    0.2  ;A
i3  34 3.5    0      8.00   2.0    0.2  ;C
i3  34 3.5    0      8.04   2.0    0.2  ;E
i3  34 3.5    0      8.11   2.0    0.2  ;B

i3  37.5      12.5   0      8.01   2.0    0.2 ;C#-Db
i3  37.5      2.5    0      8.09   2.0    0.2 ;A
i3  37.5      12.5   0      9.11   2.0    0.2 ;Cb

i3  40 10     0      7.07   2.0    0.2  ;G
i3  40 10     0      8.07   2.0    0.2  ;G

i3  42.5      7.5    0      7.03   2.0    0.2 ;Eb

i3  45 5      0      5.10   2.0    0.2  ;Bb
i3  45 5      0      6.10   2.0    0.2  ;Bb



;---------------------------------------------

; TRAPPED IN CONVERT - Richard Boulanger

; written July 1979 in music11
; TRAPPED IN CONVERT - Richard Boulanger
;MARACAS
; written July 1979 in music11
; M.I.T. Experimental Music Studio

; revised June 1986 in Csound
; M.I.T. Media Lab

; revised  May 1989 in PCsound
; for the M.T.U. Digisound 16

;----------------------------------

f11 0 1024  10    1  
f22 0 9     -2    .001  .004  .007  .003  .002  .005  .009  .006
f92 0 512   10    10    8     0     6     0     4     0     1   
f93 0 512   10    10    0     5     5     0     4     3     0     1   
f94 0 512   10    10    0     9     0     0     8     0     7     0     4     0     2     0     1     0   

;i5:  p4=cps of pan


;i9:  p4=del attn,p5=frq,p6=amp,p7=rvb attn,p8=rndamp,p9=rndfrq,p10=1 for space


;i11: p2=strt,p3=dur



i5  5  7.1    .1 
i11 5  7.1
i9  5  6.1    .6     12.022 1200   .8     6.4    311
i9  5.2       5.7    .5     12.011 1200   .8     7      276  
;i9  5.2    1.3       .4      5.011   3000      .3    3.6     160
;i9  6    1.3       .2      5.02   3200      .5     4.1     200
;i9  7    1.3       .4      5.011   3000      .3    3.6     160
;i9  8.0      3       .4      5.02   2670      .8      4       200
;i9  8.01   3.09      .4     5.021  2700      .89     3.9     210

i5  13 7      .0618
i11 13 7
i9  13 1.5    .8     8.09   2000   .3     33     27  
i9  13.1      1.4    .8     8.088  2000   .3     33     27  
i9  13.3      1.3    .8     8.086  2000   .3     33     27  

i9  14.5      1.5    .8     8.10   2000   .3     33     27  
i9  14.6      1.4    .8     8.98   2000   .3     33     27  
i9  14.7      1.3    .8     8.96   2000   .3     33     27  

i9  16 1.2    .8     8.09   2000   .3     33     27  
i9  16.1      1.1    .8     8.088  2000   .3     33     27  
i9  16.2      1.0    .8     8.086  2000   .3     33     27  

i9  17.0      2      .8     8.082  1500   .3     33     27  
i9  17.1      .      .8     8.08   1500   .3     33     27  
i9  17.2      .      .8     8.079  1500   .3     33     27  
i9  17.3      .      .8     8.078  1500   .3     33     27  
i9  17.4      .      .8     8.079  1500   .3     33     27  
i9  17.6      .      .8     8.08   1500   .3     33     27  

i5  21 4      .1   
i11 21 4
i9  21 6.1    .6     12.052 1200   .8     6.4    311
i9  21 5.7    .5     12.041 1200   .8     7      276  
;;i9  21    1.0       .4      5.051   3000      .3    3.6     160
;i9  21.6    1.0       .2      5.04   3200      .5     4.1     200
;i9  22.2    1.0       .4      5.051   3000      .3    3.6     160
;i9  22.8     1.5       .4      5.04   2670      .8      4       200
;i9  22.9   1.4      .4     5.041  2700      .89     3.9     210

i5  27 7      .0618
i11 27 7
i9  27 1.1    .8     7.10   2000   .3     33     27  
i9  27.1      1.0    .8     7.098  2000   .3     33     27  
i9  27.2      0.9    .8     7.096  2000   .3     33     27  

i9  28 1.1    .8     7.11   2000   .3     33     27  
i9  28.1      1.0    .8     7.108  2000   .3     33     27  
i9  28.2      0.9    .8     7.106  2000   .3     33     27  

i9  29 1.1    .8     7.10   2000   .3     33     27  
i9  29.1      1.0    .8     7.098  2000   .3     33     27  
i9  29.2      0.9    .8     7.096  2000   .3     33     27  

i9  30 3      .2     5.11   2200   .5     4.1    200
i9  30.0      3      .8     7.112  1500   .3     33     27  
i9  30.1      .      .8     7.11   1500   .3     33     27  
i9  30.2      .      .8     7.109  1500   .3     33     27  
i9  30.3      .      .8     7.108  1500   .3     33     27  
i9  30.4      .      .8     7.109  1500   .3     33     27  
i9  30.6      .      .8     7.11   1500   .3     33     27  


;--------------- seção 2 ---------;
;i5   40     2    9.8
;i13  40     2    6.8      9.09    300    60.0     6000    30      .1
;i13  40.03   2    6.8      10.01    300    50.0     5000    35      .1
;i13  40.06   2       6.8      10.07    300   100.0     7000    16      .1

i5  45 1      9.8  
i13 45 1      6.8    9.10   300    60.0   6000   30     .1  
i13 45.03     1      6.8    10.01  300    50.0   5000   35     .1  
i13 45.06     1      6.8    10.07  300    100.0  7000   16     .1  

;AGOGÔ
;   ============    Score for Risset's "Bell" Instrument     ==========   ;

f1  0 2048  10    1                     ; fundamental
f5  0 513   5     1024  512   1         ; Amplitude envelope with extended guard point

;       start   dur     freq    amp


;i6      40       4       10.09	1500
;i6      40.5     4       10.09	1500
;i6      41       4       10.09	1500
;i6      41.5     4       10.09	1500

i6  45 4      10.10  1500
i6  45.5      4      10.10  1500


;    =============  Score for Risset's "Drum" Instrument  =============   ;

f 2 0 512   5     4096  512   1 
f 3 0 512   9     10    1     0     16    1.5   0     22    2     0     23    1.5   0 
f 4 0 512   5     256   512   1 


;i7      40 .1 8.07 8000
;i7      + .  8.04 
;i7      . .  8.01 
;i7      . .  8.01 
;i7      . .  7.09 
;i7      . .  7.09 
;i7      . .  8.01 
;i7      . .  8.01 
;i7      . .  8.04 
;i7      . .  8.07 
;i7      . .  8.07
;i7      . .  8.04 
;i7      . .  8.01 
;i7      . .  8.01 
;i7      . .  7.09 
;i7      . .  7.09 
;i7      . .  8.01 
;i7      . .  8.01 
;i7      . .  8.04 
;i7      . .  8.07 

i7  45 .1     8.07   8000
i7  +  .      8.04 
i7  .  .      8.01 
i7  .  .      8.01 
i7  .  .      7.09 
i7  .  .      7.09 
i7  .  .      8.01 
i7  .  .      8.01 
i7  .  .      8.04 
i7  .  .      8.07 

e
