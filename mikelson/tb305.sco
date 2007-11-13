; Instrument in the style of the TB303 with built in sequencer.

f10 0  1024   8  1  256 .2  128 0 256 -.2 256  -1

; Distortion Table
;----------------------------------------------------------------------
f7 0 1024   8 -.8 42 -.78  200 -.74 200 -.7 140 .7  200 .74 200 .78 42 .8

; 16 Step Sequencer
;----------------------------------------------------------------------
; Step          1     2     3     4     5     6     7     8     9     10    11    12    13    14    15    16
; Pitch Table
f20  0  16  -2  7.00  7.00  7.00  7.00  7.05  7.00  7.00  7.00  7.05  6.00  7.07  7.00  7.05  7.00  7.00  7.00
f20  4   8  -2  7.00  6.00  7.00  6.00  6.05  6.00  6.05  6.00  6.10  6.07  6.05  6.03  6.02  6.00  7.00  7.00

; Dur Table
f21  0 16  -2   .5    .5    .5    1     .5    1     1     .5    1     1     .5    .5    .5    .5    1     .5
f21  4 16  -2   .5    .5    .5    .5    .5    .5    1     .5    .5    .5    .5    .5    .5    1.5   1     2

; Panning Amplitude Table  22=Left 23=Right
f22  0 16  -2   1     0     1     1     0     0     1     1    1     0     1     1     1     0     1     1
f23  0 16  -2   0     1     1     0     0     1     1     0    0     1     1     0     1     1     1     0

; Slide Table
f24  0  8  -2   0     0     0     1     0     0     0     1    0     0     0     0     1     0     0     0

; Frequency Sweep Table used to simulate "real time" twisting of the knob.
f30  0  256  -7  50 128 2000 128 50
f30  1  256  -7  100 64 500 64 50 64 200 64 1000

; Resonance Sweep Table used to simulate "real time" twisting of the knob.
f31  0  256  -7  40 128 80 128 40

; Score
;----------------------------------------------------------------------
; Enveloped Distortion Filter
;        Dur  Amp   Wave  Accent  EnvDepth  FreqDecay  AmpDecay
i15  0   4    6000  10    0       1         .1         .5
i15  +   4    6000  10    0       .99       .2         .2
