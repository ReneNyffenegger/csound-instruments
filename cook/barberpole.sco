f01 0 4097  -7    1     4096  0         ; Ramp down
f02 0 4097  -7    0     4096  1         ; Ramp up
f03 0 4097  19    .5    1     0     0   ; Half Sine

;Mode: 1=Up 2=Down

;     Strt  Leng  Levl  Depth Rate  Fdbk  Mode
i01 0.00      1.50   0.75   5.00   0.67   0.50   1 
i01 2.00      .      .      .      .      0.66   2 
i01 4.00      .      .      2.50   6.70   .      1    
e