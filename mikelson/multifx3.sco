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

; Triangle Wave -1 to 1
f2 0 8192 7  -1  4096 1 4096 -1

; Triangle Wave 0 to 1
f4 0 8192 7 0 4096 1 4096 0

; Tube Distortion
f5 0 8192 7 -.8 934 -.79 934 -.77 934 -.64 1034 -.48 520 .47 2300 .48 1536 .48

;---------------------------------------------------------------------------
; Plain Pluck
;---------------------------------------------------------------------------
;   Sta  Dur  Amp   Fqc   Func  Meth  OutCh
i2  0.0  1.6  16000  7.00   0     1    1
i2  0.2  1.4  12000  7.05   .     .    .
i2  0.4  1.2  10400  8.00   .     .    .
i2  0.6  1.0  12000  8.05   .     .    .
i2  0.8  0.8  16000  7.00   .     .    .
i2  1.0  0.6  12000  7.05   .     .    .
i2  1.2  0.4  10400  8.00   .     .    .
i2  1.4  0.2  12000  8.05   .     .    .

; Mixer
;     Sta  Dur  Ch1  Gain  Pan  Ch2  Gain  Pan
i100  0    2    1    2     .5   0    0     0

; Clear Channels
;     Sta  Dur
i110  0    2

;---------------------------------------------------------------------------
; Pluck with Heavy Distortion & Wah-Wah
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
f5 0 8192 7 -.8 934 -.79 934 -.77 934 -.64 1034 -.48 520 .47 2300 .48 1536 .48

; Tube Amp
;   Sta  Dur  PreGain  PostGain  DutyOffset  SlopeShift  InCh  OutCh
i13 2    1.6  .5       1         1           1           1     2

; Wah-Wah
;   Sta  Dur  Rate  Depth  MinFqc  VocalMix  Table  InCh  OutCh
i16 2    1.6  2.5   10000  250     1         1      2     3

; Mixer
;     Sta  Dur  Ch1  Gain  Pan  Ch2  Gain  Pan
i100  2    2    3    2     .5   0    0     0

; Clear Channels
;     Sta  Dur
i110  2    2

;---------------------------------------------------------------------------
; Pluck with Equalizer
;---------------------------------------------------------------------------
i2  4.0  1.6  16000  7.00   0     1    1
i2  4.2  1.4  12000  7.05   .     .    .
i2  4.4  1.2  10400  8.00   .     .    .
i2  4.6  1.0  12000  8.05   .     .    .
i2  4.8  0.8  16000  7.00   .     .    .
i2  5.0  0.6  12000  7.05   .     .    .
i2  5.2  0.4  10400  8.00   .     .    .
i2  5.4  0.2  12000  8.05   .     .    .

; 3 Band Equalizer
;    Sta  Dur  LoGain  MidGain  HiGain  LoFco  HiFco  InCh  OutCh
i18  4    1.6  .5      -.3      .2      500    5000   1     2

; Mixer
;     Sta  Dur  Ch1  Gain  Pan  Ch2  Gain  Pan
i100  4    2    2    2     .5   0    0     0

; Clear Channels
;     Sta  Dur
i110  4    2

;---------------------------------------------------------------------------
; Pluck with Heavy Distortion & Resonant Low-Pass Filter
;---------------------------------------------------------------------------
i2  6.0  1.6  16000  7.00   0     1    1
i2  6.2  1.4  12000  7.05   .     .    .
i2  6.4  1.2  10400  8.00   .     .    .
i2  6.6  1.0  12000  8.05   .     .    .
i2  6.8  0.8  16000  7.00   .     .    .
i2  7.0  0.6  12000  7.05   .     .    .
i2  7.2  0.4  10400  8.00   .     .    .
i2  7.4  0.2  12000  8.05   .     .    .

; Tube Amp
;   Sta  Dur  PreGain  PostGain  DutyOffset  SlopeShift  InCh  OutCh
i13 6    1.6  .5       1         1           1           1     2

