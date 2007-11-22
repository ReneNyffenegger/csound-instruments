; basicfm.s

; exponentially decaying amplitude envelope for carrier signal
f1  0 512   5     1     512   .001

; amplitude envelope for frequency modulation
f2  0 512   7     1     64    0     448   0 

; waveform of carrier signal
f3  0 512   9     1     1     0   


;       start   dur     carrier_freq    amp     fm_factor       mod_index
i1  1  5      7.06   25000  1      4    
i1  7  5      7.06   .      1.414  4
e
