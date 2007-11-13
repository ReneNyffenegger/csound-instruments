;---------------------------------------------------------------------------
; WAVEFORMS
;---------------------------------------------------------------------------
; SINE WAVE
f 1 0 8192 10 1
; TRIANGLE WAVE
f 2 0 8192 7  -1  4096 1 4096 -1
; SQUARE WAVE
f 3 0 8192 7  1  4096 1 0 -1 4096 -1
; TRIANGLE WAVE
f 4 0 8192 7 0 4096 1 4096 0
; TUBE DISTORTION
f 5 0 8192 7 -.8 934 -.79 934 -.77 934 -.64 1034 -.48 520 .47 2300 .48 1536 .48
;---------------------------------------------------------------------------
; REVERB
;---------------------------------------------------------------------------
i 3002  0.0  .2   16000  7.00   0     1   1
i 3002  0.0  .2   16000  7.07   0     1   1
i 3002  0.6  .2   16000  7.00   0     1   1
i 3002  0.6  .2   16000  7.05   0     1   1
i 3002  1.2  .6   16000  6.10   0     1   1
i 3002  1.2  .6   16000  7.07   0     1   1
; DISTORTION
;   STA  DUR  PREGAIN POSTGAIN  DUTYOFFSET  SLOPESHIFT  INCH  OUTCH
i 3013 0   2    1       1         1           1           1     2
; STEREO DELAY
;     STA  DUR  DELAY1  FEEDBK1  XFEEDBK1  DELAY2  FEEDBK2  XFEEDBK2  INCH1  INCH2  OUTCH1  OUTCH2
i 3040 0   3    .15     .3       .2        .25     .4       .2        2      2      3       4
; REVERB
;     STA  DUR  REVTIME  HIFDIFF  INCH  OUTCH
i 3045 0   4    3        .3       2     5
i 3045 0   4    2.8      .6       2     6
; SUBMIX
;    STA  DUR  INCH1  GAIN1  INCH2  GAIN2  OUTCH
i 3050 0   4    2      .5     3      .2     7
i 3050 0   4    2      .5     4      .2     8
; MIXER
;     STA DUR  CH1  GAIN  PAN  CH2  GAIN  PAN  CH3  GAIN  PAN  CH4  GAIN  PAN
i 3099 0  4    7    1     1    8    1     0    5    .8    1    6    .8    0
