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

i3  0  10     0      5.01   2.0    0.2  ;C#
i3  0  10     0      6.01   2.0    0.2  ;C#
i3  1  10     0      8.07   2.0    0.2  ;G
i3  2  10     0      8.02   2.0    0.2  ;D
i3  3  10     0      9.03   2.0    0.2  ;Eb

i3  8  10     0      5.06   2.0    0.2  ;F#
i3  8  10     0      6.06   2.0    0.2  ;F#
i3  9  10     0      8.09   2.0    0.2  ;A
i3  10 10     0      8.05   2.0    0.2  ;F
i3  11 10     0      9.04   2.0    0.2  ;E

i3  16 8      0      5.00   2.0    0.2  ;C
i3  16 8      0      6.00   2.0    0.2  ;C
i3  17 7      0      8.08   2.0    0.2  ;G#
i3  18 6      0      7.11   2.0    0.2  ;B
i3  19 5      0      8.10   2.0    0.2  ;Bb



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

; i13

i5  0  6      .8   
i13 0  4      0      5.01   1000   100.0  7000   16     .16 

i5  16 6      .8   
i13 16 4      0      5.06   1000   100.0  7000   16     .16 


;AGOGÔ
;   ============    Score for Risset's "Bell" Instrument     ==========   ;

f1  0 2048  10    1                     ; fundamental
f5  0 513   5     1024  512   1         ; Amplitude envelope with extended guard point

;       start   dur     freq    amp

t       0       52    
i6  0  7      7.01   1500
i6  1  6      7.07   1500
i6  2  5      7.02   1500
i6  3  4      7.03   1500

i6  16 7      8.00   1500
i6  17 6      7.08   1500
i6  18 5      7.11   1500
i6  19 4      7.10   1500

e
