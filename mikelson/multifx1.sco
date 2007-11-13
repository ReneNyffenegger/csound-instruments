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
i100  0    2   1    2     .5   3    0     0

; Clear Channels
;     Sta  Dur
i110  0    2

;---------------------------------------------------------------------------
; Compression
;---------------------------------------------------------------------------
i2  2.0  1.6  16000  7.00   0     1    1
i2  2.2  1.4  12000  7.05   .     .    .
i2  2.4  1.2  10400  8.00   .     .    .
i2  2.6  1.0  12000  8.05   .     .    .
i2  2.8  0.8  16000  7.00   .     .    .
i2  3.0  0.6  12000  7.05   .     .    .
i2  3.2  0.4  10400  8.00   .     .    .
i2  3.4  0.2  12000  8.05   .     .    .

; Compression Curve
f6 2 1025 7 1 128 1 128 .4 256 .2 256 .1 257 .01

; Compressor/Limiter
;    Sta  Dur  RMSTime  DelTime  Table  PostGain  InCh  OutCh
i11  2    1.6  .02      .01       6     1.5       1     2

; Mixer
;     Sta  Dur  Ch1  Gain  Pan  Ch2  Gain  Pan
i100  2    2    1    2     .5   0    0     0

; Clear Channels
;     Sta  Dur
i110  2    2

;---------------------------------------------------------------------------
; Noise Gate
;---------------------------------------------------------------------------
i2  4.0  .8  8000  7.00   0     1    1
i2  4.8  .8  8000  7.00   0     1    2

; Noise Gate Curve
f6 4 1025 7 0 64 0 64 1 897 1

; Noise Gate
;    Sta  Dur  RMSTime  DelTime  Table  PostGain  InCh  OutCh
i10  4    1.6  .02      .01      6      1         2     3

; Mixer
;     Sta  Dur  Ch1  Gain  Pan  Ch2  Gain  Pan
i100  4    2    1    2     .5   3    2     .5

; Clear Channels
;     Sta  Dur
i110  4    2

;---------------------------------------------------------------------------
; De-Esser
;---------------------------------------------------------------------------
i2  6.0  1.6  16000  7.00   0     1    1
i2  6.2  1.4  12000  7.05   .     .    .
i2  6.4  1.2  10400  8.00   .     .    .
i2  6.6  1.0  12000  8.05   .     .    .
i2  6.8  0.8  16000  7.00   .     .    .
i2  7.0  0.6  12000  7.05   .     .    .
i2  7.2  0.4  10400  8.00   .     .    .
i2  7.4  0.2  12000  8.05   .     .    .

; De-Esser Curve
f6 6 1025 7 1 128 .5 128 .3 256 .2 256 .1 257 .01

; De-Esser
;    Sta  Dur  RMSTime  DelTime  Table  Frequency  PostGain  InCh  OutCh
i12  6    1.6  .02      .01      6      5000       1         1     2

; Mixer
;     Sta  Dur  Ch1  Gain  Pan  Ch2  Gain  Pan
i100  6    2    2    2     .5   0    0     0

; Clear Channels
;     Sta  Dur
i110  6    2

