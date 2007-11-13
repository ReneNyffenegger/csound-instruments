;===========================================================================
; A Multi-Effects System
;===========================================================================
;  1. Simple Sine Wave
;  2. Pluck
;  4. Noise
;  5. Monosampler
;  6. Soundin
;  7. LFO
;  8. Distortion 2
;  9. Enhancer
; 10. Noise Gate
; 11. Compressor/Limiter/Expander
; 12. De-esser
; 13. Tube Amp Distortion
; 14. Feedback Generator
; 15. Low Pass Resonant Filter
; 16. Wah-Wah
; 17. Talk-Box
; 18. 3 Band Equalizer
; 19. Resonator
; 20. Vibrato
; 21. Tremelo
; 22. Pitch Shifter
; 23. Panner
; 24. Ring Modulator
; 30. Flanger
; 35. Chorus
; 37. Phasor
; 40. Stereo Delay
; 45. Reverb
; 46. Lyon's Reverb 1
;100. Mixer
;110. Clear channels

;---------------------------------------------------------------------------
; Waveforms
;---------------------------------------------------------------------------
; Sine Wave
f1 0 8192 10 1
; Triangle Wave
f2 0 8192 7  -1  4096 1 4096 -1
; Triangle Wave
f4 0 8192 7 0 4096 1 4096 0
; Tube Distortion
f5 0 8192 7 -.8 934 -.79 934 -.77 934 -.64 1034 -.48 520 .47 2300 .48 1536 .48

;---------------------------------------------------------------------------
; Heavy Distortion
;---------------------------------------------------------------------------
i2  0.0  1.6  16000  7.00   0     1   1
i2  0.2  1.4  12000  7.05   .     .   .
i2  0.4  1.2  10400  8.00   .     .   .
i2  0.6  1.0  12000  8.05   .     .   .
i2  0.8  0.8  16000  7.00   .     .   .
i2  1.0  0.6  12000  7.05   .     .   .
i2  1.2  0.4  10400  8.00   .     .   .
i2  1.4  0.2  12000  8.05   .     .   .

; Tube Distortion
f5 0 8192 7 -.8 934 -.79 934 -.77 934 -.64 1034 -.48 520 .47 2300 .48 1536 .48

; Tube Amp
;   Sta  Dur  PreGain PostGain  DutyOffset  SlopeShift  InCh  OutCh
i13 0    1.6  1       1         1           1           1     2

; Mixer
;     Sta  Dur  Ch1  Gain  Pan  Ch2  Gain  Pan
i100  0    2    2    2     .5   0    0     0

; Clear Channels
;     Sta  Dur
i110  0    2

;---------------------------------------------------------------------------
; Heavy Distortion with Chorus
;---------------------------------------------------------------------------
i2  2.0  1.6  16000  7.00   0     1    1
i2  2.2  1.4  12000  7.05   .     .    .
i2  2.4  1.2  10400  8.00   .     .    .
i2  2.6  1.0  12000  8.05   .     .    .
i2  2.8  0.8  16000  7.00   .     .    .
i2  3.0  0.6  12000  7.05   .     .    .
i2  3.2  0.4  10400  8.00   .     .    .
i2  3.4  0.2  12000  8.05   .     .    .

; Tube Distortion
f5 2 8192 7 -.8 934 -.79 934 -.77 934 -.64 1034 -.48 520 .47 2300 .48 1536 .48

; Tube Amp
;   Sta  Dur  PreGain PostGain  DutyOffset  SlopeShift  InCh  OutCh
i13 2    1.6  1       1         1           1           1     2

; Chorus
;   Sta  Dur  Rate   Depth   Wave  Mix  Delay  Phase  InCh  OutCh
;                   (.1-4)
i35 2    1.6  .5     2       1     .5   25     0      2     3
i35 2    1.6  .5     2       1     .5   20     .25    2     4

; Mixer
;     Sta  Dur  Ch1  Gain  Pan  Ch2  Gain  Pan
i100  2    2    3    1     1    4    1     0

; Clear Channels
;     Sta  Dur
i110  2    2

;---------------------------------------------------------------------------
; Heavy Distortion with Flanger
;---------------------------------------------------------------------------
i2  4.0  1.6  16000  7.00   0     1    1
i2  4.2  1.4  12000  7.05   .     .    .
i2  4.4  1.2  10400  8.00   .     .    .
i2  4.6  1.0  12000  8.05   .     .    .
i2  4.8  0.8  16000  7.00   .     .    .
i2  5.0  0.6  12000  7.05   .     .    .
i2  5.2  0.4  10400  8.00   .     .    .
i2  5.4  0.2  12000  8.05   .     .    .

; Tube Distortion
f5 4 8192 7 -.8 934 -.79 934 -.77 934 -.64 1034 -.48 520 .47 2300 .48 1536 .48

; Distortion
;   Sta  Dur  PreGain PostGain  DutyOffset  SlopeShift  InCh  OutCh
i13 4    1.6  1       1         1           1           1     2

