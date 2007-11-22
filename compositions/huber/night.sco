;  Song name:		Grooving Night
;  Tempo:		103 bpm
;  Duration:		8 min 46 s
;  Composer:		Thomas Huber
;  Email:		huber@iamexwi.unibe.ch / thuber@gmx.ch
;  Last changed:	16.5.99


; Tables
f0  526
f1  0 8192  10    1                     ; Sinus
f2  0 256   7     0     128   1     0     -1    128   0 ; Sawtooth
f3  0 256   5     0.001 255   1         ; Exponential

; Compressor lookup table
; Amplitudes on x-axis, gain factors on y axis
; Note that amplitudes are scaled by 1/10
;
; Amplitude:	Gain factor
; 0-1000:	1.2	    don't compress small levels
; 1000-19000    1.2...0.75  decrease gain with increasing amplitude (compress)
; 19000-39000	0.75..0.45  stronger compression for high levels
; The table goes above 3200 because the table length has to be a power
; of two.
f10 0 8192  7     1.2   100   1.2   1800  0.75  2000  0.45  1100  0.4   3192  0.4


; Effects & Processors
; Hall Unit
; Parameters:       Roomsize   Diffusion  Reflectivity	Cutoff  Amount Gain
i98 0.00      526    1.8    0.45   0.95   600    -8     11  

; Mixer/Compressor
; Parameters:		Attack	Release (compressor timings)
i99 0.00      526    0.05   0.5
e