; Resonant Low-Pass Filter
f20 6 8192 -7 50 1024 200 1024 50 2048 100 4096 10      ; Fco
f21 6 8192 -7 32 1024 40  1024 22  2048 60  4096 18     ; Rez
;   Sta  Dur  Table1  Table2  LPMix  RzMix  InCh  OutCh
i15 6    1.6  20      21      1      1.5    2     3

; Mixer
;     Sta  Dur  Ch1  Gain  Pan  Ch2  Gain  Pan
i100  6    2    3    2     .5   0    0     0

; Clear Channels
;     Sta  Dur
i110  6    2

;---------------------------------------------------------------------------
; Pluck with Resonator
;---------------------------------------------------------------------------
i2  8.0  1.6  16000  7.00   0     1    1
i2  8.2  1.4  12000  7.05   .     .    .
i2  8.4  1.2  10400  8.00   .     .    .
i2  8.6  1.0  16000  7.10   .     .    .
i2  8.8  0.8  16000  7.00   .     .    .
i2  9.0  0.6  12000  7.05   .     .    .
i2  9.2  0.4  10400  8.00   .     .    .
i2  9.4  0.2  16000  7.10   .     .    .

; Resonator
f7 8 4 -2 100 200 400  1400   ; Acoustic Guitar Body Resonances
f8 8 4 -2 59  64  62   59     ; Amplitudes in dB.

;   Sta  Dur  ResTab  dBTab  InCh  OutCh
i19 8    2    7       8      1     2

; Mixer
;     Sta  Dur  Ch1  Gain  Pan  Ch2  Gain  Pan
i100  8    2    2    3     .5   1    2     .5

; Clear Channels
;     Sta  Dur
i110  8    2

;---------------------------------------------------------------------------
; Talk-Box
;---------------------------------------------------------------------------
i2  10.0  2  16000  6.10   0     1    1
i2  10.0  2  12000  7.07   .     .    .
i2  10.0  2  13000  8.00   .     .    .
i2  10.0  2  10400  8.05   .     .    .

i2  12.0  2  16000  6.10   0     1    1
i2  12.0  2  12000  7.07   .     .    .
i2  12.0  2  13000  8.00   .     .    .
i2  12.0  2  10400  8.05   .     .    .

i2  14.0  2  16000  6.10   0     1    1
i2  14.0  2  12000  7.07   .     .    .
i2  14.0  2  13000  8.00   .     .    .
i2  14.0  2  10400  8.05   .     .    .

; Tube Distortion
f5 10 8192 7 -.8 934 -.79 934 -.77 934 -.64 1034 -.48 520 .47 2300 .48 1536 .48

; Distortion
;   Sta  Dur  PreGain  PostGain  DutyOffset  SlopeShift  InCh  OutCh
i13 10    6    .5       1         1           1           1     2

; Talk-Box

;Formants 0="ee", 1="aah", 2="oo", 3="aw", 4="ae"
;Male
f11 10 16 -2  270 2290 3010 730 1090 2440 300 870 2240 570 840 2410 660 1720 2410 0
;Female
f11 12 16 -2  310 2790 3310 850 1220 2810 370 950 2670 590 920 2710 760 2050 2850 0
;Child
f11 14 16 -2  370 3200 3730 1030 1370 3170 430 1170 3260 680 1060 3180 1010 2320 3320 0
;Amplitudes
f12 10 16 -2  -4 -24 -28 -1 -5 -28 -3 -19 -43 0 -7 -34 -1 -12 -22 0

;0="ee", 1="aah", 2="oo", 3="aw", 4="ae"
f10 10 8 -2 1 0 0 2 1 1 2 2

;   Sta  Dur  I-Table  F-Table  A-Table  InCh  OutCh
i17 10    2    10       11       12       2     3
i17 12    2    10       11       12       2     3
i17 14    2    10       11       12       2     3

; Mixer
;     Sta  Dur  Ch1  Gain  Pan  Ch2  Gain  Pan
i100  10   6    3    2     .5   0    0     0

; Clear Channels
;     Sta  Dur
i110  10   6
