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

;----------- This section comprises all the new FM sounds -----------------

;acordes 1 (F#m + C#7) e 2 (F#m + D7)

i3  18 .5     0      5.06   2.0    0.2  ;F#
i3  18 .5     0      6.06   2.0    0.2  ;F#
i3  18 .5     0      7.09   2.0    0.2  ;A
i3  18 22     0      5.06   2.0    0.2  ;F#
i3  18 22     0      6.06   2.0    0.2  ;F#
i3  18 22     0      7.09   2.0    0.2  ;A

i3  19.5      .25    0      9.11   2.0    0.2 ;B
i3  19.5      9      0      9.11   2.0    0.2 ;B
i3  20 .25    0      8.05   2.0    0.2  ;E#
i3  20 9      0      8.05   2.0    0.2  ;E#

i3  21.5      .25    0      9.01   2.0    0.2 ;C#
i3  21.5      9      0      9.01   2.0    0.2 ;C#
i3  22 .25    0      9.08   2.0    0.2  ;G#
i3  22 9      0      9.08   2.0    0.2  ;G#

i3  26 15     0      10.00  2.0    0.2  ;C
i3  26.5      14.5   0      8.06   2.0    0.2 ;F#

i3  27.5      16     0      9.02   2.0    0.2 ;D
i3  28 16     0      9.09   2.0    0.2  ;A

;acordes 3 (G+Dm7) e 4 (G+Db7)

i3  37 35     0      5.07   2.0    0.2  ;G
i3  37 35     0      6.07   2.0    0.2  ;G
i3  37 35     0      7.11   2.0    0.2  ;B

i3  38.5      33.5   0      8.05   2.0    0.2 ;F
i3  39 33     0      9.11   2.0    0.2  ;Cb

i3  40.5      31.5   0      9.01   2.0    0.2 ;Db
i3  41 31     0      9.08   2.0    0.2  ;Ab


;---------------------------------------------

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

;============================== Parameters ===============================;

;i5:  p4=cps of pan
;i9:  p4=del attn,p5=frq,p6=amp,p7=rvb attn,p8=rndamp,p9=rndfrq,p10=1 for space
;i11: p2=strt,p3=dur
;i13: p6=amp,p7=swp strt,p8=swp peak,p9=bndwth,p10=rvb attn

;========================= ======================= =======================;

; i9

i5  0  26     .1  
i11 0  26

i9  0  .3     .4     6.001  4000   .3     3.6    160
i9  .25       .2     .2     5.112  4000   .3     4.1    200
i9  1.25      .2     .2     5.052  4000   .3     4.1    200
i9  1.25      6      .2     5.052  3000   .2     4.1    200
i9  1.25      6      .2     4.052  2000   .2     4.1    200
i9  1.25      6      .6     12.002 1000   .7     2      276  
i9  1.25      6      .5     11.111 1000   .7     2      276  

i9  7  .3     .4     6.011  4000   .3     3.6    160
i9  7.25      .2     .2     6.002  4000   .3     4.1    200
i9  8.75      .2     .2     5.062  4000   .3     4.1    200
i9  8.75      13     .2     5.062  3000   .2     4.1    200
i9  8.75      13     .2     4.062  2000   .2     4.1    200
i9  8.75      15     .6     12.012 1000   .7     2      276  
i9  8.75      15     .5     12.001 1000   .7     2      276  

i11 48 2
i9  48 2      .8     9.08   2000   .3     33     27  
i9  48.1      1.9    .8     9.078  2000   .3     33     27  
i9  48.3      1.7    .8     9.076  2000   .3     33     27  

i5  53 3      .1   
i11 53 3
i9  53 3      .8     8.07   2000   .3     33     27  
i9  53.1      2.9    .8     8.068  2000   .3     33     27  
i9  53.3      2.7    .8     8.066  2000   .3     33     27  

i5  60 12     .1  
i11 60 12
i9  60 5      .4     6.01   3000   .3     3.6    160
i9  60.1      4.9    .4     6.008  3000
i9  60 5      .2     5.01   2000   .5     4.1    200

i9  65 .3     .4     6.00   3000   .3     3.6    160
i9  65 .3     .4     5.118  3000
i9  65 .3     .2     5.00   2000   .5     4.1    200

i9  67.5      .2     .4     6.01   2500   .3     3.6    160
i9  67.5      .2     .4     6.008  2500
i9  67.5      .2     .2     5.01   1500   .5     4.1    200

i9  70 .2     .4     6.00   2000   .3     3.6    160
i9  70 .2     .4     5.118  2000
i9  70 .2     .2     5.00   1000   .5     4.1    200

; i13

i5  46 4      9.8  
i13 46 2      0      5.01   1000   100.0  7000   16     .16 
i13 46.03     2      0      5.07   1000   100.0  7000   16     .16 

i5  50 3.03   1.8
i13 50 3      0      5.01   1000   100.0  7000   16     .16 
i13 50.03     3      0      5.07   1000   100.0  7000   16     .16 

i5  56 4.03   0.8
i13 56 4      0      5.01   1000   100.0  7000   16     .15 
i13 56.03     4      0      5.07   1000   100.0  7000   16     .15 

;AGOGÔ
;   ============    Score for Risset's "Bell" Instrument     ==========   ;

f1  0 2048  10    1                     ; fundamental
f5  0 513   5     1024  512   1         ; Amplitude envelope with extended guard point

;       start   dur     freq    amp

i6  46 4      10.08  1500
i6  46.5      4      10.08  1500
i6  47 4      10.08  1500
i6  47.5      4      10.08  1500
i6  48 4      10.08  1500

i6  50 4      10.07  1500
i6  50.8      4      10.07  1500
i6  51.6      4      10.07  1500
i6  52.4      4      10.07  1500

i6  56 4      10.01  1500
i6  57 4      10.01  1500
i6  58 4      10.01  1500
i6  59 4      10.01  1500
i6  60 4      10.01  1500


;    =============  Score for Risset's "Drum" Instrument  =============   ;

f 2 0 512   5     4096  512   1 
f 3 0 512   9     10    1     0     16    1.5   0     22    2     0     23    1.5   0 
f 4 0 512   5     256   512   1 

i7  46 .1     8.11   8000
i7  +  .      8.08 
i7  .  .      8.05 
i7  .  .      8.01 
i7  .  .      7.11 
i7  .  .      7.07 
i7  .  .      7.11 
i7  .  .      8.01 
i7  .  .      8.05 
i7  .  .      8.08 
i7  .  .      8.11 
i7  .  .      8.08 
i7  .  .      8.05 
i7  .  .      8.01 
i7  .  .      7.11 
i7  .  .      7.07 
i7  .  .      7.11 
i7  .  .      8.01 
i7  .  .      8.05 
i7  .  .      8.08 
i7  .  .      8.11 
i7  .  .      8.08 
i7  .  .      8.05 
i7  .  .      8.01 

i7  50 .15    8.11   8000
i7  +  .      8.08 
i7  .  .      8.05 
i7  .  .      8.01 
i7  .  .      7.11 
i7  .  .      7.07 
i7  .  .      7.11 
i7  .  .      8.01 
i7  .  .      8.05 
i7  .  .      8.08 
i7  .  .      8.11 
i7  .  .      8.08 
i7  .  .      8.05 
i7  .  .      8.01 
i7  .  .      7.11 
i7  .  .      7.07 
i7  .  .      7.11 
i7  .  .      8.01 
i7  .  .      8.05 
i7  .  .      8.08 
i7  .  .      8.11 
i7  .  .      8.08 
i7  .  .      8.05 

i7  56 .18    8.11   8000
i7  +  .      8.08 
i7  .  .      8.05 
i7  .  .      8.01 
i7  .  .      7.11 
i7  .  .      7.07 
i7  .  .      7.11 
i7  .  .      8.01 
i7  .  .      8.05 
i7  .  .      8.08 
i7  .  .      8.11 
i7  .  .      8.08 
i7  .  .      8.05 
i7  .  .      8.01 
i7  .  .      7.11 
i7  .  .      7.07 
i7  .  .      7.11 
i7  .  .      8.01 
i7  .  .      8.05 
i7  .  .      8.08 
i7  .  .      8.11 
i7  .  .      8.08 
i7  .  .      8.05 
i7  .  .      8.01 

e