; Flanger
;   Sta  Dur  Rate   Depth   Wave  Feedbk  Mix  Delay  Phase  InCh  OutCh
;                   (.1-4)
i30 4    1.6  .5     1       1     .8      .5    1      0      2     3
i30 4    1.6  .5     1       1     .8      .5   1      .25    2     4

; Mixer
;     Sta  Dur  Ch1  Gain  Pan  Ch2  Gain  Pan
i100  4    2    3    1     1    4    1     0

; Clear Channels
;     Sta  Dur
i110  4    2

;---------------------------------------------------------------------------
; Pluck with Phasor
;---------------------------------------------------------------------------
i2  6.0  1.6  16000  7.00   0     1    1
i2  6.2  1.4  12000  7.05   .     .    .
i2  6.4  1.2  10400  8.00   .     .    .
i2  6.6  1.0  12000  8.05   .     .    .
i2  6.8  0.8  16000  7.00   .     .    .
i2  7.0  0.6  12000  7.05   .     .    .
i2  7.2  0.4  10400  8.00   .     .    .
i2  7.4  0.2  12000  8.05   .     .    .

; Distortion
;   Sta  Dur  PreGain  PostGain  DutyOffset  SlopeShift  InCh  OutCh
i13 6    1.6  1        1         1           1           1     2

; Phasor
;   Sta  Dur  Rate   Depth   Wave  Feedbk  Mix  Delay  Phase  InCh  OutCh
i37 6    1.6  .5     1       1     .8      1    2      0      2     3
i37 6    1.6  .5     1       1     .8      1    2      .25    2     4

; Mixer
;     Sta  Dur  Ch1  Gain  Pan  Ch2  Gain  Pan
i100  6    2    3    1     1    4    1     0

; Clear Channels
;     Sta  Dur
i110  6    2


;---------------------------------------------------------------------------
; Light Distortion with Vibrato
;---------------------------------------------------------------------------
i2  8.0  1.6  16000  7.00   0     1    1
i2  8.01 1.6  16000  7.07   0     1    1
i2  8.02 1.6  16000  8.07   0     1    1

; Slight Distortion
f5 8 8192   8 -.8 336 -.78  800 -.7 5920 .7  800 .78 336 .8

; Tube Amp
;   Sta  Dur  PreGain PostGain  DutyOffset  SlopeShift  InCh  OutCh
i13 8    1.7  1       1         .1          .1          1     2

; Vibrato
;   Sta  Dur  Amp  Fqc  Table  Phase  Delay  RampTime  InCh  OutCh
i20 8    1.7  1    5    1      0      .5     .5        2     3

; Mixer
;     Sta  Dur  Ch1  Gain  Pan  Ch2  Gain  Pan
i100  8    2    3    2     .5   0    0     0

; Clear Channels
;     Sta  Dur
i110  8    2

;---------------------------------------------------------------------------
; Pitch Shifter
;---------------------------------------------------------------------------
i2  10.0  .8  16000  7.00   0     1    1
i2  10.8  .4  16000  7.00   0     1    1
i2  11.2  .8  16000  7.00   0     1    1

; Saw Wave
f9 10 1024 7 1 1024 0

; Pitch Shifter NewFqc=Shift*Fqc
;   Sta  Dur  Shift  Table  InCh  OutCh
i22 10.0  .8   .995   9      1     2       ; Stereo Detune
i22 10.8  .4   1.5    9      1     2       ; Up a fifth
i22 11.2  .8   .5     9      1     2       ; Down an octave

; Mixer
;     Sta  Dur  Ch1  Gain  Pan  Ch2  Gain  Pan
i100  10   2.0  1    1     1    2    1     0

; Clear Channels
;     Sta  Dur
i110  10   2

;---------------------------------------------------------------------------
; Distortion Feedbacker
;---------------------------------------------------------------------------
i2  12.0  2.0  16000  7.00   0     1    1
i2  12.0  2.0  12000  7.05   .     .    .
i2  12.0  2.0  10400  8.00   .     .    .

i2  14.0  2.0  16000  7.10   .     .    .
i2  14.0  2.0  16000  7.00   .     .    .
i2  14.0  2.0  12000  7.05   .     .    .

; Tube Distortion
f5 12 8192 7 -.8 934 -.79 934 -.77 934 -.64 1034 -.48 520 .47 2300 .48 1536 .48
; Compression Curve
f6 12 1025 7 1 128 1 128 .8 256 .6 256 .1 257 .01

; Distortion
;   Sta  Dur  PreGain PostGain  DutyOffset  SlopeShift  InCh  OutCh
i13 12   4    1       1         1           1           1     2

; Distortion Feedback
;   Sta  Dur  PrAmp  PstAmp  Duty  D-Tab  Res  Delay  Fdbk  C-Tab  InCh  OutCh
i14 12   4    1      1       1     5      440  .02    1.4   6      1     3
i14 14   2    1      1       1     5      330  .02    1.3   6      1     3

; Mixer
;     Sta  Dur  Ch1  Gain  Pan  Ch2  Gain  Pan
i100  12   4    2    2     .5   3    2     .5

; Clear Channels
;     Sta  Dur
i110  12   4

