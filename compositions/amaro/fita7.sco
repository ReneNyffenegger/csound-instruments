;a difícil"dangerosíssima..."
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

;"a dificílima dangerosíssima.."
;P1;fita4.sco
i3  0  7      0      5.02   2.0    0.2  ;D
i3  0  7      0      6.02   2.0    0.2  ;D
i3  .5 7      0      8.08   2.0    0.2  ;Ab
i3  .5 24.5   0      9.08   2.0    0.2  ;Ab-nota do acorde de fita3.sco
i3  1  7      0      8.03   2.0    0.2  ;Eb
i3  1.5       7      0      9.04   2.0    0.2 ;E 

i3  5  7      0      5.07   2.0    0.2  ;G
i3  5  18     0      6.07   2.0    0.2  ;G-nota do acorde da fita3.sco
i3  5.5       7      0      8.10   2.0    0.2 ;Bb
i3  6  7      0      8.06   2.0    0.2  ;F#
i3  6.5       23.5   0      8.05   2.0    0.2 ;F-nota do acorde da fita3.sco e fita2
i3  6.5       7      0      9.05   2.0    0.2 ;F

i3  10 7      0      5.01   2.0    0.2  ;C#
i3  10 7      0      6.01   2.0    0.2  ;C#
i3  10.5      6.5    0      7.09   2.0    0.2 ;A
i3  11 6      0      8.00   2.0    0.2  ;C
i3  11.5      5.5    0      9.11   2.0    0.2 ;Cb
i3  11.5      5.5    0      8.11   2.0    0.2 ;Cb

;fita3.sco (G+Db7)
i3  15 7      0      5.07   2.0    0.2  ;G
i3  15 14     0      7.11   2.0    0.2  ;B-nota do acorde da fita2.sco
i3  15 8      0      9.01   2.0    0.2  ;Db

;se transforma no acorde da fita2.sco (G7e13-)
i3  21 7      0      7.07   2.0    0.2  ;G
i3  21 9      0      8.11   2.0    0.2  ;B
i3  21 9      0      9.02   2.0    0.2  ;D
i3  22 6      0      9.07   2.0    0.2  ;G
i3  22 5      0      6.02   2.0    0.2  ;D
i3  22 5      0      7.02   2.0    0.2  ;D

;o acorde se desmancha em C#m
i3  25 21     0      6.01   2.0    0.2  ;C#
i3  25 21     0      7.01   2.0    0.2  ;C#
i3  26 20     0      7.08   2.0    0.2  ;G#
i3  26 20     0      9.08   2.0    0.2  ;G#
i3  27 19     0      8.01   2.0    0.2  ;C#
i3  27 19     0      9.01   2.0    0.2  ;C#
i3  28 8      0      8.04   2.0    0.2  ;E 


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
f91 0 256   05    .001  3     100   27    30    174   30    26    70    26    100 ;novo envelope de i92
f92 0 512   10    10    8     0     6     0     4     0     1   
f93 0 512   10    10    0     5     5     0     4     3     0     1   
f94 0 512   10    10    0     9     0     0     8     0     7     0     4     0     2     0     1     0   

;============================== Parameters ===============================;

;i5:  p4=cps of pan
;i9:  p4=del attn,p5=frq,p6=amp,p7=rvb attn,p8=rndamp,p9=rndfrq,p10=1 for space
;i11: p2=strt,p3=dur
;i13: p6=amp,p7=swp strt,p8=swp peak,p9=bndwth,p10=rvb attn
;========================= ======================= =======================;

;"a dificílima dangerosíssima.."
i5  0  12     .1  
i11 0  18

;P1
i9  3  3      .6     12.03  800    .7     2      276  
;i13
i5  12 5      .8   
i5  17 1      .1   
i13 12 3      0      5.01   800    100.0  7000   16     .16 

i5  19 2      9.8  
i13 19 1.5    0      5.01   800    100.0  7000   16     .16 
i13 19.03     1.5    0      5.07   800    100.0  7000   16     .16 

; i9

i5  22 8      .1   
i11 22 8

i9  22 4      .2     5.022  3000   .3     4.1    200
i9  22 4      .5     11.072 1000   .7     2      276  
i9  22 4      .6     12.012 1000   .7     2      276  

i9  25 4      .2     5.012  3000   .3     4.1    200
i9  25 4      .5     11.072 1000   .7     2      276  
i9  25 4      .6     12.022 1000   .7     2      276  

;"de si a si mesmo."
i5  34 10     .0618
i11 34 10

i9  34 3      .8     8.04   2000   .3     33     27  
i9  34.1      2.9    .8     8.042  2000   .3     33     27  
i9  34.3      2.7    .8     8.044  2000   .3     33     27  

i9  36 3      .8     8.05   2000   .3     33     27  
i9  36.1      2.9    .8     8.048  2000   .3     33     27  
i9  36.3      2.7    .8     8.046  2000   .3     33     27  

i9  38 3      .8     8.04   1500   .3     33     27  
i9  38.1      3      .8     8.042  1500   .3     33     27  
i9  38.3      3      .8     8.044  1500   .3     33     27  
i9  38.6      3      .8     8.046  1500   .3     33     27  
i9  38.9      3      .8     8.048  1500   .3     33     27  
i9  39.2      3      .8     8.05   1500   .3     33     27  

;AGOGÔ
;   ============    Score for Risset's "Bell" Instrument     ==========   ;

f1  0 2048  10    1                     ; fundamental
f5  0 513   5     1024  512   1         ; Amplitude envelope with extended guard point

;       start   dur     freq    amp

;"a dificílima dangerosíssima.."
;P1
i6  3.5       8      8.04   1000
i6  4  8      7.07   1000
i6  4.5       8      5.10   1000

i6  12 8      7.02   1000
i6  13 8      7.07   1000
i6  14 8      7.01   1000

i6  19 4      11.02  1000
i6  19.5      4      11.02  1000
i6  20 4      11.02  1000
i6  20.5      4      11.02  1000



;    =============  Score for Risset's "Drum" Instrument  =============   ;

f 2 0 512   5     4096  512   1 
f 3 0 512   9     10    1     0     16    1.5   0     22    2     0     23    1.5   0 
f 4 0 512   5     256   512   1 

;"a dificílima dangerosíssima.."
;P1
i7  2  .2     9.02   6000
i7  2.5       .      7.08 

i7  19 .1     8.11   6000
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

e
