; ---------------------------------------------------------
; Rezzy Synth
; coded:  Hans Mikelson 2/7/97
; ---------------------------------------------------------
; 1. Table Based Rezzy Synth
; 2. Table Based PWM Rezzy Synth
; 3. Table Based Rezzy Synth with distortion
; 4. Noise Based Rezzy Synth
; 5. Buzz  Based Rezzy Synth
; 6. FM Based Rezzy Synth
; 7. 4 Pole Rezzy
; 8. 6 Pole Formant Filter
; 9. Mandelbrot's Snowflake Waveform with 4 Pole Filter
;10. Flowsnake Waveform with 4 Pole Filter
;11. Saw Ramp Transform
;12. Oscillator Sync
;**********************************************************
; f1=Sine, f2=Square, f3=Sawtooth, f4=Triangle, f5=Sqare2 
;**********************************************************
f1  0 1024  10    1  
f2  0 256   7     -1    128   -1    0     1     128   1 
f3  0 256   7     1     256   -1
f4  0 256   7     -1    128   1     128   -1
f5  0 256   7     1     64    1     0     -1    192   -1
f6  0 8192  7     0     2048  0     0     -1    2048  -1    0     1     2048  1     0     0     2048  0

; Distortion Table
f7  0 1024  8     -.8   42    -.78  400   -.7   140   .7    400   .78   42    .8 

; score ***************************************************

t       0       400   

; PWM Filter
;        Dur Amp   Pitch   Filter cut-off  Resonance  Table
;i2    0   8  5000   8.05       100             20         2

; Table Filter
;        Dur Amp   Pitch   Filter cut-off  Resonance  Table
;i1    8   1  5000   8.02        90             30         3
;i1    +   .  .      8.03        80             35         3
;i1    .   .  .      8.00        70             40         3
;i1    .   .  .      7.10        60             45         3

; Distortion Filter
;        Dur Amp     Pitch   Filter cut-off  Resonance  Table
;i3   12   1  5000    6.05         5            50        3
;i3    +   .  <       6.02        <             .         3
;i3    .   .  <       7.03        <             .         3
;i3    .   .  <       6.05        <             .         3
;i3    .   .  <       6.03        <             .         3
;i3    .   .  <       6.03        <             .         3
;i3    .   .  <       6.02        <             .         3
;i3    .   . 8000     6.00       100            20        3

; Filtered Noise
;i4   20   8 5000                100           100

; Filtered Buzz
;i5   28   4 10000     8.03       100            20        10

; 4 Pole Filter
;  Start Dur Amp    Pitch  Fco1  Rez1  Fco2  Rez2  Table   
;i7  40    2  3000   8.00    70    20     50    10     3
;i7   +    4  1800   8.03    60    22     60    12     2
