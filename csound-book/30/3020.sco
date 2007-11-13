;---------------------------------------------------------------------------
; WAVEFORMS
;---------------------------------------------------------------------------
; SINE WAVE
f 1 0 8192 10 1
;---------------------------------------------------------------------------
; LIGHT DISTORTION WITH VIBRATO
;---------------------------------------------------------------------------
i 3002  0.0  1.6  16000  7.00   0     1    1
i 3002  0.01 1.6  16000  7.07   0     1    1
i 3002  0.02 1.6  16000  8.07   0     1    1

; SLIGHT DISTORTION
f 5 0 8192   8 -.8 336 -.78  800 -.7 5920 .7  800 .78 336 .8

; TUBE AMP
;   STA  DUR  PREGAIN POSTGAIN  DUTYOFFSET  SLOPESHIFT  INCH  OUTCH
i 3013 0    1.7  1       1         .1          .1          1     2

; VIBRATO
;   STA  DUR  AMP  FQC  TABLE  PHASE  DELAY  RAMPTIME  INCH  OUTCH
i 3020 0    1.7  1    5    1      0      .5     .5        2     3

; MIXER
;    STA DUR  CH1  GAIN  PAN  CH2  GAIN  PAN  CH3  GAIN  PAN  CH4  GAIN  PAN
i 3099 0   2    3    1     1    3    1     0    6    0     1    7    0     0

