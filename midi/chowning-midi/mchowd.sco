; Chowning.s

; SINE WAVE
f1  0 1024  9     1     1     0   

; ADSR TRUMPET ENVELOPE  - FIG 1.11
f2  0 513   7     0     85.33 1     85.33 .75   85.33 .65   170.66      .50   85.33 0

; AR WOODWIND ENVELOPE FOR CARRIER - FIG 1.12
f3  0 513   7     0     100   1     392   .9    20    0  

; GATED WOODWIND ENVELOPE FOR MODULATOR - FIG 1.13
f4  0 513   7     0     100   1     412   1 

; EXPONENTIAL DECAYING ENVELOPE FOR BELL-LIKE TIMBRES.
f5  0 513   5     1     512   .001

; MODIFICATION OF EXPONENTIAL ENVELOPE FOR DRUMLIKE SOUNDS
f6  0 513   5     .7    16    .8    48    1     64    .8    128   .2    256   .001

; MODULATOR ENVELOPE FOR WOOD-DRUM SOUNDS
f7  0 513   7     0     12    1     52    0     460   0 

f8  0 8192  10    1  

f9  0 513   7     .5    128   0     256   1     128   .5


f0  30
e

