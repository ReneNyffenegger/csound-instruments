; Risset's score for a bell-like sound

; Amplitude envelope with extended guard point
f1  0 513   5     1024  512   1 

; Waveform for fundamental and partials
f2  0 512   9     1     1     0   

;       start   dur     freq    amp
i1  1  4      633    2500
i.  +  .      211  
i.  +  .      999  
s
i1  1  4      633    1500
i2  1  4      211    1500
i3  1  4      999    1500
i4  1  4      80     1500
e
