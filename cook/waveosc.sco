;Terrain Tables
f01 0 4097 10 1 ; Sine
f02 0 4097 10 10 1 0 8 0 0 12 7 5 3 1 5 0 0 6
f03 0 32769 10 0 0 0 0 0 0 0 0 0 0 1 ; 11th Harmonic
f04 0 32769 10 0 0 0 0 0 0 0 0 0 0 0 1 ; 12th Harmonic
f05 0 4097 10 0 7 5 0 2 2 2 1
f06 0 4097 10 1 2 3 4 5 6 7 8 ; Rising Harmonics

;Index Tables
f50 0 4097 10 1 ; Sine
f51 0 4097 7 0 1024 1 2048 -1 1024 0 ; Tri
f52 0 4097 7 -1 4096 1 ; Ramp

;     Strt  Leng  Levl  Pitch Mod1  Mod2  Amp1  Amp2  TabI  TabR
i01   0.00  4.00  1.00  06.00 0.50  0.50  .0833 1.00  50    03
i01   4.00  .     .     .     0.25  0.75  0.10  0.20  .     05
e