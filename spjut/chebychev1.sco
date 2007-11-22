f1  0 8192  10    1  
f2  0 4097  13    1     1     0     5     0     4     0     3     0     2     0     1 ; THE ODD HARMONICS
f3  0 4097  13    1     1     0     4     0     3     0     2 ; THE EVEN HARMONICS
i1  0  0.5    220

;The display command is just to prove that the instrument works. Comment it
;out for real use.

;Finally for Kim Cascone's math request: Start with a signal or waveform
;such as a sine wave with a mean of exactly zero and has a positive-negative
;symmetry, i.e., you can get the negative half of the waveform by rotations
;and/or translations (but no stretching or compressing) of the positive half
;of the waveform. Call the signal x(t) or just x for short. Use x as the
;input to a waveshaping function y.

;If y is an ODD function, meaning that y(-x) = -y(x) (e.g., y = x) then any
;stretching or distorting of the positive half of the waveform will be
;EXACTLY counterbalanced by identical stretching or distorting of the
;negative half of the waveform.

;If y is an EVEN function, meaning that y(-x) = y(x) (e.g., y = x^2) then
;the negative half of the waveform will be reflected about the the time axis
;and become positive before any stretching or distorting takes place.
;Electrical engineers would say that the waveform is full-wave rectified
;before being shaped. Full-wave rectification ALWAYS gives rise to a DC
;offset in a finite signal.

;The even-numbered (T)Chebychev polynomials (e.g., T0, T2, T4, ...) are all
;even functions. The odd-numbered polynomials (e.g., T1, T3, T5, ...) are
;all odd functions. A linear combination of odd functions is an odd
;function. A linear combination of even functions is an even function.
;That's why even harmonics in GEN 13 add DC and odd harmonics do not.

;Erik Spjut
