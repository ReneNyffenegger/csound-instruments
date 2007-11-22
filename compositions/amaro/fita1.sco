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

;Díade F# e C#
i3  0  15     0      5.06   2.0    0.2  ;F#
i3  0  15     0      6.06   2.0    0.2  ;F# 

i3  0  30     0      7.06   2.0    0.2  ;F#
i3  .  40     .      8.01   .      .    ;C# above
i3  .  30     .      8.06   .      .    ;F# octave above 1st one
i3  .  40     .      9.01   2.0    0.2  ;C#
i3  .  30     .      9.06   .      .    ;F#
i3  .  40     .      10.01  .      .    ;C#
i3  .  30     .      10.06  .      .    ;F#
i3  .  30     .      11.06  2.0    0.2  ;F#

i3  10 25     0      6.01   2.0    0.2  ;C#
i3  10 30     0      7.01   2.0    0.2  ;C#

i3  25 18     0      7.08   2.0    0.2  ;G#
i3  25 17     0      8.08   2.0    0.2  ;G#
i3  25 16     0      9.08   2.0    0.2  ;G#
i3  25 15.5   0      10.08  2.0    0.2  ;G#
i3  25 15     0      11.08  2.0    0.2  ;G#

i3  32 14,8   0      6.08   2.0    0.2  ;G#

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

i5  10 3      9.8  
i13 10 3      6.8    10.01  300    60.0   6000   30     .1  
i13 10.03     3      6.8    10.00  300    50.0   5000   35     .1  
i13 10.06     3      6.8    10.06  300    100.0  7000   16     .1  

i5  15 2      9.8  
i13 15 2      6.8    10.01  300    60.0   6000   30     .1  
i13 15.03     2      6.8    10.00  300    50.0   5000   35     .1  
i13 15.06     2      6.8    10.06  300    100.0  7000   16     .1  

i5  20 11.1   .1
i9  20 11.1   .6     12.025 1200   .8     6.4    311
i9  20.6      10.7   .5     12.081 1200   .8     7      276  
i9  20.9      2.9    .4     5.082  3000   .3     4.1    200
i9  23.3      3.5    .2     5.091  3200   .5     3.6    160
i9  26.0      5.1    .6     5.024  2670   .8     4      200  
i9  26.01     5.09   .59    5.0239 2700   .89    3.9    210

i5  31 14.8   .0618
i11 31 13
i9  31 3      .8     8.05   2000   .3     33     27  
i9  31.1      2.9    .8     8.048  2000   .3     33     27  
i9  31.3      2.7    .8     8.046  2000   .3     33     27  

i9  32 14.8   .4     5.082  2000   .3     4.1    200

i9  33 3      .8     8.04   2000   .3     33     27  
i9  33.1      2.9    .8     8.042  2000   .3     33     27  
i9  33.3      2.7    .8     8.044  2000   .3     33     27  

i9  35 3      .8     8.05   2000   .3     33     27  
i9  35.1      2.9    .8     8.048  2000   .3     33     27  
i9  35.3      2.7    .8     8.046  2000   .3     33     27  

i9  37 3      .8     8.04   2000   .3     33     27  
i9  37.1      2.9    .8     8.042  2000   .3     33     27  
i9  37.3      2.7    .8     8.044  2000   .3     33     27  

i9  39 3      .8     8.04   1500   .3     33     27  
i9  39.1      .      .8     8.042  1500   .3     33     27  
i9  39.3      .      .8     8.044  1500   .3     33     27  
i9  39.6      .      .8     8.046  1500   .3     33     27  
i9  39.9      .      .8     8.048  1500   .3     33     27  
i9  40.2      3      .8     8.05   1500   .3     33     27  

;AGOGÔ
;   ============    Score for Risset's "Bell" Instrument     ==========   ;

f1  0 2048  10    1                     ; fundamental
f5  0 513   5     1024  512   1         ; Amplitude envelope with extended guard point

;       start   dur     freq    amp

i6  10 4      10.01  1500
i6  10.5      4      10.01  1500
i6  11 4      10.01  1500
i6  11.5      4      10.01  1500
i6  12 4      10.01  1500
i6  12.5      4      10.01  1500

i6  15 4      10.01  1500
i6  15.5      4      10.01  1500
i6  16 4      10.01  1500
i6  16.5      4      10.01  1500


;    =============  Score for Risset's "Drum" Instrument  =============   ;

f 2 0 512   5     4096  512   1 
f 3 0 512   9     10    1     0     16    1.5   0     22    2     0     23    1.5   0 
f 4 0 512   5     256   512   1 

i7  10 .1     8.06   8000
i7  +  .      8.06 
i7  .  .      8.01 
i7  .  .      8.01 
i7  .  .      8.01 
i7  .  .      8.00 
i7  .  .      8.00 
i7  .  .      8.01 
i7  .  .      8.01 
i7  .  .      8.01 
i7  .  .      8.06 
i7  .  .      8.06 
i7  .  .      8.01 
i7  .  .      8.01 
i7  .  .      8.01 
i7  .  .      8.00 
i7  .  .      8.00 
i7  .  .      8.00 
i7  .  .      8.01 
i7  .  .      8.01 
i7  .  .      8.06 
i7  .  .      8.06 
i7  .  .      8.01 
i7  .  .      8.01 
i7  .  .      8.01 
i7  .  .      8.00 
i7  .  .      8.00 
i7  .  .      8.00 
i7  .  .      8.01 
i7  .  .      8.01 


i7  15 .1     8.06   8000
i7  +  .      8.06 
i7  .  .      8.01 
i7  .  .      8.01 
i7  .  .      8.01 
i7  .  .      8.00 
i7  .  .      8.00 
i7  .  .      8.01 
i7  .  .      8.01 
i7  .  .      8.01 
i7  .  .      8.06 
i7  .  .      8.06 
i7  .  .      8.01 
i7  .  .      8.01 
i7  .  .      8.01 
i7  .  .      8.00 
i7  .  .      8.00 
i7  .  .      8.00 
i7  .  .      8.01 
i7  .  .      8.01 

e
