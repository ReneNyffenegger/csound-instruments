;---------------------------------------------------------------------------
; PLUCK WITH HEAVY DISTORTION & RESONANT LOW-PASS FILTER
;---------------------------------------------------------------------------
i 3002  0.0  1.6  16000  7.00   0     1    1
i 3002  0.2  1.4  12000  7.05   .     .    .
i 3002  0.4  1.2  10400  8.00   .     .    .
i 3002  0.6  1.0  12000  8.05   .     .    .
i 3002  0.8  0.8  16000  7.00   .     .    .
i 3002  1.0  0.6  12000  7.05   .     .    .
i 3002  1.2  0.4  10400  8.00   .     .    .
i 3002  1.4  0.2  12000  8.05   .     .    .

; TUBE DISTORTION
f 5 0 8192 7 -.8 934 -.79 934 -.77 934 -.64 1034 -.48 520 .47 2300 .48 1536 .48

; TUBE AMP
;   STA  DUR  PREGAIN  POSTGAIN  DUTYOFFSET  SLOPESHIFT  INCH  OUTCH
i 3013 0    1.6  .5       1         1           1           1     2

; RESONANT LOW-PASS FILTER
; f3=Fco, f4=Rez
f 20 0 8192 -7 50 1024 300 1024 50 2048 300 4096 40
f 21 0 8192 -7 12 1024 10  1024 12  2048 10  4096 18

;   STA  DUR  TABLE1  TABLE2  LPMIX  RZMIX  INCH  OUTCH
i 3015 0    1.6  20      21      1      1.5    2     3

; MIXER
;    STA DUR  CH1  GAIN  PAN  CH2  GAIN  PAN  CH3  GAIN  PAN  CH4  GAIN  PAN
i 3099 0   2    3    1     1    3    1     0    3    0     1    4    0    0
