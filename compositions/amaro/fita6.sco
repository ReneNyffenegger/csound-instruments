;só resta ao homem
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


;"só resta ao homem"

t       0       240     11      240     11      120  
;crescendo
i34 11 24     0      6.01   2.0    0.2  ;C#
i34 12 23     0      7.02   2.0    0.2  ;D
i34 13 22     0      7.07   2.0    0.2  ;G

i34 17 18     0      8.02   2.0    0.2  ;D
i34 18 17     0      8.03   2.0    0.2  ;Eb
i34 18.2      16.8   0      8.04   2.0    0.2 ;E
i34 18.4      16.6   0      8.05   2.0    0.2 ;F
i34 18.6      16.4   0      8.06   2.0    0.2 ;Gb
i34 18.8      16.2   0      8.07   2.0    0.2 ;G
i34 19 16     0      8.08   2.0    0.2  ;Ab

i34 23 12     0      9.03   2.0    0.2  ;D#
i34 24 11     0      9.04   2.0    0.2  ;E
i34 24.2      10.8   0      9.05   2.0    0.2 ;F
i34 24.4      10.6   0      9.06   2.0    0.2 ;Gb
i34 24.6      10.4   0      9.07   2.0    0.2 ;G
i34 24.8      10.2   0      9.08   2.0    0.2 ;Ab 
i34 25 10     0      9.09   2.0    0.2  ;A

i34 29 6      0      10.04  2.0    0.2  ;E
i34 30 5      0      10.05  2.0    0.2  ;F
i34 30.2      4.8    0      10.06  2.0    0.2 ;Gb
i34 30.4      4.6    0      10.07  2.0    0.2 ;G
i34 30.6      4.4    0      10.08  2.0    0.2 ;Ab
i34 30.8      4.2    0      10.09  2.0    0.2 ;A
i34 31 4      0      10.10  2.0    0.2  ;Bb

;acorde final
i33 35 4      0      10.10  2.0    0.2  ;Bb
i33 35 .      0      10.09  2.0    0.2  ;A
i33 35 .      0      10.08  2.0    0.2  ;Ab
i33 35 .      0      10.07  2.0    0.2  ;G
i33 35 .      0      10.06  2.0    0.2  ;Gb
i33 35 .      0      10.05  2.0    0.2  ;F
i33 35 .      0      10.04  2.0    0.2  ;E

i33 35 .      0      9.09   2.0    0.2  ;A
i33 35 .      0      9.08   2.0    0.2  ;Ab
i33 35 .      0      9.07   2.0    0.2  ;G
i33 35 .      0      9.06   2.0    0.2  ;Gb
i33 35 .      0      9.05   2.0    0.2  ;F
i33 35 .      0      9.04   2.0    0.2  ;E
i33 35 .      0      9.03   2.0    0.2  ;D#

i33 35 .      0      8.08   2.0    0.2  ;B-Ab
i33 35 .      0      8.07   2.0    0.2  ;G
i33 35 .      0      8.06   2.0    0.2  ;Gb
i33 35 .      0      8.05   2.0    0.2  ;F
i33 35 .      0      8.04   2.0    0.2  ;E
i33 35 .      0      8.03   2.0    0.2  ;Eb
i33 35 .      0      8.02   2.0    0.2  ;D

i33 35 .      0      7.07   2.0    0.2  ;B-G
i33 35 .      0      7.02   2.0    0.2  ;B-D
i33 35 .      0      6.01   2.0    0.2  ;B-C#


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

i5  1  13     .1  
i11 1  13

i9  1  2      .2     5.07   1000   .3     4.1    200
i9  6  3      .2     5.07   1000   .3     4.1    200

i9  11 1      .2     6.01   350    .3     4.1    200

;AGOGÔ
;   ============    Score for Risset's "Bell" Instrument     ==========   ;

f1  0 2048  10    1                     ; fundamental
f5  0 513   5     1024  512   1         ; Amplitude envelope with extended guard point

;       start   dur     freq    amp


i6  11 4      6.01   250                ;C#
i6  12 7      7.02   300                ;D
i6  13 7      7.07   350                ;G

i6  17 7      8.02   300                ;D
i6  18 7      8.03   350                ;Eb
i6  19 7      8.08   400                ;Ab

i6  23 7      9.03   350                ;D#
i6  24 7      9.04   400                ;E
i6  25 7      9.09   450                ;A

i6  29 7      10.04  700                ;E
i6  30 7      10.05  750                ;F
i6  31 7      10.10  800                ;Bb

e
